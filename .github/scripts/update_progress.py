#!/usr/bin/env python3
import re
from pathlib import Path

def parse_day_readme(path: Path):
    text = path.read_text(encoding="utf-8")
    lines = text.splitlines()

    in_goals = False
    goals_total = 0
    goals_done = 0
    for line in lines:
        if line.strip().startswith("##") and "학습 목표" in line:
            in_goals = True
            continue
        if in_goals:
            if line.strip().startswith("##"):
                break
            m = re.match(r"^\s*-\s*\[([ xX])\]\s+.*$", line)
            if m:
                goals_total += 1
                if m.group(1).lower() == "x":
                    goals_done += 1

    in_table = False
    rows = []
    for line in lines:
        if line.strip().startswith("| 문제"):
            in_table = True
            continue
        if in_table:
            if not line.strip().startswith("|"):
                break
            # skip separator row
            if re.match(r"^\|[-\s]+\|", line.strip()):
                continue
            rows.append(line)

    total = 0
    solved = 0
    for row in rows:
        parts = [p.strip() for p in row.strip().strip("|").split("|")]
        if len(parts) < 3:
            continue
        status = parts[2]
        total += 1
        # Treat any status other than "-" or "⏳" as completed
        if status and status not in {"-", "⏳"}:
            solved += 1

    problems_completed = total > 0 and solved == total
    goals_completed = goals_total > 0 and goals_done == goals_total
    completed = goals_completed if goals_total > 0 else problems_completed
    return total, solved, completed

def update_root_readme(root_path: Path, day_status, week_counts):
    text = root_path.read_text(encoding="utf-8")
    lines = text.splitlines()

    # Update day completion checkboxes
    day_map = {day: status for day, status in day_status.items()}
    updated_lines = []
    day_pattern = re.compile(r"^(\s*- \[)([ xX])\](\s*Day\s+(\d+)\s*:)\s*(.*)$")
    for line in lines:
        m = day_pattern.match(line)
        if m:
            day_num = int(m.group(4))
            if day_num in day_map:
                new_mark = "x" if day_map[day_num] else " "
                line = f"{m.group(1)}{new_mark}]{m.group(3)} {m.group(5)}"
        updated_lines.append(line)

    # Update stats
    def replace_stat(line, label, solved):
        pattern = re.compile(rf"^(\s*- \*\*{re.escape(label)}\*\*:\s*)(\d+)(\s*/\s*)(\d+)(.*)$")
        m = pattern.match(line)
        if not m:
            return line
        return f"{m.group(1)}{solved}{m.group(3)}{m.group(4)}{m.group(5)}"

    total_solved = sum(week_counts.values())
    final_lines = []
    for line in updated_lines:
        line = replace_stat(line, "총 문제 수", total_solved)
        for week, solved in week_counts.items():
            line = replace_stat(line, f"Week {week}", solved)
        final_lines.append(line)

    root_path.write_text("\n".join(final_lines) + "\n", encoding="utf-8")


def main():
    repo_root = Path(__file__).resolve().parents[2]
    day_readmes = sorted(repo_root.glob("Week*/Day*/README.md"))

    day_status = {}
    week_counts = {}
    for path in day_readmes:
        week_match = re.search(r"Week(\d+)", str(path))
        day_match = re.search(r"Day(\d+)", str(path))
        if not week_match or not day_match:
            continue
        week = int(week_match.group(1))
        day = int(day_match.group(1))

        total, solved, completed = parse_day_readme(path)
        day_status[day] = completed
        week_counts[week] = week_counts.get(week, 0) + solved

    root_readme = repo_root / "README.md"
    if root_readme.exists():
        update_root_readme(root_readme, day_status, week_counts)

if __name__ == "__main__":
    main()
