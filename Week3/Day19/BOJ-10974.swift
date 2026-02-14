//
//  BOJ-10974
//  백준 10974번 - 모든 순열
//
//  Created by 손지영 on 2026/02/14
//  난이도: 실버3 | 소요시간: 8분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/10974
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 순열을 사전순으로 출력
///     - DFS, 중복 방문 금지
/// 2. 자료구조
///     - temp [Int]
///     - visited [Bool]
/// 3. 시간복잡도
///     - O(N!)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var temp = [Int]()
    var visited = Array(repeating: false, count: n + 1)
    
    func dfs(start: Int) {
        if temp.count == n {
            print(temp.map{ String($0) }.joined(separator: " "))
            return
        }
        
        for i in 1...n {
            if visited[i] { continue }
            visited[i] = true
            temp.append(i)
            dfs(start: i + 1)
            temp.removeLast()
            visited[i] = false
        }
    }
    
    dfs(start: 0)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
