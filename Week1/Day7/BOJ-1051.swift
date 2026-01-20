//
//  BOJ-1051
//  백준 1051번 - 숫자 정사각형
//
//  Created by 손지영 on 2026/01/19 15:12
//  난이도: 실버3 | 소요시간: 30분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1051
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심아이디어
//      - x, y가 1부터 증가하며 찾아야함.
//      - N과 M중에 작은 값으로 먼저 찾고 min(N, M), 실제 길이는 min(N, M) - 1임 -> len
//      - (x,y), (x+len, y), (x, y+len), (x+len, y+len) 이 값이 모두 같아야함.
//          : 값이 다르면 일단 x를 1씩 증가할거임. 근데 x+len이 m을 넘기면 안됨.
//          : 만약 넘긴다면 x를 다시 1로 초기화하고 y를 +1 할것.
//      - 큰사이즈부터 찾으므로 찾자마자 break하고 결과 출력하면 됨
// 2. 자료구조
//      - grid[[Int]]
//      - len Int
// 3. 시간복잡도
//      - (N*M*min(N,M))
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let size = readLine()!.split(separator: " ").map { Int($0)! }
    let n = size[0]; let m = size[1]
    
    var grid = Array(repeating: [Int](), count: n+1)
    
    for i in 1...n {
        var row = [0]
        row.append(contentsOf: readLine()!.map { Int(String($0))! })
        grid[i] = row
    }
    
    if n == 1 || m == 1 {
        print(1)
        return
    }
    
    var len = min(n, m) - 1
    
    var isFound = false
    
    var x = 1
    var y = 1
    
    func findSquare() {
        while len > 0 {
            let topLeft = grid[y][x]
            let topRight = grid[y][x+len]
            let bottomLeft = grid[y+len][x]
            let bottomRight = grid[y+len][x+len]
            
            if topLeft == topRight, topRight == bottomLeft, bottomLeft == bottomRight, bottomRight == topLeft {
                isFound = true
                break
            } else {
                let nx = x + 1
                if nx + len > m {
                    let ny = y + 1
                    if ny + len > n {
                        len -= 1
                        y = 1; x = 1
                    } else {
                        y = ny; x = 1
                    }
                } else {
                    x = nx
                }
            }
        }
    }
    
    findSquare()
    
    print(isFound ? (len+1) * (len+1) : 1)
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================



