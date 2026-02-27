//
//  BOJ-15654
//  백준 15654번 - N과 M (5)
//
//  Created by 손지영 on 2026/02/26
//  난이도: 실버3 | 소요시간: 13분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/15654
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - N개의 자연수 중에서 M개를 고른 수열
///     - 중복되는 수열은 한번만 출력
///     - 수열은 증가하는 순으로 -> 입력받은 N 정렬
/// 2. 자료구조
///     - temp [Int]
///     - rs String
/// 3. 시간복잡도
///     - 정렬: O(NlogN)
///     - 순열 생성: O(P(N, M) * M)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let arr = (readLine()!.split(separator: " ").map { Int($0)! }).sorted()
    let n = input[0]
    
    var temp = [Int]()
    var visited = Array(repeating: false, count: n)
    
    var rs = ""
    
    func dfs(start: Int) {
        if temp.count == input[1] {
            rs += temp.map(String.init).joined(separator: " ") + "\n"
            return
        }
        
        for i in 0..<n {
            if visited[i] { continue }
            visited[i] = true
            temp.append(arr[i])
            dfs(start: i + 1)
            visited[i] = false
            temp.removeLast()
        }
    }
    
    dfs(start: 0)
    
    print(rs)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
