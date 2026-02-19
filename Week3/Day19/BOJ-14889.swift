//
//  BOJ-14889
//  백준 14889번 - 스타트와 링크
//
//  Created by 손지영 on 2026/02/19
//  난이도: 실버1 | 소요시간: 17분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/14889
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - s[i][j], s[j][i]값은 다를 수 있음
///     - 조합(DFS)으로 N/2명을 한 팀으로 선택
///     - 팀 완성 시 i<j 쌍을 돌며 두 팀 점수 차이 계산
/// 2. 자료구조
///     - s [[Int]]
///     - visited [Bool]
/// 3. 시간복잡도
///     - O(C(N, N/2) * N^2)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!

    var s = [[Int]]()
    for _ in 0..<n {
        s.append(readLine()!.split(separator: " ").map { Int($0)! })
    }

    var visited = Array(repeating: false, count: n)
    var minVal = Int.max

    func dfs(start: Int, count: Int) {
        if minVal == 0 { return }

        if count == n / 2 {
            var a = 0
            var b = 0

            for i in 0..<n {
                for j in (i + 1)..<n {
                    if visited[i] && visited[j] {
                        a += s[i][j] + s[j][i]
                    } else if !visited[i] && !visited[j] {
                        b += s[i][j] + s[j][i]
                    }
                }
            }

            minVal = min(minVal, abs(a - b))
            return
        }

        for i in start..<n {
            visited[i] = true
            dfs(start: i + 1, count: count + 1)
            visited[i] = false
        }
    }

    // A/B 팀 대칭 중복 제거
    visited[0] = true
    dfs(start: 1, count: 1)

    print(minVal)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================

/*
swift BOJ-14889.swift <<EOF
4
0 1 2 3
4 0 5 6
7 1 0 2
3 4 5 0
EOF
 */
