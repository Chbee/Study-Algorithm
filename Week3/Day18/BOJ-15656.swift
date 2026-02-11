//
//  BOJ-15656
//  백준 15656번 - N과 M (7)
//
//  Created by 손지영 on 2026/02/11
//  난이도: 실버3 | 소요시간: 13분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/15656
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 같은수를 여러번 골라도 되는 수열
///     - DFS. 모든 수 선택
/// 2. 자료구조
///     - temp [Int]
/// 3. 시간복잡도
///     - O(N^M)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]
    
    let s = readLine()!.split(separator: " ").map({ Int($0)! }).sorted()
    
    var temp = [Int]()
    var rs = [String]()
    
    func dfs() {
        if temp.count == m {
            rs.append(temp.map({ String($0) }).joined(separator: " "))
            return
        }
        for i in 0..<n {
            temp.append(s[i])
            dfs()
            temp.removeLast()
        }
    }
    
    dfs()
    
    print(rs.joined(separator: "\n"))
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
