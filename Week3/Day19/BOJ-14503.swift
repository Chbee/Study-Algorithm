//
//  BOJ-14503
//  백준 14503번 - 로봇 청소기
//
//  Created by 손지영 on 2026/02/14
//  난이도: 골드5 | 소요시간: 40분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/14503
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 바라보는 방향, 동 서 남 북
///     - 칸이 청소 안되어있으면 청소
///     - 주변에서 이동이 불가능한 경우
///         : 방향을 유지하고 후진 (가능할경우)
///         : 작동 멈춤 (불가능할경우)
///     - 주변에 이동이 가능한 경우
///         : 반시계 방향으로 90도 회전
///         : 바라보는 방향으로 한칸 전진 (가능할경우)
///     - 청소부터 다시 시작
///     - dy, dx로 이동할 거리 찾음 단, 반시계 방향 90도 부터 찾아야함
///         북 동 남 서 : 0, 1, 2, 3
///         동 -> 남, 남 -> 서, 서 -> 북, 북 -> 동
///     - 주변이 모두 1일경우, 방향 유지한채로 후진
///         동 <-> 서, 남 <-> 북
///     - 후진할 위치도 벽이면 작동 종료
/// 2. 자료구조
///     - map [[Int]]
///     - dx dy [Int]
///     - d Int
///     - cnt Int
/// 3. 시간복잡도
///     - O(N*M) = 50*50 = 2.5e3
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]
    
    let start = readLine()!.split(separator: " ").map { Int($0)! }
    var y = start[0]; var x = start[1]
    var d = start[2]
    
    var map = [[Int]]()
    for _ in 0..<n {
        map.append(readLine()!.split(separator: " ").map { Int($0)! })
    }
    
    let dy = [-1, 0, 1, 0]
    let dx = [0, 1, 0, -1]
    
    var count = 0
    
    while true {
        if map[y][x] == 0 {
            map[y][x] = -1
            count += 1
        }
        
        var canMove = false
        
        for i in 0..<4 {
            let nd = (d + 3 - i) % 4
            let ny = y + dy[nd]
            let nx = x + dx[nd]
            
            if ny >= 0, ny < n, nx >= 0, nx < m {
                if map[ny][nx] == 0 {
                    y = ny; x = nx; d = nd
                    canMove = true
                    break
                }
            }
        }
        
        if !canMove {
            let ny = y - dy[d]
            let nx = x - dx[d]
            if ny >= 0, ny < n, nx >= 0, nx < m {
                if map[ny][nx] == 1 {
                    break
                } else {
                    y = ny; x = nx;
                }
            } else {
                break
            }
        }
    }
    
    print(count)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================

