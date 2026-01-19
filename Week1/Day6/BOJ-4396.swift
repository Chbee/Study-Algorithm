//
//  BOJ-4396
//  백준 4396번 - 지뢰찾기
//
//  Created by 손지영 on 2026/01/19 21:20
//  난이도: 실버4 | 소요시간: 50분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/4396
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 상하좌우 또는 대각선으로 인접한 8개의 칸에 지뢰가 몇개 있는지 알려주는 0과 8사이의 숫자.
//      - 지뢰를 건드리면 바로 게임 종료
//      - x: 이미 방문한곳, *: 지뢰위치, .: 방문가능한곳
//      - 선택한곳, 그 위치를 기반으로 지뢰 찾아야함.
//      - 대각선은 상좌, 상우, 좌하, 좌우 한번씩 움직여야할듯.
//      - 1-based로해서 찾음
// 2. 자료구조
//      - 지뢰map [[String]]
//      - 입력map [[String]]
// 3. 시간 복잡도
//      - O(N^2)
//          ~= 10^2 = 100 = 1e2 충분

// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var boom = Array(repeating: [String](), count: n+1)
    var map = Array(repeating: [String](), count: n+1)
    
    for i in 1...n {
        var _map = ["."]
        _map.append(contentsOf: readLine()!.map { String($0) })
        boom[i] = _map
    }
    
    for i in 1...n {
        var _map = ["."]
        _map.append(contentsOf: readLine()!.map { String($0) })
        map[i] = _map
    }
    
    let dy = [-1,-1,-1, 0, 0, 1, 1, 1]
    let dx = [-1, 0, 1,-1, 1,-1, 0, 1]
    
    var boomed = false
    for y in 1...n {
        for x in 1...n {
            if map[y][x] == "x", boom[y][x] == "*" {
                boomed = true
            }
        }
    }
    
    func countBombs(y: Int, x: Int) -> Int {
        var count = 0
        for i in 0..<8 {
            let ny = y + dy[i]
            let nx = x + dx[i]
            
            if ny < 1 || ny > n || nx < 1 || nx > n { continue }
            if boom[ny][nx] == "*" { count += 1 }
        }
        return count
    }
    
    for y in 1...n {
        var line = ""
        for x in 1...n {
            if boomed && boom[y][x] == "*" {
                line.append("*")
                continue
            }
            if map[y][x] == "x" {
                let count = countBombs(y: y, x: x)
                line.append(String(count))
            } else {
                line.append(".")
            }
        }
        print(line)
    }
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
// 상하 좌우의 대각선....어렵다!!
// "지뢰 찾았을 때"의 출력 조건이 어렵다.


