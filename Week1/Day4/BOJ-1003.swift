//
//  BOJ-1003
//  백준 1003번 - 피보나치 함수 (실버3)
//
//  Created by 손지영 on 2026/01/16 21:46
//  난이도: 실버3 | 소요시간: 25분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1003
//

import Foundation


// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 0과 1의 횟수. (Int, Int)
//      - 입력받은 값들 중 가장 큰 값으로 dp 우선 생성.
//      - dp[0] = (1, 0), dp[1] = (0, 1)
//      - tuple은 별도 변수명없이 사용.
//      - for i 2..<max+1
//          - let n = dp[i-1]; let m = dp[i-2]
//          - dp[i] = (n.0 + m.0, n.1 + m.1)
// 2. 자료구조
//      - dp [(Int, Int)]
//      - inputCase [Int]
// 3. 시간복잡도
//      - O(N) : dp 정렬
//      - O(T) : 출력

// ============================================
// 📌 주의사항
// ============================================


// ============================================
// 🔨 구현
// ============================================

func solution() {
    let t = Int(readLine()!)!
    
    var maxV = 0
    var inputCase = [Int]()
    
    for _ in 0..<t {
        let n = Int(readLine()!)!
        inputCase.append(n)
        maxV = max(maxV, n)
    }
    
    typealias Counting = (Int, Int)
    var dp = Array(repeating: (0, 0), count: maxV + 1)
    
    dp[0] = (1, 0)
    if maxV >= 1 {
        dp[1] = (0, 1)
    }
    
    if maxV >= 2 {
        for i in 2..<maxV + 1 {
            let n = dp[i-1]
            let m = dp[i-2]
            dp[i] = (n.0 + m.0, n.1 + m.1)
        }
    }
    
    for value in inputCase {
        let getV = dp[value]
        print("\(getV.0) \(getV.1)")
    }
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
