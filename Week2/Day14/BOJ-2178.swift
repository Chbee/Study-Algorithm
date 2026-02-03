//
//  BOJ-2178
//  백준 2178번 - 미로 탐색
//
//  Created by 손지영 on 2026/02/03
//  난이도: 실버1 | 소요시간: 22분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2178
//

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 1, 1에서 N,M까지 지나야하는 최소한의 칸
///     - BFS?
///     - 양 방향으로 이동시켜봄.
///     - 이동이 가능하면 queue에 담기
///     - head = 0
///     - queue = [(y, x)]
///     - dy, dx로 이동할 수 있을때, 방문하지 않았을 때.
///             0: 방문안함 1: 방문함
/// 2. 자료구조
///     - dy, dx []
///     - queue [(Int, Int)]
///     - dist [Int]
/// 3. 시간복잡도
///     - O(N*M) 100 * 100 = 1e4 충분함
// ============================================
// 📌 주의사항
// ============================================
///
// ============================================
// 🔨 구현
// ============================================
func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let m = input[0]; let n = input[1]
    
    var graph = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
    
    for i in 1...m {
        var row = [0]
        row.append(contentsOf: readLine()!.map { Int(String($0))! })
        graph[i] = row
    }
    
    var dist = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
    
    typealias Point = (y: Int, x: Int)
    
    var queue: [Point] = [(y: 1, x: 1)]
    var head = 0
    
    dist[1][1] = 1
    
    let dy = [0, -1, 0, 1]
    let dx = [1, 0, -1, 0]
    
    while head < queue.count {
        let (y, x) = queue[head]
        head += 1
        
        for i in 0..<4 {
            let ny = y + dy[i]
            let nx = x + dx[i]
            
            if ny < 1 || ny > m || nx < 1 || nx > n { continue }
            
            if dist[ny][nx] == 0 && graph[ny][nx] == 1 {
                dist[ny][nx] = dist[y][x] + 1
                queue.append((y: ny, x: nx))
            }
        }
    }
    
    print(dist[m][n])
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
///
