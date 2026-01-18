//
//  BOJ-11123
//  백준 11123번 - 양 한마리... 양 두마리...
//
//  Created by 손지영 on 2026/01/18 15:30
//  난이도: 실버3 | 소요시간: 30분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/11123
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - "그리드"에서 #가 연속되면 탐색 계속.
//          -> 이것이 가능하려면 grid 이중배열로 받아야한다.
//          -> 상하좌우에 #이 있으면 이동.
//      - 무리의 개수는 어떻게 찾을것인가.
//
// 2. 자료구조
//      - grid [[String]]
//      - chk [[Bool]]
//      - count Int
// 3. 시간 복잡도
//      - O(N*M), N, M = 100
//          ~= O(100^2) ~= O(10000) ~= 1e4. 충분

// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let t = Int(readLine()!)!
    
    let dy = [0, -1, 0, 1]
    let dx = [1, 0, -1, 0]
    
    for _ in  0..<t {
        let size = readLine()!.split(separator: " ").map { Int($0)! }
        let h = size[0]; let w = size[1]
        
        var grid = Array(repeating: Array(repeating: ".", count: w), count: h)
        var visited = Array(repeating: Array(repeating: false, count: w), count: h)
        
        for i in 0..<h {
            grid[i] = readLine()!.map { String($0) }
        }
        
        var result = 0
        
        func dfs(y: Int, x: Int) {
            for i in 0..<4 {
                let ny = y + dy[i]
                let nx = x + dx[i]
                
                guard ny >= 0, ny < h, nx >= 0, nx < w else { continue }
                
                if (visited[ny])[nx] == false && (grid[ny])[nx] == "#" {
                    (visited[ny])[nx] = true
                    dfs(y: ny, x: nx)
                }
            }
        }
        
        for y in 0..<h {
            for x in 0..<w {
                if (visited[y])[x] == false && (grid[y])[x] == "#" {
                    (visited[y])[x] = true
                    result += 1
                    dfs(y: y, x: x)
                }
            }
        }
        
        print(result)
    }
    
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
