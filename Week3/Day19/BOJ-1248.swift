//
//  BOJ-1248
//  백준 1248번 - Guess
//
//  Created by 손지영 on 2026/02/16
//  난이도: 골드3 | 소요시간: 70분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1248
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 부호 행렬..이 주어졌을 때 정수의 수열
///     - 수열의 i부터 j까지의 합이 0보다 크면 +
///     - 수열의 i부터 j까지의 합이 0보다 작으면 -
///     - 수열의 i부터 j까지의 합이 두 가지 모두 아니면 0
/// 2. 자료구조
///     - temp [Char]
///     - s [[Char]]
///     - rs [Int]
/// 3. 시간복잡도
///     - O(21^N)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    let temp: [Character] = Array(readLine()!)
    
    var s = Array(repeating: Array(repeating: Character(" "), count: n), count: n)
    
    var idx = 0
    for j in 0..<n {
        for i in j..<n {
            s[j][i] = temp[idx]
            idx += 1
        }
    }
    
    var rs = Array(repeating: 0, count: n)
    var found = false

    func dfs(_ start: Int) {
        if found { return }
        if start == n {
            found = true
            return
        }

        let cur = s[start][start]

        if cur == "0" {
            rs[start] = 0
            if checkValid(start) { dfs(start + 1) }
        } else {
            let range = cur == "+" ? 1...10 : -10...(-1)
            for v in range {
                if found { return }
                rs[start] = v
                if checkValid(start) {
                    dfs(start + 1)
                }
            }
        }
    }
    
    func checkSign(_ n: Int) -> Character {
        if n == 0 { return "0" }
        return n > 0 ? "+" : "-"
    }
    
    func checkValid(_ n: Int) -> Bool {
        var sum = 0
        for i in stride(from: n, through: 0, by: -1) {
            sum += rs[i]
            if checkSign(sum) != s[i][n] { return false }
        }
        return true
    }
    
    dfs(0)
    
    print(rs.map { String($0) }.joined(separator: " "))
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
