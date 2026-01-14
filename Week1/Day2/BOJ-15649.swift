//
//  BOJ-15649
//  백준 15649번 - N과 M (1)
//
//  Created by 손지영 on 2025/01/07
//  난이도: 실버3 | 소요시간: 20분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/15649
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 사용할 자료구조/알고리즘:
//      - 백트래킹
//      - map: [[Int]]
//      - chk: [Bool]
//
// 2. 시간복잡도:
//      - O(N!) = O(8!) = O(40320) ~= O(log(15))??
//
// 3. 접근 방법:
//      - 입력받은 값으로 map 생성함
//      - 1부터 N까지 M개를 선택해야함 (중복 없이)
//          - 예를 들어 N이4, M이 2개면 수열은 2개의 인자로 구성되어야하고 1~4까지 중복없이 선택해야함
//      - 이중 for문으로 1..<N+1로 해서,, 방문 여부 체크해서 방문 안했으면 append, 방문 햇으면 continue
//      - 이중 for문을 재귀로 보냄. index + 1씩해서

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
    
    func recur(cnt: Int) {
        if cnt == m {
            print(result.map({ String($0) }).joined(separator: " "))
            return
        }
        
        for i in 1..<(n+1) {
            if chk[i] == false {
                chk[i] = true
                result.append(i) // 값 넣음. 1 append
                recur(cnt: cnt + 1) // 1일 때 다음거 찾음
                chk[i] = false // 미방문 처리, 다음 인덱스로 넘어가기 위한 준비
                _ = result.removeLast() // 마지막값 빼줌, 다음 인덱스로 넘어가기 위한 준비
            }
        }
    }
    
    recur(cnt: 0)
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
