//
//  BOJ-7562
//  백준 7562번 - 나이트의 이동
//
//  Created by 손지영 on 2026/02/16
//  난이도: 실버1 | 소요시간: 18분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/7562
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - (2, -1), (1, -2), (-2, -1), (-1, -2), (2, 1), (1, 2), (-2, 1), (-1, 2) 로 이동 가능
///     - 몇번 이동해야 도달 가능한지
/// 2. 자료구조
///     - queue [Point]
///     - dist [[Int]] // -1: 미방문, >= 0 최단 거리
/// 3. 시간복잡도
///     - O(L^2 * t)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let t = Int(readLine()!)!
    
    typealias Point = (y: Int, x: Int)
    let move = [Point(y: 2, x: -1), Point(y: 1, x: -2), Point(y: -2, x: -1), Point(y: -1, x: -2), Point(y: 2, x: 1), Point(y: 1, x: 2), Point(y: -2, x: 1), Point(y: -1, x: 2)]
    
    for _ in 0..<t {
        let l = Int(readLine()!)!
        let cur = readLine()!.split(separator: " ").map { Int($0)! }
        let target = readLine()!.split(separator: " ").map { Int($0)! }
        
        var dist = Array(repeating: Array(repeating: -1, count: l), count: l)
        
        var queue = [Point]()
        var head = 0
        
        dist[cur[0]][cur[1]] = 0
        queue.append(Point(y: cur[0], x: cur[1]))
        
        while head < queue.count {
            let (y, x) = queue[head]
            
            if y == target[0] && x == target[1] { break }
            
            head += 1
            
            for (dy, dx) in move {
                let ny = y + dy
                let nx = x + dx
                
                guard ny >= 0, ny < l, nx >= 0, nx < l else { continue }
                guard dist[ny][nx] == -1 else { continue }
                dist[ny][nx] = dist[y][x] + 1
                queue.append(Point(y: ny, x: nx))
            }
        }
        
        print(dist[target[0]][target[1]])
    }
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
