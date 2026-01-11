//
//  BOJ-1182
//  백준 1182번 - 부분수열의 합 (실버2)
//
//  Created by 손지영 on 2025/01/07
//  난이도: 실버2 | 소요시간: 50분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1182
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 사용할 자료구조/알고리즘:
//    - DFS, 백트래킹
//    - targetNum: Int <= 1_000_000
//    - sequence: [Int], count <= 20
//    - 경우의수 갯수 Int

// 2. 시간복잡도:
//    - O(2^N): 2^20

// 3. 접근 방법:
//    - 모든 부분집합 출력
//    - 재귀로 모든 노드 접근
//    - 재귀 함수 시작 전에 합이 S에 만족하는지 확인함

// ============================================
// 📌 주의사항
// ============================================
// - 더해야하는 원소의 갯수도 유동적임

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = input[0]
    let targetNum = input[1]
    
    let sequence = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    var cnt = 0
    
    func dfs(sum: Int, index: Int, used: Bool) {
        if index == n {
            if used && sum == targetNum { cnt += 1 }
            return
        }
        
        dfs(sum: sum + sequence[index], index: index + 1, used: true) // 포함해서 계산한 경우
        dfs(sum: sum, index: index + 1, used: used) // 미포함으로 계산한 경우
    }
    
    dfs(sum: 0, index: 0, used: false)
    
    print(cnt)
}

solution()


// ============================================
// ❌ 헷갈린점
// ============================================
// 원소의 갯수가 정해지지 않음. 어떻게 유동적으로 처리하지? -> 재귀로 처리
// 방문여부 어떻게 체크하지? 중복 어떻게 체크하지? -> 재귀로 돌릴것이므로 고려할 필요 x
// start index를 어떻게 넘겨줄것인가. -> 현재에서 1을 더해야 다음 원소로 찾아감.
// 모든 부분집합을 찾는것이라고 해서 무조건 이중 for문은 아님.
