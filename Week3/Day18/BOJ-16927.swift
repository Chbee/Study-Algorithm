//
//  BOJ-16927
//  백준 16927번 - 배열 돌리기 2
//
//  Created by 손지영 on 2026/02/12
//  난이도: 골드5 | 소요시간: 62분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/16927
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 회전.. 반시계...
///     - yx
///         : start: 1, 1 - end: M, N
///         : start: 2, 2 - end: M-1, N-1
///         : x의 인덱스가 1이면 y가 하나 증가.
///         : x의 인덱스가 N이면 y가 하나 감소. y가 이미 1이면 x 하나 감소
///         : y의 인덱스가 M이면 x가 하나 증가.
///         : y의 인덱스가 M이고, x의 인덱스가 N이면 y하나 감소
/// 2. 자료구조
///     - dy, dx [Int]
///     - map[[Int]]
/// 3. 시간복잡도
///     - O(N*M) ~= 3e2 * 3e2 = 9e4
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]; let r = input[2]
    
    var map = Array(repeating: [Int](), count: n + 1)
    
    for i in 1...n {
        var s = [0]
        s.append(contentsOf: readLine()!.split(separator: " ").map { Int($0)! })
        map[i] = s
    }
    
    let dy = [-1, 0, 1, 0]
    let dx = [0, 1, 0, -1]
    
    /// 회전할 레이어 개수 구하기
    let size = min(n, m)/2
    
    func rotate() {
        for l in 1...size {
            let top = l
            let left = l
            let bottom = n - l + 1
            let right = m - l + 1
            
            var y = top
            var x = left
            var dir = 0
            
            /// 레이어의 테두리 칸 수
            /// 높이: bottom - top + 1
            /// 너비: right - left + 1
            /// 테두리 칸 수 : 2w + 2h - 4 (중복 꼭지점 제거)
            let p = 2 * ((bottom - top + 1) + (right - left + 1)) - 4
            
            var temp = [Int]()
            
            // 레이어 분리
            for _ in 0..<p {
                temp.append(map[y][x])
                
                let ny = y + dy[dir]
                let nx = x + dx[dir]
                
                if ny < top || ny > bottom || nx < left || nx > right {
                    dir = (dir + 1) % 4
                }
                
                y += dy[dir]
                x += dx[dir]
            }
            
            let k = r % p
            let rotated = Array(temp[k...]) + Array(temp[..<k])
            
            y = top
            x = left
            dir = 0
            
            var idx = 0
            for _ in 0..<p {
                // 실제 rotate 발생
                map[y][x] = rotated[idx]
                idx += 1
                
                let ny = y + dy[dir]
                let nx = x + dx[dir]
                
                if ny < top || ny > bottom || nx < left || nx > right {
                    dir = (dir + 1) % 4
                }
                
                y += dy[dir]
                x += dx[dir]
            }
        }
    }
    
    rotate()
    
    for row in 1...n {
        print(map[row][1...m].map { String($0) }.joined(separator: " "))
    }
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================

/*
swift BOJ-16927.swift <<EOF
4 4 2
1 2 3 4
5 6 7 8
9 8 7 6
5 4 3 2
EOF
 */
