//
//  BOJ-1644
//  백준 1644번 - 소수의 연속합
//
//  Created by 손지영 on 2026/02/08
//  난이도: 골드3 | 소요시간: 40분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1644
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 1..N 소수 목록을 에라토스테네스의 체로 만든다
///     - 소수 배열에서 연속 부분합이 N이 되는 경우의 수를 투포인터로 센다
///     - right를 늘려 합을 키우고, sum >= N이면 left를 줄여 합을 낮춘다
///     - sum == N일 때마다 count += 1
/// 2. 자료구조
///     - isPrime: [Bool] (체용)
///     - primes(arr): [Int] (소수 리스트)
///     - left/right/sum/count: Int
/// 3. 시간복잡도
///     - 소수 판별: O(N log log N)
///     - 투포인터 O(N)
///     - N: 4e6
///     ~= log 4e6 ~= log4 + log10^6 ~= 2 + 6 * log10 ~= 2 + 6 * 4
///     ~= 26
///     4e6 * log26 ~= 4e6 * 5 ~= 2e7
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    let arr = isPrime()
    
    var left = 0
    var right = 0
    var sum = 0
    
    var count = 0
    
    while right < arr.count {
        sum += arr[right]
        right += 1
        while sum >= n {
            if sum == n {
                count += 1
            }
            sum -= arr[left]
            left += 1
        }
    }
    
    
    func isPrime() -> [Int] {
        if n < 2 { return [] }
        
        var isPrime = Array(repeating: true, count: n + 1)
        if n >= 0 { isPrime[0] = false }
        if n >= 1 { isPrime[1] = false }
        
        let limit = Int(Double(n).squareRoot())
        
        if limit >= 2 {
            for i in 2...limit {
                if isPrime[i] {
                    var j = i * i
                    while j <= n {
                        isPrime[j] = false
                        j += i
                    }
                }
            }
        }
        
        var rs = [Int]()
        for i in 2...n {
            if isPrime[i] == true {
                rs.append(i)
            }
        }
        return rs
    }
    
    print(count)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
