//
//  BOJ-15655
//  백준 15655번 - N과 M (6)
//
//  Created by 손지영 on 2026/02/14
//  난이도: 실버3 | 소요시간: - | 상태: ⬜
//  링크: https://www.acmicpc.net/problem/15655
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - C(N, M)의 오름차순
///     - 중복 미허용
///     - 우선 입력받은 배열을 오름차순으로 정렬함
///     - 현재 index에서 하나 큰거부터 조합해나가며 확인
/// 2. 자료구조
///     - nums [Int]
///     - temp [Int]
/// 3. 시간복잡도
///     - 정렬: O(NlogN)
///     - 조합: O(nCm) = O(N! / (M! × (N-M)!))
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]
    
    var temp = [Int]()
    let nums = readLine()!.split(separator: " ").map { Int($0)! }.sorted { $0 < $1 }
    
    func dfs(_ start: Int) {
        if temp.count == m {
            print(temp.map{ String($0) }.joined(separator: " "))
            return
        }
        
        for i in start..<n {
            temp.append(nums[i])
            dfs(i + 1)
            temp.removeLast()
        }
    }
    
    dfs(0)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
