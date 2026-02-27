//
//  BOJ-14391
//  백준 14391번 - 종이 조각
//
//  Created by 손지영 on 2026/02/27
//  난이도: 골드3 | 소요시간: 45분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/14391
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 세로나 가로 크기가 1인 직사각형
///     - 가로: 오른쪽 -> 왼쪽, 세로: 위 -> 아래
///     - 적절히 잘라서 합을 "최대"로 하는 프로그램
///     - visitied = true면 가로, false면 세로로 취급
///     - dfs로 모든 칸에 대해 true/false 시도
///     - 한 열의 행을 다 보면 (row == n) 다음 열로 이동 (0, col + 1)
///     - 모든 열을 다 보면 (col == m) 배치의 합을 getSum으로 계산
///     - getSum:
///         - 행 기준: visited == true인 칸들을 이어 숫자로 만듬
///         - 열 기준: visited == fasle인 칸들을 이어 숫자로 만듬
///     - 각 배치의 합 중 최댓값을 rs에 유지
/// 2. 자료구조
///     - map [[Int]]
///     - rs Int
///     - visited [[Bool]]
/// 3. 시간복잡도
///     - O(2^(N*M)) ~= 2^16
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]
    
    var map = [[Int]]()
    var rs = 0
    
    for _ in 0..<n {
        let line = Array(readLine()!)
        map.append(line.map { Int(String($0))! })
    }
    
    var visited = Array(repeating: Array(repeating: false, count: m), count: n)
    
    func dfs(_ row: Int, _ col: Int) {
        if row == n {
            dfs(0, col + 1)
            return
        }
        
        if col == m {
            rs = max(rs, getSum())
            return
        }
        
        visited[row][col] = true
        dfs(row + 1, col)
        
        visited[row][col] = false
        dfs(row + 1, col)
    }
    
    func getSum() -> Int {
        var rs = 0
        var current = 0
        
        for row in 0..<n {
            current = 0
            for col in 0..<m {
                if visited[row][col] {
                    current = (current * 10) + map[row][col]
                } else {
                    rs += current
                    current = 0
                }
            }
            rs += current
        }
        
        for col in 0..<m {
            current = 0
            for row in 0..<n {
                if !visited[row][col] {
                    current = (current * 10) + map[row][col]
                } else {
                    rs += current
                    current = 0
                }
            }
            rs += current
        }
        
        return rs
    }
    
    dfs(0, 0)
    
    print(rs)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================

