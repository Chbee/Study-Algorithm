//
//  BOJ-2178
//  백준 2178번 - 미로 탐색
//
//  Created by 손지영 on 2026/01/31
//  난이도: 실버1 | 소요시간: 50분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2178
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - (1, 1) -> (N, M): BFS/다익스트라
///     - 지나야하는 최소 "칸"수, 1인것만 지나갈 수 있음. 인접한것만 지나갈 수 있음
///     - 시작위치, 도착 위치 포함하여 칸 수
///     - edge (v, nv) - 현재 노드, 다음 노드
///     - queue = [Edge]
///     - head = queue 멈출 포인터
///     - value Int
///
/// 2. 자료구조
///     queue[edge]
///     edge (Int, Int)
///     minV Int
/// 3. 시간복잡도
///     O(N*M) ~= 100*100 = 10000 = 1e4 이므로 충분
// ============================================
// 📌 주의사항
// ============================================
//
// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let m = input[0]
    let n = input[1]
    
    var graph = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
    var dist = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
    
    for y in 1...m {
        let line = Array(readLine()!)
        for x in 1...n {
            graph[y][x] = (line[x - 1] == "1") ? 1 : 0
        }
    }
    
    var queue: [(Int, Int)] = [(1, 1)]
    dist[1][1] = 1
    var head = 0
    
    var minVal = 1
    
    let dy = [0, -1, 0, 1]
    let dx = [1, 0, -1, 0]
    
    while head < queue.count {
        let (y, x) = queue[head]
        head += 1
        
        for i in 0..<4 {
            let ny = y + dy[i]
            let nx = x + dx[i]
            
            if ny < 1 || ny > m || nx < 1 || nx > n { continue }
            
            if graph[ny][nx] == 1, dist[ny][nx] == 0 {
                dist[ny][nx] = dist[y][x] + 1
                queue.append((ny, nx))
            }
        }
        
    }
    
    print(dist[m][n])
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
/// BFS는 방문 여부를 꼭 확인해야한다. 방문 여부 확인은 꼭 Bool 타입일 필요는 없다. 하지만 그러면 좋다.

/*
swift BOJ-2178.swift <<EOF
4 6
110110
110110
111111
111101
EOF
*/
