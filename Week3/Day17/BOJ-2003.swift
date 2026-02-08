//
//  BOJ-2003
//  백준 2003번 - 수들의 합 2
//
//  Created by 손지영 on 2026/02/08
//  난이도: 실버4 | 소요시간: 25분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2003
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 연속 부분수열의 합이 M인 개수를 세어야 함 -> 슬라이딩 윈도우(투포인터)
///     - left/right가 현재 구간 [left, right]를 의미하도록 유지
///     - sum < target: right를 늘려 구간 확장
///     - sum > target: left를 늘려 구간 축소
///     - sum == target: count += 1 후 한쪽 포인터 이동 (항상 포인터가 진행되도록)
/// 2. 자료구조
///     - left, right : Int, pointer
///     - arr : [Int], input Array
///     - target: Int, target Number
///     - count: Int, Answer
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
    let n = input[0]; let target = input[1]
    
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    
    var left = 0
    var right = 0
    var sum = arr[0]
    
    var count = 0
    
    while right < n {
        if sum == target {
            count += 1
            
            right += 1
            if right < n { sum += arr[right] }
        } else if sum < target {
            right += 1
            if right < n { sum += arr[right] }
            
        } else {
            sum -= arr[left]
            left += 1
        }
    }
    
    print(count)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
