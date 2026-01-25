#!/usr/bin/env python3
# .github/scripts/update-day-readme.py

import argparse
import re
import subprocess
from dataclasses import dataclass
from pathlib import Path
from typing import Optional, List, Set


# -----------------------------
# Parsing (Swift header)
# -----------------------------

@dataclass(frozen=True)
class ProblemMeta:
    boj_id: str          # "2309"
    level: str           # "브론즈1"
    time: str            # "20분"
    status_mark: str     # "✅"
    swift_path: Path     # repo-relative path to the swift file


STATUS_MAP = {
    "완료": "✅",
    "진행중": "🟡",
    "미완": "⬜️",
}

BOJ_ID_RE = re.compile(r"\bBOJ-(\d+)\b")
META_LINE_RE = re.compile(
    r"난이도:\s*(?P<level>[^|]+)\s*\|\s*소요시간:\s*(?P<time>[^|]+)\s*\|\s*상태:\s*(?P<status>.+?)\s*$"
)


def parse_swift_header(swift_file: Path) -> Optional[ProblemMeta]:
    """
    Swift 파일 상단 주석 블록에서 문제 메타데이터를 추출.
    - 문제번호: BOJ-2309 -> 2309
    - 난이도/소요시간/상태: "난이도: ... | 소요시간: ... | 상태: ..."
    """
    text = swift_file.read_text(encoding="utf-8", errors="ignore")

    # BOJ-2309
    id_match = BOJ_ID_RE.search(text)
    if not id_match:
        return None
    boj_id = id_match.group(1).strip()

    # 난이도/소요시간/상태
    level = time = status_raw = None
    for raw_line in text.splitlines():
        # 예: "//  난이도: 브론즈1 | 소요시간: 20분 | 상태: 완료"
        line = raw_line.strip().lstrip("/").strip()
        m = META_LINE_RE.search(line)
        if m:
            level = m.group("level").strip()
            time = m.group("time").strip()
            status_raw = m.group("status").strip()
            break

    if not (level and time and status_raw):
        return None

    status_mark = STATUS_MAP.get(status_raw, status_raw)

    return ProblemMeta(
        boj_id=boj_id,
        level=level,
        time=time,
        status_mark=status_mark,
        swift_path=swift_file,
    )


# -----------------------------
# Git helpers
# -----------------------------

NULL_SHA = "0000000000000000000000000000000000000000"


def run_git(*args: str) -> str:
    return subprocess.check_output(["git", *args], text=True).strip()


def normalize_base_sha(base: str, head: str) -> str:
    """
    push 이벤트에서 before가 NULL_SHA(브랜치 최초 push 등)인 케이스 방어.
    - 가능하면 head~1로 대체
    - 실패하면 최초 커밋으로 대체
    """
    if not base or base.startswith(NULL_SHA):
        try:
            return run_git("rev-parse", f"{head}~1")
        except Exception:
            return run_git("rev-list", "--max-parents=0", head).splitlines()[-1]
    return base


def list_changed_swift_files(base: str, head: str) -> List[Path]:
    """
    base..head 사이 변경된 swift 파일들 반환 (추가/수정/이동 포함).
    """
    out = run_git("diff", "--name-only", f"{base}..{head}")
    files: List[Path] = []
    for line in out.splitlines():
        p = Path(line.strip())
        if p.suffix == ".swift" and p.exists():
            files.append(p)
    return files


def list_changed_readme_files(base: str, head: str) -> List[Path]:
    """
    base..head 사이 변경된 README.md 파일들 반환.
    """
    out = run_git("diff", "--name-only", f"{base}..{head}")
    files: List[Path] = []
    for line in out.splitlines():
        p = Path(line.strip())
        if p.name == "README.md" and p.exists():
            files.append(p)
    return files


# -----------------------------
# README table update
# -----------------------------

def find_target_readme(swift_file: Path) -> Optional[Path]:
    """
    기본 전략:
    1) Swift 파일이 있는 폴더의 README.md
    2) 없으면 상위로 올라가며 README.md를 찾음
    """
    candidate = swift_file.parent / "README.md"
    if candidate.exists():
        return candidate

    for parent in swift_file.parents:
        cand = parent / "README.md"
        if cand.exists():
            return cand
    return None


def find_table_bounds(lines: List[str], section_title: str = "### 푼 문제") -> Optional[tuple[int, int, int, int, int]]:
    """
    section_title 아래의 마크다운 테이블 범위를 찾는다.

    반환:
      (section_line, header_line, sep_line, data_start, data_end_exclusive)
    """
    sec = None
    for i, line in enumerate(lines):
        if line.strip() == section_title:
            sec = i
            break
    if sec is None:
        return None

    header_i = sec + 1
    sep_i = sec + 2
    if header_i >= len(lines) or sep_i >= len(lines):
        return None

    if not lines[header_i].lstrip().startswith("|") or not lines[sep_i].lstrip().startswith("|"):
        return None

    data_start = sep_i + 1
    data_end = data_start
    while data_end < len(lines):
        s = lines[data_end].strip()
        if not s:
            break
        if s.startswith("## "):
            break
        if not s.startswith("|"):
            break
        data_end += 1

    return (sec, header_i, sep_i, data_start, data_end)


