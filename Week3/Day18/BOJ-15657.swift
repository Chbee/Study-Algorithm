//
//  BOJ-15657
//  백준 15657번 - N과 M (8)
//
//  Created by 손지영 on 2026/02/11
//  난이도: 실버3 | 소요시간: 25번 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/15657
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 중복이 가능함 -> 조합
///     - N개의 자연수 중에서 M개를 고름, 비내림차순
///     - C(M, N)
/// 2. 자료구조
///     - result: [[Int]], 결과 출력
///     - temp: [Int] DFS 계산 임시 보관
/// 3. 시간복잡도
///     - 정렬: NlogN ~= 8 * 3 = 24
///     - DFS: N^M ~= 8*8 = 36
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]
    
    let s = readLine()!.split(separator: " ").map({ Int($0)! }).sorted()
    
    var result = [[Int]]()
    var temp = [Int]()
    
    func dfs(start: Int) {
        if temp.count == m {
            result.append(temp)
            return
        }
        
        for i in start..<n {
            temp.append(s[i])
            dfs(start: i)
            temp.removeLast()
        }
    }
    
    dfs(start: 0)
    
    for rs in result {
        print(rs.map({ String($0) }).joined(separator: " "))
    }
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
