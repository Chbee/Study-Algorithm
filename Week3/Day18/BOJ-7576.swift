//
//  BOJ-7576
//  백준 7576번 - 토마토
//
//  Created by 손지영 on 2026/02/13
//  난이도: 골드5 | 소요시간: 25분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/7576
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 하루가 지나면 인접한 토마토가 익음 토마토가 모두 익는 최소 시간
///     - 모든 곳을 방문 완료 했을 때의 시간을 구하면 됨. 토마토가 없을수도 있음
///     - dy, dx로 인접 방문 및 count + 1
/// 2. 자료구조
///     - map [[Int]]
///     - dist [[Int]] // -1: 미방문, 0~1: 방문횟수 + 1
///     - cnt Int
/// 3. 시간복잡도
///     - O(M*N) 1e3 * 1e3 = 1e6
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let m = input[0]; let n = input[1]
    
    var map = Array(repeating: Array(repeating: 0, count: m + 1), count: n + 1)
    var dist = Array(repeating: Array(repeating: -1, count: m + 1), count: n + 1)
    
    for i in 1...n {
        var s = [0]
        s.append(contentsOf: readLine()!.split(separator: " ").map { Int($0)! })
        map[i] = s
    }
    
    typealias Point = (y: Int, x: Int)
    
    var queue = [Point]()
    var head = 0
    
    let dy = [0, -1, 0, 1]
    let dx = [1, 0, -1, 0]
    
    for j in 1...n {
        for i in 1...m {
            if dist[j][i] == -1 && map[j][i] == 1 {
                dist[j][i] = 0
                queue.append(Point(y: j, x: i))
            }
        }
    }
    
    while head < queue.count {
        let cur = queue[head]
        head += 1
        
        for i in 0..<4 {
            let ny = cur.y + dy[i]
            let nx = cur.x + dx[i]
            
            guard ny > 0, ny <= n, nx > 0, nx <= m else { continue }
            guard dist[ny][nx] == -1, map[ny][nx] == 0 else { continue }
            
            dist[ny][nx] = dist[cur.y][cur.x] + 1
            map[ny][nx] = 1
            
            queue.append(Point(y: ny, x: nx))
        }
    }
    
    var day = -1
    for j in 1...n {
        for i in 1...m {
            if map[j][i] == 0 && dist[j][i] == -1 {
                print(-1)
                return
            }
            day = max(day, dist[j][i])
        }
    }
    
    print(day)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================

/*
swift BOJ-7576.swift <<EOF
6 4
1 -1 0 0 0 0
0 -1 0 0 0 0
0 0 0 0 -1 0
0 0 0 0 -1 1
EOF
 */
