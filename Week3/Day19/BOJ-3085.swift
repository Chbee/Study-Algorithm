//
//  BOJ-3085
//  백준 3085번 - 사탕 게임
//
//  Created by 손지영 on 2026/02/16
//  난이도: 실버2 | 소요시간: 60분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/3085
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 사탕의 색이 다른 인접한 두칸, 그 다음 고른 두 칸과 서로 교환
///     - 모두 같은 색으로 이루어져 있는 가장 긴 연속 부분, 대각선은 안됨 그 사탕을 모두 먹음
///     - 모든 인접 스왑을 시도한 뒤, 각 상태에서 가로/세로 최장 연속 길이를 계산
///     - 스왑 후 검사하고 원복
/// 2. 자료구조
///     - map [[Character]]
///     - rs Int
/// 3. 시간복잡도
///     - O(N^4) (모든 인접 스왑 O(N^2) * 검사 O(N^2))
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    var map = [[Character]]()
    
    for i in 0..<n {
        map.append(Array(readLine()!))
    }
    
    var rs = 0
    
    for y in 0..<n {
        for x in 0..<n-1 {
            map[y].swapAt(x, x+1)
            check()
            map[y].swapAt(x, x+1)
        }
    }
    
    for y in 0..<n-1 {
        for x in 0..<n {
            (map[y][x], map[y+1][x]) = (map[y+1][x], map[y][x])
            check()
            (map[y][x], map[y+1][x]) = (map[y+1][x], map[y][x])
        }
    }
    
    func check() {
        for y in 0..<n {
            var cnt = 1
            for x in 1..<n {
                if map[y][x] == map[y][x-1] { cnt += 1 }
                else { cnt = 1 }
                rs = max(rs, cnt)
            }
        }
        
        for x in 0..<n {
            var cnt = 1
            for y in 1..<n {
                if map[y][x] == map[y-1][x] { cnt += 1 }
                else { cnt = 1 }
                rs = max(rs, cnt)
            }
        }
    }
    
    print(rs)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================

/*
swift BOJ-3085.swift <<EOF
3
CCP
CCP
PPC
EOF
 */
