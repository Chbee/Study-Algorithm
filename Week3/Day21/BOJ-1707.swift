//
//  BOJ-1707
//  백준 1707번 - 이분 그래프
//
//  Created by 손지영 on 2026/02/27
//  난이도: 골드4 | 소요시간: 33분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1707
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 정점의 집합을 인접하지 않도록 둘로 분할. -> 이분 그래프
///     - 이분 그래프 판별
///     - 간선에 대한 정보, 분리 되는지 확인 필요
///     - 양방향으로 연결되어있지 않으면 분리되어 있는것으로 간주.
///     - for (u, v) in graph
///         if visited[v] == 0
///             visited[v] = -visited[u]
///             재귀(v)
///         else if visited[v] == visited[u]
///             이분그래프가 될 수 없음
///             return
/// 2. 자료구조
///     - graph [[Int]]
///     - bipartite [Int]
///     - rs Bool
/// 3. 시간복잡도
///     - O(V+E)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let t = Int(readLine()!)!
    
    for _ in 0..<t {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        // 정점의 개수와 간선의 개수
        let v = input[0]; let e = input[1];
        
        var graph = Array(repeating: [Int](), count: v + 1)
        /// 0: 미방문, 1: 그룹A, -1: 그룹B
        var bipartite = Array(repeating: 0, count: v + 1)
        
        for _ in 0..<e {
            let input = readLine()!.split(separator: " ").map { Int($0)! }
            let u = input[0]; let v = input[1];
            graph[u].append(v)
            graph[v].append(u)
        }
        
        var rs = true
        
        func searchGraph(_ u: Int) {
            let value = bipartite[u]
            for v in graph[u] {
                if bipartite[v] == 0 {
                    bipartite[v] = -value
                    searchGraph(v)
                } else if bipartite[v] == value {
                    rs = false
                    return
                }
                
            }
        }
        
        for v in 1...v {
            if bipartite[v] != 0 { continue }
            bipartite[v] = 1
            searchGraph(v)
        }
        
        print(rs ? "YES" : "NO")
    }
    
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================

//4 5
//1 3
//1 4
//2 3
//2 4
//1 3
