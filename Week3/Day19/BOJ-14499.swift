//
//  BOJ-14499
//  백준 14499번 - 주사위 굴리기
//
//  Created by 손지영 on 2026/02/14
//  난이도: 골드4 | 소요시간: 70분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/14499
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - r은 위쪽으로 부터 떨어진 칸의 개수, c는 왼쪽으로 부터 떨어진 칸의 개수 : 주사위
///     - map에서 이동한 칸의 수가 0이면 주사위의 "바닥면"에 쓰여있는 수가 칸에 복사됨
///                          0이 아니면 칸에 쓰여있는 수가 주사위의 바닥면으로 복사되고 칸에는 0으로 변경됨
///     - 주사위를 놓은곳의 좌표, 명령을 보고 이동마다 "상단"에 쓰여있는 값을 구하는 프로그램
///     - 윗면은 아랫면과 대칭 항상.
///     - 동: x+1, 서: x-1, 남: y+1, 북: y-1
///     - dice 인덱스: [top, north, east, west, south, bottom]
///     - 전개도(인덱스 기준)
///               [1: north]
///     [3: west] [0: top] [2: east]
///               [4: south]
///               [5: bottom]
///     - 기본: 1 2 3 4 5 6
///       동으로 이동 : 4 2 1 6 5 3
///       서로 이동  : 3 2 6 1 5 4
///       남으로 이동 : 2 6 3 4 1 5
///       북으로 이동 : 5 1 3 4 6 2
/// 2. 자료구조
///     - map [[Int]]
///     - dice [Int]
/// 3. 시간복잡도
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]
    var y = input[2]; var x = input[3]
    let k = input[4]
    
    var map = [[Int]]()
    
    var d = Array(repeating: 0, count: 6)
    
    for _ in 0..<n {
        map.append(readLine()!.split(separator: " ").map { Int($0)! })
    }
    
    let cmd = readLine()!.split(separator: " ").map { Int($0)! }
    
    let dy = [0, 0, 0, -1, 1]
    let dx = [0, 1, -1, 0, 0]
    
    for c in cmd {
        var ny = y + dy[c]
        var nx = x + dx[c]
        
        guard ny >= 0, ny < n, nx >= 0, nx < m else { continue }
        
        if c == 1 { rollE(&d) }
        else if c == 2 { rollW(&d) }
        else if c == 3 { rollN(&d) }
        else if c == 4 { rollS(&d) }
        
        if map[ny][nx] == 0 {
            map[ny][nx] = d[5]
            print(d[0])
        } else {
            d[5] = map[ny][nx]
            map[ny][nx] = 0
            print(d[0])
        }
        
        y = ny
        x = nx
    }
    
    func rollE(_ d: inout [Int]) {
        let t = d[0]
        d[0] = d[3]
        d[3] = d[5]
        d[5] = d[2]
        d[2] = t
    }
    
    func rollW(_ d: inout [Int]) {
        let t = d[0]
        d[0] = d[2]
        d[2] = d[5]
        d[5] = d[3]
        d[3] = t
    }
    
    func rollN(_ d: inout [Int]) {
        let t = d[0]
        d[0] = d[4]
        d[4] = d[5]
        d[5] = d[1]
        d[1] = t
    }
    
    func rollS(_ d: inout [Int]) {
        let t = d[0]
        d[0] = d[1]
        d[1] = d[5]
        d[5] = d[4]
        d[4] = t
    }
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
/// 주사위 전개도를 어떻게 그릴것인가
