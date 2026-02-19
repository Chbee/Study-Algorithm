//
//  BOJ-15661
//  백준 15661번 - 링크와 스타트
//
//  Created by 손지영 on 2026/02/19
//  난이도: 골드5 | 소요시간: 11분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/15661
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 인원수는 같지 않아도 되지만 한명 이상이어야함
///     - 팀 능력치 차이의 최솟값
/// 2. 자료구조
///     - map [[Int]]
///     - visitied [Int]
///     - minVal Int
/// 3. 시간복잡도
///     - O(N^2)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var map = [[Int]]()
    var minVal = Int.max
    
    for _ in 0..<n {
        map.append(readLine()!.split(separator: " ").map { Int($0)! })
    }
    
    var visited = Array(repeating: false, count: n)
    for c in 1..<n {
        dfs(start: 0, count: 0, target: c)
    }
    
    func dfs(start: Int, count: Int, target: Int) {
        if count == target {
            
            var a = 0
            var b = 0
            
            for i in 0..<n {
                for j in i+1..<n {
                    if visited[i] && visited[j] {
                        a += map[i][j] + map[j][i]
                    } else if !visited[i] && !visited[j] {
                        b += map[i][j] + map[j][i]
                    }
                }
            }
            
            minVal = min(minVal, abs(a - b))
            return
        }
        
        for i in start..<n {
            visited[i] = true
            dfs(start: i + 1, count: count + 1, target: target)
            visited[i] = false
        }
    }
    
    print(minVal)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
