//
//  BOJ-15652
//  백준 15652번 - N과 M (4)
//
//  Created by 손지영 on 2026/02/16
//  난이도: 실버3 | 소요시간: 10분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/15652
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 같은수를 여러번 골라도 됨
///     - 1, 2 == 2, 1
///     - 비내림차순 = 오름차순
///     for i in start..n
///         temp.append(i)
///         dfs(i)
///         temp.removeLast
/// 2. 자료구조
///     - rs String
///     - temp [Int]
/// 3. 시간복잡도
///     - O(C(M, N))
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let target = input[1]
    let c = Array(0...n)
    
    var rs = ""
    var temp = [Int]()
    
    func dfs(_ start: Int) {
        if temp.count == target {
            rs += temp.map { String($0) }.joined(separator: " ") + "\n"
            return
        }
        
        for i in start...n {
            temp.append(i)
            dfs(i)
            temp.removeLast()
        }
    }
    
    dfs(1)
    
    print(rs)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
