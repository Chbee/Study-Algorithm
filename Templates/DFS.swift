import Foundation

// ========================================
// DFS (깊이우선탐색) 템플릿
// ========================================

// 1. 인접 리스트 방식
var graph = [[Int]](repeating: [], count: n)
var visited = [Bool](repeating: false, count: n)

func dfs(_ node: Int) {
    visited[node] = true
    print(node, terminator: " ")
    
    for next in graph[node] {
        if !visited[next] {
            dfs(next)
        }
    }
}

// 2. 2차원 배열 방식 (미로, 섬 문제 등)
let dx = [-1, 1, 0, 0]
let dy = [0, 0, -1, 1]

func dfs2D(_ x: Int, _ y: Int) {
    visited[x][y] = true
    
    for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        
        if nx >= 0 && nx < n && ny >= 0 && ny < m {
            if !visited[nx][ny] && map[nx][ny] == 1 {
                dfs2D(nx, ny)
            }
        }
    }
}

// 3. 백트래킹 방식 (순열, 조합)
var result = [Int]()
var visited = [Bool](repeating: false, count: n)

func backtrack(_ depth: Int) {
    if depth == r {
        print(result)
        return
    }
    
    for i in 0..<n {
        if !visited[i] {
            visited[i] = true
            result.append(arr[i])
            backtrack(depth + 1)
            result.removeLast()
            visited[i] = false
        }
    }
}
