//
//  BOJ-16935
//  백준 16935번 - 배열 돌리기 3
//
//  Created by 손지영 on 2026/02/13
//  난이도: 골드5 | 소요시간: 95분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/16935
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 연산 6가지, 최대 1000번
///     - 상하 반전
///         : 1, 1 -> M, 1 | 2, 1 -> 4, 1 = (n - ((y + n) % n)), 1
///     - 좌우 반전
///         : 1, 1 -> 1, N | 1, 2 -> 1, 4 = y, (m - ((x + m) % m)), 1
///     - 오른쪽으로 90도 회전
///         : ny, nx -> y, y좌우 반전값
///     - 왼쪽으로 90도 회전
///         : ny, nx -> x, y를 상하반전
///     - 그룹이동
///         : n/2xm/2 4개로 나눔
///         : 1 -> 2, 2 -> 3, 3 -> 4, 4 -> 1
///         : 1 -> 4, 4 -> 3, 3 -> 2, 2 -> 1
/// 2. 자료구조
///     - grid: [[Int]] (현재 배열 상태)
///     - temp: [[Int]] (연산 결과를 임시 저장 후 교체)
///     - cmds: [Int] (수행할 연산 목록)
/// 3. 시간복잡도
///     - 각 연산(1~6): O(N*M)
///     - 총 연산 R개: O(R*N*M)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; _ = input[1]; _ = input[2]
    
    var grid = [[Int]]()
    
    for _ in 0..<n {
        grid.append(readLine()!.split(separator: " ").map { Int($0)! })
    }
    
    let cmds = readLine()!.split(separator: " ").map { Int($0)! }
    
    for c in cmds {
        switch c {
        case 1:
            switchTopBottom()
        case 2:
            switchLeftRight()
        case 3:
            rotateDegreeToRight()
        case 4:
            rotateDegreeToLeft()
        case 5:
            rotateGroupToClockwise()
        case 6:
            rotateGroupToConterClockwise()
        default:
            continue
        }
    }
    
    func switchTopBottom() {
        let row = grid.count
        let col = grid[0].count
        var temp = Array(repeating: Array(repeating: 0, count: col), count: row)
        
        for y in 0..<row {
            for x in 0..<col {
                let ny = row - y - 1
                let nx = x
                temp[ny][nx] = grid[y][x]
            }
        }
        
        grid = temp
    }
    
    func switchLeftRight() {
        let row = grid.count
        let col = grid[0].count
        var temp = Array(repeating: Array(repeating: 0, count: col), count: row)
        
        for y in 0..<row {
            for x in 0..<col {
                let ny = y
                let nx = col - x - 1
                temp[ny][nx] = grid[y][x]
            }
        }
        
        grid = temp
    }
    
    func rotateDegreeToRight() {
        let row = grid.count
        let col = grid[0].count
        var temp = Array(repeating: Array(repeating: 0, count: row), count: col)
        
        for y in 0..<row {
            let nx = row - y - 1
            for x in 0..<col {
                temp[x][nx] = grid[y][x]
            }
        }
        
        grid = temp
    }
    
    func rotateDegreeToLeft() {
        let row = grid.count
        let col = grid[0].count
        var temp = Array(repeating: Array(repeating: 0, count: row), count: col)
        
        for y in 0..<row {
            for x in 0..<col {
                let nx = col - x - 1
                temp[nx][y] = grid[y][x]
            }
        }
        
        grid = temp
    }
    
    func rotateGroupToClockwise() {
        let row = grid.count
        let col = grid[0].count
        let h = row / 2
        let w = col / 2
        var temp = grid
        
        for y in 0..<h {
            for x in 0..<w {
                temp[y][x+w] = grid[y][x]
                temp[y+h][x+w] = grid[y][x+w]
                temp[y+h][x] = grid[y+h][x+w]
                temp[y][x] = grid[y+h][x]
            }
        }
        
        grid = temp
    }
    
    func rotateGroupToConterClockwise() {
        let row = grid.count
        let col = grid[0].count
        let h = row / 2
        let w = col / 2
        var temp = grid
        
        for y in 0..<h {
            for x in 0..<w {
                temp[y][x] = grid[y][x + w]
                temp[y][x + w] = grid[y + h][x + w]
                temp[y + h][x + w] = grid[y + h][x]
                temp[y + h][x] = grid[y][x]
            }
        }
        
        grid = temp
    }
    
    for g in grid {
        print(g.map { String($0) }.joined(separator: " "))
    }
    
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
