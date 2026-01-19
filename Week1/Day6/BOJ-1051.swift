//
//  BOJ-1051
//  백준 1051번 - 숫자 정사각형
//
//  Created by 손지영 on 2026/01/19
//  난이도: 실버3 | 소요시간: 80분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1051
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 꼭지점의 수가 모두 같은 가장큰 정사각형 찾기
//      - 최대는 NxM
//      - 없으면 1 출력
//      - N과 M중에 작은 값으로 확인 시작
//          -> 3X5면 3으로 확인 시작. ((0, 2) (2, 2) (2, 0) (0, 0))이 하나의 정사각형. 이 모든 수가 같아야함
//          -> 모든 수가 다르면 index가 4가될때까지 +1
//          -> 그럼에도 못찾으면 2로 확인 시작
//              == 1부터 min(N,M)으로 반복문
// 2. 자료구조
//      - grid [[Int]] 0-based
//      - max Int
// 3. 시간 복잡도
//      - O(N*M) = 50*50 = 2500 = 25e2 충분.

// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let size = readLine()!.split(separator: " ").map { Int($0)! }
    let n = size[0]; let m = size[1]
    let len = min(n, m)
    
    var grid = Array(repeating: [Int](), count: n)
    
    for i in 0..<n {
        grid[i] = readLine()!.map { Int(String($0))! }
    }
    
    var col = 0
    var row = 0
    
    var d = len - 1
    
    var found = false
    
    while (col + d) < m && (row + d) < n && d > 0 {
        let point1 = (grid[row])[col]
        let point2 = (grid[row])[col + d]
        let point3 = (grid[row + d])[col]
        let point4 = (grid[row + d])[col + d]
        
        if point1 == point2 && point2 == point3 && point3 == point4 && point4 == point1 {
            found = true
            break
        } else {
            if col + 1 + d >= m {
                if row + 1 + d >= n {
                    col = 0
                    row = 0
                    d -= 1
                } else {
                    col = 0
                    row += 1
                }
            } else {
                col += 1
            }
        }
    }
    
    print(found ? (d+1)*(d+1) : 1)
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
// 그리드 탐색.. index 계산하는게 헷갈림
