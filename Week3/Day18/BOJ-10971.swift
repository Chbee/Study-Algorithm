//
//  BOJ-10971
//  백준 10971번 - 외판원 순회 2
//
//  Created by 손지영 on 2026/02/11
//  난이도: 실버2 | 소요시간: 30분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/10971
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 도시를 모두 거쳐 원래대로 돌아오는 순회 여행 경로 확인
///     - 중복 방문 안됨, 길이 없을 수도 있음
///     - 비용: W[i][j], 갈수 없는 경우는 W[i][j] = 0
///     - 가장 적은비용
/// 2. 자료구조
/// 3. 시간복잡도
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var w = Array(repeating: Array(repeating: 0, count: n + 1), count: n + 1)
    var visited = Array(repeating: false, count: n + 1)
    
    for i in 1...n {
        let row = readLine()!.split(separator: " ").map { Int($0)! }
        for j in 1...n {
            w[i][j] = row[j - 1]
        }
    }
    
    let start = 1
    var rs = Int.max
    visited[start] = true
    
    func dfs(_ current: Int, _ visitedCount: Int, _ cost: Int) {
        if cost >= rs { return }
        
        if visitedCount == n {
            if w[current][start] != 0 {
                rs = min(rs, cost + w[current][start])
            }
            return
        }
        
        for i in 1...n {
            if visited[i] || w[current][i] == 0 { continue }
            
            visited[i] = true
            dfs(i, visitedCount + 1, cost + w[current][i])
            visited[i] = false
        }
    }
    
    dfs(start, 1, 0)
    print(rs)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
