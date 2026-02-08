//
//  BOJ-1806
//  백준 1806번 - 부분합
//
//  Created by 손지영 on 2026/02/08
//  난이도: 골드4 | 소요시간: 32분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1806
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심 아이디어
///     - S이상이 되는 것 중, 가장 짧근 것의 길이
///     - "연속된 수들의 부분합": 윈도우 슬라이딩
///     - left 0, right 0, minv: Int.max
///     - sum: 0
///     while right < n
///         sum += arr[right]
///         right += 1
///         while sum >= s
///             minv = min(minv, right - left)
///             sum -= arr[left]
///             left += 1
/// 2. 자료구조
///     - left, right, sum, minv Int
/// 3. 시간복잡도
///     - O(N)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let s = input[1]
    
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    
    var left = 0
    var right = 0
    var sum = 0
    var minV = Int.max
    
    while right < n {
        sum += arr[right]
        right += 1
        
        while sum >= s {
            minV = min(minV, right - left)
            sum -= arr[left]
            left += 1
        }
    }
    
    print(minV == Int.max ? 0 : minV)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
