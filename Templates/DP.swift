import Foundation

// ========================================
// DP (동적계획법) 템플릿
// ========================================

// 1. Top-Down (메모이제이션)
var memo = [Int](repeating: -1, count: 100001)

func dp(_ n: Int) -> Int {
    if n == 0 { return 0 }
    if n == 1 { return 1 }
    
    if memo[n] != -1 {
        return memo[n]
    }
    
    memo[n] = dp(n-1) + dp(n-2)
    return memo[n]
}

// 2. Bottom-Up (타뷸레이션)
var dp = [Int](repeating: 0, count: n+1)
dp[0] = 0
dp[1] = 1

for i in 2...n {
    dp[i] = dp[i-1] + dp[i-2]
}

// 3. 2차원 DP (LCS, 배낭 문제)
var dp = [[Int]](repeating: [Int](repeating: 0, count: m+1), count: n+1)

for i in 1...n {
    for j in 1...m {
        if arr1[i-1] == arr2[j-1] {
            dp[i][j] = dp[i-1][j-1] + 1
        } else {
            dp[i][j] = max(dp[i-1][j], dp[i][j-1])
        }
    }
}
