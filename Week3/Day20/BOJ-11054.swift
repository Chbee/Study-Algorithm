//
//  BOJ-11054
//  백준 11054번 - 가장 긴 바이토닉 부분 수열
//
//  Created by 손지영 on 2026/02/21
//  난이도: 골드4 | 소요시간: 50분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/11054
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 어떤 수를 기준으로 그 수의 왼쪽은 오름차순, 오른쪽은 내림차순이면 조건을 만족함
///     - 부분 수열 중 가장 긴 바이토닉 수열을 골라야함 -> 현재 인덱스가 중요하므로 정렬하면 안됨
///     - 부분 수열을 직접 찾았더니 시간 초과 발생함....
///     - LIS[i]: i에서 끝나는 최장 증가 부분수열 길이
///     - LDS[i]: i에서 시작하는 최장 감소 부분수열 길이
///     - i를 기준으로 하는 바이토닉 길이 = LIS[i] + LDS[i] - 1
/// 2. 자료구조
///     - temp [Int]
///     - subArray [[Int]]
///     - step Int
///     - rs Int
///     dp 방식으로 변경
///     - lis, lds [Int]
/// 3. 시간복잡도
///     - O(N^2)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    let a = readLine()!.split(separator: " ").map { Int($0)! }
    
    var lis = Array(repeating: 1, count: n)
    var lds = Array(repeating: 1, count: n)
    
    for i in 0..<n {
        for j in 0..<i {
            if a[j] < a[i] {
                lis[i] = max(lis[i], lis[j] + 1)
            }
        }
    }
    
    for i in stride(from: n - 1, through: 0, by: -1) {
        for j in stride(from: n - 1, through: i + 1, by: -1) {
            if a[j] < a[i] {
                lds[i] = max(lds[i], lds[j] + 1)
            }
        }
    }
    
    var answer = 0
    for i in 0..<n {
        answer = max(answer, lis[i] + lds[i] - 1)
    }
    
    print(answer)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
