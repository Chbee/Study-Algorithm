//
//  BOJ-1932
//  백준 1932번 - 정수 삼각형
//
//  Created by 손지영 on 2026/01/29
//  난이도: 실버1 | 소요시간: 22분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1932
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 삼각형. 크기 n, array [[Int]], y는 1부터 5까지 순차적으로, x는 1부터 y까지?
/// 왼쪽 : y-1, x-1, 대각선 오른쪽: y+1, x+1
/// 1. dp[y][x] 정의
///     대각선 방향에서의 합들 중 최대값
/// 2. y, x의 진행방향
///     y-1, x-1 or y+1, x+1
/// 3. 점화식
///     dp[y][x] = tree[y][x] + max(dp[y-1][x], dp[y-1][x-1])
///     1-base일 때, x가 1이면 위 식이 성립하지 않음
///     dp[y][x] = tree[y][x] + dp[y-1][1]
///     y가 x랑 같으면?
///     dp[y][x] = tree[y][x] + dp[y-1][x-1]
/// 4. 초기값
///     dp[1][1] = tree[1][1]
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var tree = Array(repeating: [Int](), count: n+1)
    
    for i in 1...n {
        var row = [0]
        let input = readLine()!.split(separator: " ").map{Int($0)!}
        row.append(contentsOf: input)
        tree[i] = row
    }
    
    if n == 1 { print(tree[1][1]) }
    else {
        var dp = Array(repeating: [Int](), count: n+1)
        for i in 1...n {
            dp[i] = Array(repeating: 0, count: tree[i].count)
        }
        
        
        dp[1][1] = tree[1][1]
        
        var maxV = dp[1][1]
        
        for y in 2...n {
            for x in 1...y {
                if x == 1 {
                    dp[y][x] = tree[y][x] + dp[y-1][x]
                } else if x == y {
                    dp[y][x] = tree[y][x] + dp[y-1][x-1]
                } else {
                    dp[y][x] = tree[y][x] + max(dp[y-1][x], dp[y-1][x-1])
                }
                
                maxV = max(dp[y][x], maxV)
            }
        }
        
        print(maxV)
    }
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
