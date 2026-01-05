import Foundation

// ========================================
// BFS (너비우선탐색) 템플릿
// ========================================

// 1. 기본 BFS
func bfs(_ start: Int) {
    var queue = [start]
    var visited = [Bool](repeating: false, count: n)
    visited[start] = true
    var index = 0
    
    while index < queue.count {
        let node = queue[index]
        index += 1
        
        for next in graph[node] {
            if !visited[next] {
                visited[next] = true
                queue.append(next)
            }
        }
    }
}

// 2. 최단거리 BFS
func bfs2D(_ startX: Int, _ startY: Int) -> Int {
    var queue = [(startX, startY, 0)]  // x, y, distance
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: m), count: n)
    visited[startX][startY] = true
    var index = 0
    
    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, -1, 1]
    
    while index < queue.count {
        let (x, y, dist) = queue[index]
        index += 1
        
        if x == endX && y == endY {
            return dist
        }
        
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            if nx >= 0 && nx < n && ny >= 0 && ny < m {
                if !visited[nx][ny] && map[nx][ny] == 1 {
                    visited[nx][ny] = true
                    queue.append((nx, ny, dist + 1))
                }
            }
        }
    }
    
    return -1
}

// 3. 동시 BFS (토마토 문제 등)
func bfsMultiStart() {
    var queue = [(Int, Int, Int)]()  // x, y, day
    
    // 모든 시작점 큐에 추가
    for i in 0..<n {
        for j in 0..<m {
            if map[i][j] == 1 {
                queue.append((i, j, 0))
            }
        }
    }
    
    var index = 0
    var maxDay = 0
    
    while index < queue.count {
        let (x, y, day) = queue[index]
        index += 1
        maxDay = max(maxDay, day)
        
        // 4방향 탐색...
    }
}
