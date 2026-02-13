//
//  BOJ-15662
//  백준 15662번 - 톱니바퀴 (2)
//
//  Created by 손지영 on 2026/02/12
//  난이도: 골드5 | 소요시간: 50분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/15662
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 맞닿아 있는 톱니의 극이 다르면 앞선 톱니의 반대 방향, 같으면 회전x
///     - 같은 index의 값이 다르면 회전을 발생시킴
///     - 회전 방향 저장 [T]
///     - [[Int]] 로 톱니바퀴 저장 후 돌리기
///     - 항상 맞닿은 index는 좌측의 2, 우측의 6
///     - 회전하기 전에 맞닿아있는지 확인, 맞닿아있다면 대기열에 추가
///     - 회전할때, 왼쪽으로 돌면 fisrt제거 후 last에 append
///               오른쪽으로 돌면 last제거 후 first에 insert
/// 2. 자료구조
///     - queue [(Int, Int)]
/// 3. 시간복잡도
///     - BFS O(T)
///     - rotate: O(T)
///     - total: O(K * T) 1e3 * 1e3 = 1e6
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let t = Int(readLine()!)!
    
    var w = [[Int]]()
    
    for _ in 0..<t {
        w.append(readLine()!.map { Int(String($0))! })
    }
    
    let k = Int(readLine()!)!
    
    typealias Wheel = (i: Int, d: Int)
    var d = [Wheel]()
    
    for _ in 0..<k {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        d.append(Wheel(i: input[0] - 1, d: input[1]))
    }
    
    let l = 2
    let r = 6
    
    for cmd in d {
        var queue = [cmd]
        var head = 0
        
        var visited = Array(repeating: false, count: t)
        visited[cmd.i] = true
        
        while head < queue.count {
            let cur = queue[head]
            head += 1
            
            let lw = cur.i - 1
            let rw = cur.i + 1
            
            if lw >= 0, !visited[lw], w[lw][l] != w[cur.i][r] {
                visited[lw] = true
                queue.append(Wheel(i: lw, d: -cur.d))
            }
            
            if rw < t, !visited[rw], w[rw][r] != w[cur.i][l] {
                visited[rw] = true
                queue.append(Wheel(i: rw, d: -cur.d))
            }
        }
        rotate(q: queue)
    }
    
    func rotate(q: [Wheel]) {
        for (i, d) in q {
            if d == 1 {
                let last = w[i].removeLast()
                w[i].insert(last, at: 0)
            } else if d == -1 {
                let first = w[i].removeFirst()
                w[i].append(first)
            }
        }
    }
    
    var count = 0
    
    for wheel in w {
        if wheel[0] == 1 { count += 1 }
    }
    
    print(count)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================

/*
swift BOJ-15662.swift <<EOF
4
10101111
01111101
11001110
00000010
2
3 -1
1 1
EOF
 */
