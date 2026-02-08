//
//  BOJ-2470
//  백준 2470번 - 두 용액
//
//  Created by 손지영 on 2026/02/08
//  난이도: 골드5 | 소요시간: 30분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2470
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심 아이디어
///     - 산성 1 ~ 1e9, 알칼리성 -1e9 ~ -1
///     - 0에 가장 가까운 특성값, 서로 다른 용액 혼합 필요.
///     - 투포인터
///     - left: 0, right: n - 1
///     - best: Int.max, bestL = 0, bestR = 0
///     while left < right
///         let lv = arr[left]; let rv = arr[right]
///         sum = lv + rv
///         if abs(sum) < abs(best)
///             best = sum
///             bestL = left
///             bestR = right
///         if sum == 0
///             break
///         else sum < 0
///             left += 1
///         else
///             right -= 1
/// 2. 자료구조
///     - left, right, bestL, bestR, sum = Int
/// 3. 시간복잡도
///     - O(NlogN)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    let arr = readLine()!.split(separator: " ").map({ Int($0)! }).sorted()
    
    var left = 0
    var right = n - 1
    var best = Int.max
    var lb = 0; var rb = 0
    
    while left < right {
        let sum = arr[left] + arr[right]

        if abs(sum) < abs(best) {
            best = sum
            lb = left; rb = right
        }
        
        if sum == 0 { break }
        else if sum < 0 {
            left += 1
        } else {
            right -= 1
        }
    }
    
    print("\(arr[lb]) \(arr[rb])")
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
