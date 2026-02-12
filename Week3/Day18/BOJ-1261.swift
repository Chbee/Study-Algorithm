//
//  BOJ-1261
//  백준 1261번 - 알고스팟
//
//  Created by 손지영 on 2026/02/12
//  난이도: 골드4 | 소요시간: 30분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1261
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 상하좌우 인접한 빈방
///     - AOJ로 빈방으로 만들 수 있음
///     - 최소 몇개의 벽을 부수어야 하는가
///     - 이동할 곳이 없으면 벽을 부순다. (이미 방문했거나 벽이면)
///     - 그 중에서도 비용이 작은 것으로 골라서 부셔야함. -> BFS필요
/// 2. 자료구조
///     - map [[Int]]
///     - dist [[Int]]
///     - visitied [[Bool]]
/// 3. 시간복잡도
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]
    
    var map = Array(repeating: [Int](), count: m)
    
    for j in 0..<m {
        map[j] = readLine()!.map { Int(String($0))! }
    }
    
    var visitied = Array(repeating: Array(repeating: false, count: n), count: m)
    var dist = Array(repeating: Array(repeating: Int.max, count: n), count: m)
    
    let dy = [0, -1, 0, 1]
    let dx = [1, 0, -1, 0]
    
    typealias Point = (y: Int, x: Int)
    
    var queue = [Point]()
    
    var head = 0
    queue.append(Point(y: 0, x: 0))
    dist[0][0] = 0
    
    while head < queue.count {
        let (y, x) = queue[head]
        
        visitied[y][x] = true
        head += 1
        
        for i in 0..<4 {
            let ny = y + dy[i]
            let nx = x + dx[i]
            
            guard ny >= 0, ny < m, nx >= 0, nx < n else { continue }
            
            let cost = map[ny][nx]
            let d = dist[y][x] + cost
            
            if d < dist[ny][nx] {
                dist[ny][nx] = d
                if cost == 0 {
                    queue.insert(Point(y: ny, x: nx), at: head)
                } else {
                    queue.append(Point(y: ny, x: nx))
                }
            }
        }
    }
    
    print(dist[m - 1][n - 1])
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
