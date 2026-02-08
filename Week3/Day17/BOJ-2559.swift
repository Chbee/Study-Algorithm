//
//  BOJ-2559
//  백준 2559번 - 수열
//
//  Created by 손지영 on 2026/02/08
//  난이도: 실버3 | 소요시간: 13분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2559
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 연속되는 합이 가장 큰 값: 슬라이딩 윈도우
///     - 연속되는 개수만큼 계산하며 max 확인
///     - sum: arr[0..<k].reduce(0) { $0 + $1 }
///     for i in k..<n
///         sum += arr[i] - arr[i-k]
///         maxV = max(sum, maxV)
/// 2. 자료구조
///     sum: Int
///     maxV: Int
/// 3. 시간복잡도
///     O(N)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let k = input[1]
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    
    var sum = Array(arr[0..<k]).reduce(0) { $0 + $1 }
    var maxV = sum
    
    for i in k..<n {
        sum += arr[i] - arr[i-k]
        maxV = max(sum, maxV)
    }
    
    print(maxV)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
