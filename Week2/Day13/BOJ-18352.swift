//
//  BOJ-18352
//  백준 18352번 - 특정 거리의 도시 찾기
//
//  Created by 손지영 on 2026/02/02
//  난이도: 실버2 | 소요시간: 43분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/18352
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심 아이디어
/// - 단방향도로, 가중치 1
/// - 도시 X로 부터 도달할 수 있는 모든 도시 중 최단 거리가 정확히 K인 모든 도시들의 번호 -> BFS
/// - 억지로 돌아가는것 안됨!
/// - Edge = (v, nv) = 현재 노드, 연결된 다음 노드
///   while head < queue.count
///       let now = queue[head]
///       head += 1
///
///       for edge in graph[now] {
///           let nv = edge.nv
///           if dist[nv] == -1 {
///               dist[nv] = dist[now] + 1
///               queue.append(nv)
///           }
///       }
///
///     founded == false
///         print(-1)
/// 2. 자료구조
///     graph [(v: nv:)]
///     dist[Int]
///     queue [Int]
///     founded Bool
/// 3. 시간 복잡도
///     O(N + M) = 300_000 + 1_000_000 = 1.3e6
///     충분히 작은 연산량
//
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    
    let n = input[0]
    let m = input[1]
    let k = input[2]
    let x = input[3]
    
    typealias Edge = (v: Int, nv: Int)
    
    var graph = Array(repeating: [Edge](), count: n+1)
    var dist = Array(repeating: -1, count: n+1)
    
    for _ in 0..<m {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let a = input[0]; let b = input[1]
        
        graph[a].append(Edge(v: a, nv: b))
    }
    
    var queue = [x]
    var head = 0
    dist[x] = 0
    
    while head < queue.count {
        let now = queue[head]
        head += 1
        
        for edge in graph[now] {
            let nv = edge.nv
            if dist[nv] == -1 {
                dist[nv] = dist[now] + 1
                queue.append(nv)
            }
        }
    }
    
    var found = false
    for i in 1...n {
        if dist[i] == k {
            found = true
            print(i)
        }
    }
    if found == false { print(-1) }
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================


/*
swift BOJ-18352.swift <<EOF
4 4 1 1
1 2
1 3
2 3
2 4
EOF
 */
