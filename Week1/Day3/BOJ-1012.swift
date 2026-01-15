//
//  BOJ-1012
//  백준 1012번 - 유기농 배추
//
//  Created by 손지영 on 2026/01/14 16:20 / 35분
//  난이도: 실버2 | 소요시간: - | 상태: ⬜
//  링크: https://www.acmicpc.net/problem/1012
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 아이디어
//      - T: 테스트 케이스 만큼 반복.. 밭개수로 이해
//      - M (x), N(y), 배추가 심어져 있는 위치의 개수 (K)
//      - 배추의 위치 (x, y) > K
//      - T만큼 for문. 인접한곳 중복되지 않게 들려야함
//      - dfs. dx dy로 이동해가며 다음것 찾고
//      - 모두 chk가 되었거나, 인접한 곳이 모두 0이거나, 이동할 곳이 n과 m을 넘어가면 다 찾은것으로 간주
//      - 다음 테스트 케이스가 오면 chk, rs 모두 reset
// 2. 자료구조
//      - 밭  graph: [y][x] = [[Int]]
//      - 결과값 : rs: Int
//      - 방문 체크 graph: [[Int]]
// 3. 시간복잡도
//      - O(N + M) ~= O((50 + 50)2) ~= O(N)

// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================


func solution() {
    let t = Int(readLine()!)!
    
    var maps = Array(repeating: [[Int]](), count: t)
    var nList = [Int]()
    var mList = [Int]()
    
    for i in 0..<t {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        
        let m = input[0]
        let n = input[1]
        let k = input[2]
        
        nList.append(n)
        mList.append(m)
        
        var map = Array(repeating: Array(repeating: 0, count: m), count: n)
        
        for _ in 0..<k {
            let input = readLine()!.split(separator: " ").map { Int($0)! }
            let x = input[0]
            let y = input[1]
            (map[y])[x] = 1
        }
        
        maps[i] = map
    }
    
    let dy = [0, -1, 0, 1]
    let dx = [1, 0, -1, 0]
    
    for i in 0..<maps.count {
        dfs(in: maps[i], n: nList[i], m: mList[i])
    }
    
    func dfs(in map: [[Int]], n: Int, m: Int) {
        var result = 0
        var chk = Array(repeating: Array(repeating: false, count: m), count: n)
        
        func dfs_solution(y: Int, x: Int) {
            guard (chk[y])[x] == false else { return }
            (chk[y])[x] = true
            
            for i in 0..<4 {
                let ny = y + dy[i]
                let nx = x + dx[i]
                
                guard ny > 0, ny <= n, nx > 0, nx <= m else { continue }
                
                if (chk[ny])[nx] == false && (map[y])[x] == 1 {
                    // 방문처리?
                    // 필요처리?
                    dfs_solution(y: ny, x: nx)
                }
            }
        }
        
        for y in 0..<n {
            for x in 0..<m {
                if (chk[y])[x] == false && (map[y])[x] == 1 {
                    result += 1
                    dfs_solution(y: y, x: x)
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
