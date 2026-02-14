//
//  BOJ-6588
//  백준 6588번 - 골드바흐의 추측
//
//  Created by 손지영 on 2026/02/14
//  난이도: 실버1 | 소요시간: 60분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/6588
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 4보다 큰 모두 짝수는, 홀수인 소수 두개의 합으로 나타낼 수 있다.
///     - 를 검증하는 프로그램
///     - 소수 판별 : `에라토스테네스의 체`
///     - 조합찾기 :
/// 2. 자료구조
///     - prime [Int]
/// 3. 시간복잡도
///     - O(N log log N): 소수 판별
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    
    var t = [Int]()
    
    while let line = readLine(), let n = Int(line) {
        if n == 0 { break }
        t.append(n)
    }
    
    if !t.isEmpty {
        cal()
    }
    
    func cal() {
        var maxV = 0
        for n in t {
            maxV = max(maxV, n)
        }
        
        let isPrime = findPrime(maxV)
        
        for n in t {
            var found = false
            var rs = (0, 0)
            for i in stride(from: 3, through: n / 2, by: 2) {
                if isPrime[i] && isPrime[n - i] {
                    rs = (i, n - i)
                    found = true
                    break
                }
            }
            
            if !found {
                print("Goldbach's conjecture is wrong.")
            } else {
                print("\(n) = \(rs.0) + \(rs.1)")
            }
        }
        
    }
    
    func findPrime(_ n: Int) -> [Bool] {
        if n < 1 { return [] }
        
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
        
        return isPrime
    }
    
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
