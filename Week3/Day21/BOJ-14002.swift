//
//  BOJ-14002
//  백준 14002번 - 가장 긴 증가하는 부분 수열 4
//
//  Created by 손지영 on 2026/03/03
//  난이도: 골드4 | 소요시간: 35분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/14002
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 가장 긴 증가 부분 수열 중 한가지.
///     1. dp[i]의 정의
///         - arr[i]에서 끝나는 수열의 길이
///     2. i의 진행방향
///         - 0..<n
///         - 이전까지 선택한 수열과 나를 포함한 배열의 크기를 계산
///         - 단, 이전값보다 값이 클때 나를 포함할 수 있음
///     3. dp의 점화식
///         - for i in 0..<n
///             for j in 0..<i
///                 if arr[i] <= arr[j] { continue }
///                 dp[i] = max(dp[i], dp[j] + 1)
///     4. dp의 초기값
///         - dp[0..<n] = 1
///
///     길이와 함께 배열에 담을 이전 원소의 인덱스도 찾아야함
///         rs[i] = j
///
///     dp의 최대값 찾음
///     for i in 0..<n
///         if dp[i] > dp[idx] { idx = i }
///
///     while idx != -1
///         ans.append(arr[idx])
///         idx = rs[idx]
///
///     역으로 배열 인덱스를 담았기 때문에 reverse 1회
/// 2. 자료구조
///     - dp [Int]
///     - rs [Int]
///     - ans [Int]
///     - idx Int
/// 3. 시간복잡도
///     - O(N^2)
///     - reverse O(NlogN)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    
    var dp = Array(repeating: 1, count: n)
    var rs = Array(repeating: -1, count: n)
    
    for i in 0..<n {
        for j in 0..<i {
            if arr[i] > arr[j] && dp[i] < dp[j] + 1 {
                dp[i] = dp[j] + 1
                rs[i] = j
            }
        }
    }
    
    var idx = 0
    for i in 0..<n {
        if dp[i] > dp[idx] { idx = i }
    }
    
    var ans = [Int]()
    while idx != -1 {
        ans.append(arr[idx])
        idx = rs[idx]
    }
    ans.reverse()
    
    print(ans.count)
    print(ans.map { String($0) }.joined(separator: " "))
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
