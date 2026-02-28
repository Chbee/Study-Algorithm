//
//  BOJ-6603
//  백준 6603번 - 로또
//
//  Created by 손지영 on 2026/02/27
//  난이도: 실버2 | 소요시간: 10분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/6603
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 1부터 49까지 k개의 집합 중에서 6개를 선택
///     - 중복되지 않게 고르는 모든 경우의 수
/// 2. 자료구조
///     - temp [Int]
///     - rs String
/// 3. 시간복잡도
///     - O(C(k, 6))
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    var rs = ""
    var temp = [Int]()
    let target = 6
    
    while true {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let k = input[0]
        if k == 0 {
            print(rs)
            break
        }
        
        let s = Array(input[1..<input.count])
        dfs(start: 0, in: s)
        
        rs += "\n"
    }
    
    
    func dfs(start: Int, in arr: [Int]) {
        if temp.count == target {
            rs += temp.map { String($0) }.joined(separator: " ")
            rs += "\n"
        }
        
        for i in start..<arr.count {
            temp.append(arr[i])
            dfs(start: i + 1, in: arr)
            temp.removeLast()
        }
    }
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
