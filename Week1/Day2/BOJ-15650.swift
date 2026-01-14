//
//  BOJ-15650
//  백준 15650번 - N과 M (2)
//
//  Created by 손지영 on 2025/01/07
//  난이도: 실버3 | 소요시간: 40분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/15650
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 사용할 자료구조/알고리즘:
//      - 모든 수열 : 백트래킹
//      - result: [Int]
//      - chk: [Boo]
//
// 2. 시간복잡도:
//      - 모든 중복 없는 수열 N!
//
// 3. 접근 방법:
//      - 1부터 n+1까지 for문을 돌면서 주어진 값까지 재귀 탐색
//      - 찾은 배열의 count가 M과 동일할때 오름차순 정렬하여 출력
//      - 방문한 인덱스가 아닐때 방문 처리, value append, 깊이 탐색 시작
//      - 깊이 탐색을 시작할 때 방문 여부와 찾은 수열의 값을 초기화 해줘야함
//      - 시작(N)부터 끝까지 1씩 증가하도록 해서 자동으로 오름차순으로 정렬하도록 함
//      - 다음 인덱스부터의 시작이 필요한지 확인 필요 어떻게 방문한건 다시 방문못하도록 할것인가. chk 초기화를 이동해야하나?

// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = input[0]; let m = input[1]
    
    var result = [Int]()
    var chk = Array(repeating: false, count: n + 1)
    
    func recur(cnt: Int, start: Int) {
        if cnt == m {
            print(result.map({ String($0) }).joined(separator: " "))
            return
        }
        guard start < n+1 else { return }
        // 어떻게 오름차순임을 증명해서 건너띄거나 실행할것인가.
        for i in start..<n+1 {
            guard chk[i] == false else { continue }
            chk[i] = true
            result.append(i)
            recur(cnt: cnt + 1, start: i + 1) // 다음 index 실행 현재 index로는 처리가능한 것이 없음을 표시
            chk[i] = false
            _ = result.removeLast()
        }
    }
    
    recur(cnt: 0, start: 1)
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
// 수열의 중복이 되면 안되었던거였음!
