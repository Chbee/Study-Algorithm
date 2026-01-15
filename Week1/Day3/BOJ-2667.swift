//
//  BOJ-2667
//  백준 2667번 - 단지번호붙이기
//
//  Created by 손지영 on 2026/01/14 21:50
//  난이도: 실버1 | 소요시간: 40분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2667
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 아이디어
//      - 인접한거 찾기. 안익숙한 bfs로 풀어보기
//      - 내가 1일 때 상화좌우 탐지후 이동 가능하면 queue에 담기
//      - queue를 하나씩 pop하면 인자값 계속 찾기
//      - 모든 인자 확인 불가능하면 옆 노트 탐색 시작 (+ 1)
//      - 다음 노드로 넘어갈때.. 초기화 해야할것이 있을까?
//          - queue의.. head?
// 2. 자료구조
//      - grid [[Int]]
//      - 방문여부 [[Bool]]
//      - 집의 수 [Int]
//      - Queue: [(Int, Int)]
// 3. 시간복잡도
//      - grid 탐색: O(N*M)
//      - 정렬: O(NlogN)
//          ~= 25*25 + 25log25 ~= 625 + log2^5 ~= 625 + 5 ~= 630 ~= 7e2
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var grid = Array(repeating: [Int](), count: n)
    
    for i in 0..<n {
        grid[i].append(contentsOf: readLine()!.map({ Int(String($0))! }))
    }
    
    var chk = Array(repeating: Array(repeating: false, count: n), count: n)
    
    typealias Point = (y: Int, x: Int)
    
    var result = [Int]()
    
    let dy = [0, -1, 0, 1]
    let dx = [1, 0, -1, 0]
    
    func bfs(y: Int, x: Int) {
        var queue = [Point]()
        var cnt = 0
        var head = 0
        
        if (grid[y])[x] == 1 && (chk[y])[x] == false {
            queue.append(Point(y: y, x: x))
            (chk[y])[x] = true
        }
        
        while head < queue.count {
            let point = queue[head]
            head += 1
            cnt += 1
            
            for i in 0..<4 {
                let ny = point.y + dy[i]
                let nx = point.x + dx[i]
                
                guard ny >= 0, ny < n, nx >= 0, nx < n else { continue }
                
                if (grid[ny])[nx] == 1 && (chk[ny])[nx] == false {
                    queue.append(Point(y: ny, x: nx))
                    (chk[ny])[nx] = true
                }
            }
        }
        
        result.append(cnt)
    }
    
    for y in 0..<n {
        for x in 0..<n {
            if (grid[y])[x] == 1 && (chk[y])[x] == false {
                bfs(y: y, x: x)
            }
        }
    }
    
    print(result.count)
    
    for v in result.sorted() {
        print(v)
    }
    
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
// queue를 어떻게 다룰지가 조금 어렵다.
