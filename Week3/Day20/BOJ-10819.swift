//
//  BOJ-10819
//  백준 10819번 - 차이를 최대로
//
//  Created by 손지영 on 2026/02/20
//  난이도: 실버2 | 소요시간: 22분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/10819
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 정수의 순서를 적절히 변경해서 식의 최댓값 얻기
///     - 식: 인접한 두 수는 빼고, 연산한 그 두 수는 더함
///     - 20 1 15 8 4 10
///       -> 초기 식: (20 - 1) + (1 - 15) + (15 - 8) + (8 - 4) + (4 - 10) = 19 + 14 + 7 + 4 + 6 = 50
///       -> 최댓값 식: (10 - 1) + (1 - 15) + (15 - 4) + (4 - 20) + (20 - 8) = 9 + 14 + 11 + 16 + 12 = 62
///     - 모든 수열을 중복없이 선택해야함 = 순열
/// 2. 자료구조
///     - arr [Int]
///     - visitied [Bool]
///     - temp [Int]
///     - rs Int
/// 3. 시간복잡도
///     - O(N!)
///         ~= O(8!) = 40320 = 4e4
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    
    var visited = Array(repeating: false, count: n)
    
    var temp = [Int]()
    var rs = Int.min
    
    func dfs() {
        if temp.count == n {
            var sum = 0
            for i in 0..<(temp.count - 1) {
                sum += abs(temp[i] - temp[i+1])
            }
            rs = max(rs, sum)
            return
        }
        
        for i in 0..<n {
            if visited[i] { continue }
            visited[i] = true
            temp.append(arr[i])
            dfs()
            visited[i] = false
            temp.removeLast()
        }
    }
    
    dfs()
    
    print(rs)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
