//
//  BOJ-3273
//  백준 3273번 - 두 수의 합
//
//  Created by 손지영 on 2026/02/08
//  난이도: 실버3 | 소요시간: 15분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/3273
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 쌍의 개수
///     - 연속하지 않아도 됨
///     - left = 0, right = n-1
///     while left < right
///         sum = arr[left] + arr[right]
///         if sum == x
///             count += 1
///             left += 1
///             right -= 1
///         else if sum > x
///             right -= 1
///         else
///             left += 1
/// 2. 자료구조
///     - arr [Int]
///     - sum, left, right, count: Int
/// 3. 시간복잡도
///     - O(N)
///     - O(NlogN)
///     ~= O(NlogN)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map({ Int($0)! }).sorted()
    let x = Int(readLine()!)!
    
    var left = 0
    var right = n - 1
    var sum = 0
    
    var count = 0
    
    while left < right {
        let sum = arr[left] + arr[right]
        if sum == x {
            count += 1
            left += 1; right -= 1
        } else if sum > x {
            right -= 1
        } else {
            left += 1
        }
    }
    
    print(count)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
