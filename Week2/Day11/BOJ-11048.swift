//
//  BOJ-11048
//  백준 11048번 - 이동하기
//
//  Created by 손지영 on 2026/01/29
//  난이도: 실버2 | 소요시간: 20분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/11048
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심 아이디어
///     (y, x)일때 가져올 수 있는 사탕 개수 최대 (y+1, x), (y, x+1), (y+1, x+1)로 이동 가능
///     (1, 1) 부터 시작. maxV는 별도로 가지고 있을것.
///     1. dp[i][j] 정의
///         나의 위치
///     2. i, j의 진행방향
///         i로 한칸, j로 한칸 또는 i, j 모두 한칸씩 이동
///         dp는 그 이전칸을 봐야하므로 i 또는 j로 한칸 이전, i,j 모두 한칸 이전으로 확인
///
///         단, 사탕을 선택한 최대의 개수. 3가지 방향 중 최대인걸 업데이트
///     3. 점화식
///         dp[i][j] = cancy[j][i] + max(dp[i-1][x], max(dp[i][x-1], dp[i-1][j-1]))
///     4. 초기값
///         dp[1][1] = candy[1][1]
/// 2. 자료구조
///     dp[Int][Int] // 사탕 최대 갯수
///     cancy[Int][Int] // 입력받은 사탕 개수
///     maxV Int // 최대 사탕 개수
/// 3. 시간 복잡도
///     O(N*M)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let m = input[0]; let n = input[1]
    
    var candy = Array(repeating: [Int](), count: m+1)
    
    for i in 1...m {
        var row = [0]
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        row.append(contentsOf: input)
        
        candy[i] = row
    }
    
    var dp = Array(repeating: Array(repeating: 0, count: n+1), count: m+1)
    
    dp[1][1] = candy[1][1]
    
    var maxV = dp[1][1]
    
    for y in 1...m {
        for x in 1...n {
            dp[y][x] = candy[y][x] + max(dp[y-1][x], max(dp[y][x-1], dp[y-1][x-1]))
            maxV = max(maxV, dp[y][x])
        }
    }
    
    print(maxV)
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