def parse_row_cells(row_line: str) -> List[str]:
    # "| a | b |" -> ["a", "b"]
    return [c.strip() for c in row_line.strip().strip("|").split("|")]


def build_row(problem_cell: str, meta: ProblemMeta, readme_path: Path) -> str:
    """
    링크 컬럼은 '문제 링크'가 아니라 '풀이 파일(.swift) 링크'로 만든다.
    README 위치 기준으로 상대경로를 계산해, 폴더 구조가 달라도 링크가 깨지지 않게 한다.
    """
    rel = meta.swift_path.as_posix()
    try:
        rel = meta.swift_path.relative_to(readme_path.parent).as_posix()
    except ValueError:
        # 서로 다른 루트/예외 케이스면 원래 경로 사용
        rel = meta.swift_path.as_posix()

    link_cell = f"[풀이](./{rel})" if not rel.startswith(".") else f"[풀이]({rel})"
    return f"| {problem_cell} | {meta.level} | {meta.status_mark} | {meta.time} | {link_cell} |\n"


def update_readme_table(readme_path: Path, meta: ProblemMeta) -> bool:
    """
    README의 '### 푼 문제' 테이블에서 BOJ-xxxx 행을 찾아 업데이트.
    - 있으면: 난이도/상태/소요시간/링크 갱신 (문제 칼럼 텍스트는 유지)
    - 없으면: 새 행 추가 (문제 칼럼은 최소 BOJ-xxxx)
    변경되면 True.
    """
    lines = readme_path.read_text(encoding="utf-8").splitlines(True)
    bounds = find_table_bounds(lines, section_title="### 푼 문제")
    if not bounds:
        return False

    _, _, _, data_start, data_end = bounds
    target_token = f"BOJ-{meta.boj_id}"

    # 1) 기존 행 업데이트
    for i in range(data_start, data_end):
        row = lines[i].strip()
        if target_token in row:
            cells = parse_row_cells(lines[i])
            if len(cells) < 5:
                continue

            # 문제 셀은 기존 유지 (예: "BOJ-2309 일곱 난쟁이")
            problem_cell = cells[0].strip() if cells[0].strip() else target_token

            new_line = build_row(problem_cell, meta, readme_path)
            if lines[i] != new_line:
                lines[i] = new_line
                readme_path.write_text("".join(lines), encoding="utf-8")
                return True
            return False

    # 2) 없으면 append
    new_line = build_row(target_token, meta, readme_path)
    lines.insert(data_end, new_line)
    readme_path.write_text("".join(lines), encoding="utf-8")
    return True


GOAL_LINE_RE = re.compile(
    r"^(?P<prefix>\s*-\s*\[)(?P<check>[ xX])(\]\s*)(?P<rest>.*문제\s*풀이\s*\()"
    r"(?P<done>\d+)\s*/\s*(?P<total>\d+)\s*완료(?P<suffix>\).*)$"
)


def is_row_completed(cells: List[str]) -> bool:
    """
    소요시간이 '-'가 아니면 완료로 본다.
    """
    if len(cells) < 5:
        return False
    return cells[3].strip() != "-"


def update_readme_goal(readme_path: Path) -> bool:
    """
    README의 '학습 목표'에서 문제 풀이 진행도를 갱신.
    - '### 푼 문제' 테이블을 읽어 완료 개수 계산
    - 완료/전체 수치 업데이트
    - 전부 완료 시 체크박스 [x]로 변경
    """
    lines = readme_path.read_text(encoding="utf-8").splitlines(True)
    bounds = find_table_bounds(lines, section_title="### 푼 문제")
    if not bounds:
        return False

    _, _, _, data_start, data_end = bounds
    total = 0
    completed = 0
    for i in range(data_start, data_end):
        row = lines[i].strip()
        if not row.startswith("|"):
            continue
        cells = parse_row_cells(lines[i])
        if len(cells) < 5:
            continue
        total += 1
        if is_row_completed(cells):
            completed += 1

    if total == 0:
        return False

    updated = False
    for i, line in enumerate(lines):
        m = GOAL_LINE_RE.match(line.rstrip("\n"))
        if not m:
            continue

        check = "x" if completed == total else " "
        new_line = (
            f"{m.group('prefix')}{check}] {m.group('rest')}"
            f"{completed}/{total} 완료{m.group('suffix')}\n"
        )
        if lines[i] != new_line:
            lines[i] = new_line
            updated = True
        break

    if updated:
        readme_path.write_text("".join(lines), encoding="utf-8")
    return updated


# -----------------------------
# Main
# -----------------------------

def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--base", required=True)
    ap.add_argument("--head", required=True)
    args = ap.parse_args()

    head = args.head.strip()
    base = normalize_base_sha(args.base.strip(), head)

    changed_swifts = list_changed_swift_files(base, head)
    changed_readmes = list_changed_readme_files(base, head)
    readmes_to_update: Set[Path] = set(changed_readmes)

    for swift in changed_swifts:
        meta = parse_swift_header(swift)
        if not meta:
            continue

        readme = find_target_readme(swift)
        if not readme:
            continue

        update_readme_table(readme, meta)
        readmes_to_update.add(readme)

    for readme in readmes_to_update:
        update_readme_goal(readme)

    # 변경 여부는 워크플로에서 git status로 판단
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
