//
//  BOJ-14889
//  백준 14889번 - 스타트와 링크
//
//  Created by 손지영 on 2026/02/14
//  난이도: 실버1 | 소요시간: 47분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/14889
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 능력의 차이를 최소 = 비용의 최소
///     - 능력치 합을 2개 구했을 때, 그 값을 min으로 계속 업데이트 해야함.
///     - 1, 2와 2, 1은 다름
/// 2. 자료구조
///     - map [[Int]]
///     - selected [Bool]
///     - rs Int
/// 3. 시간복잡도
///     - DFS탐색: 2^N
///     - 각 조합별 계산: N^2
///     - O(N^2 * 2^N)
///         -> 20^2 * 2^20
///             ~= 20^2 * 10^6
///             ~= 4e2 * 1e6
///             ~= 4e8
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var map = [[Int]]()
    
    for _ in 0..<n {
        map.append(readLine()!.split(separator: " ").map { Int($0)! })
    }
    
    var selected = Array(repeating: false, count: n)
    var rs = Int.max
    
    func dfs(_ idx: Int, count: Int = 0) {
        if count == n / 2 {
            var sumA = 0
            var sumB = 0
            
            for i in 0..<n {
                for j in i+1..<n {
                    if selected[i] && selected[j]
                    {
                        sumA += map[j][i] + map[i][j]
                    }
                    else if !selected[i] && !selected[j]
                    {
                        sumB += map[j][i] + map[i][j]
                    }
                }
            }
            
            rs = min(rs, abs(sumA - sumB))
            
            return
        }
        
        for i in idx..<n {
            selected[i] = true
            dfs(i + 1, count: count + 1)
            selected[i] = false
        }
    }
    
    dfs(0)
    
    print(rs)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
