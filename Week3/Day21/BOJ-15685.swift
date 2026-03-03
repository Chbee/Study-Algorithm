//
//  BOJ-15685
//  백준 15685번 - 드래곤 커브
//
//  Created by 손지영 on 2026/03/03
//  난이도: 골드3 | 소요시간: 54분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/15685
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 시작 점, 방향, 세대
///     - 0세대: 길이가 1인 선분
///     - 1세대: 0세대 끝점(1,0)을 기준으로 시계 방향으로 90도 회전시킨 다음 0세대 끝지점에 붙인것 (1,-1)
///     - 2세대: 1세대의 끝점(1,-1)을 기준으로 시게 방향으로 1세대를 90도 회전시킨 다음 1시데 끝지점에 붙인것 (0,-1),(0,-2)
///     - 세대의 모든 방향 확인
///         if g > 0, for _ in 0...g
///             for dir in dirs.reversed() // 마지막 세대부터 끝점에서 확인
///                 dirs.append((dir + 1) % 4)
///     - 모든 방향에 대해 확인
///         for dir in dirs
///             ny += dy[dir]
///             nx += dx[dir]
///             1. 모든 좌표가 0...100이고, 2. 중복이 아니면
///             map[ny][nx] = true
///     - 모든 드래곤 커브 찾은 후
///         for y in 0..<100
///             for x in 0..<100
///                 if map[y][x] && map[y+1][x] && map[y][x+1] && map[y+1][x+1]
///                     rs += 1
/// 2. 자료구조
///     - map [[Int]]
///     - rs Int
/// 3. 시간복잡도
///     - 커브 생성 : O(2^g)
///     - n개 커브 : O(n * 2^g)
///     - 정사각형 찾기 : O(100^2)
///     ~= O(n * 2^g + 100^2) ~= 20 * 2^10 + 100^2 ~= 2e1 * 1e3 + 1e4 = 3e4
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    let xMax = 100
    let yMax = 100
    var map = Array(repeating: Array(repeating: false, count: xMax + 1), count: yMax + 1)
    
    let dx = [1, 0, -1, 0]
    let dy = [0, -1, 0, 1]
    
    for _ in 0..<n {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let x = input[0]; let y = input[1];
        let d = input[2]; let g = input[3]
        
        var dirs = [d]
        
        if g > 0 {
            for _ in 1...g {
                for dir in dirs.reversed() {
                    dirs.append((dir + 1) % 4)
                }
            }
        }
        
        var nx = x
        var ny = y
        map[ny][nx] = true
        
        for dir in dirs {
            nx += dx[dir]
            ny += dy[dir]
            if nx > 100 || nx < 0 || ny > 100 || ny < 0 { continue }
            if map[ny][nx] { continue }
            map[ny][nx] = true
        }
    }
    
    var rs = 0
    
    for y in 0...100 {
        for x in 0...100 {
            if map[y][x] && map[y+1][x] && map[y][x+1] && map[y+1][x+1] {
                rs += 1
            }
        }
    }
    
    print(rs)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
