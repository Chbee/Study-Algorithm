//
//  BOJ-10451
//  백준 10451번 - 순열 사이클
//
//  Created by 손지영 on 2026/01/18
//  난이도: 실버3 | 소요시간: 40분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/10451
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 순열 그래프?
//      - i를 시작으로 순열[i]를 반복했을 때 i가 나오면 중단. 카운트 +1
//      - 1번 인덱스부터 시작하게끔 할것이므로 개수+1만큼 배열 생성
//      - 인덱스1 부터 시작해서 자식 탐색 -> 순열[자식]의 값이 순열[인덱스1]과 일치할때 종료. 카운트 +1
// 2. 자료구조
//      - 순열 [Int]
//      - 방문여부 확인 [Bool]
//      - 순열 사이클 Int
// 3. 시간 복잡도
//      - O(N) 탐색을 T만큼 반복. O(N*T)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let t = Int(readLine()!)!
    
    var sequence = Array(repeating: [Int](), count: t)
    
    for i in 0..<t {
        let c = Int(readLine()!)!
        var s = Array(repeating: 0, count: c+1)
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        for i in 1...c {
            s[i] = input[i-1]
        }
        sequence[i] = s
    }
    
    for s in sequence {
        var chk = Array(repeating: false, count: s.count)
        var cycle = 0
        
        func dfs(index: Int) {
            if index >= s.count {
                return
            }
            
            let next = s[index]
            
            guard chk[next] == false else {
                return
            }
            
            chk[next] = true
            dfs(index: next)
            
        }
        
        for i in 1..<s.count {
            if chk[i] == false {
                chk[i] = true
                cycle += 1
                dfs(index: i)
            }
        }
        
        print(cycle)
    }
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
// 넘겨야할 값. 확인해야할 값이 헷갈림
// cycle을 언제 올려줄것인가. 모든 자식 노드를 탐색하고 다음 노드를 탐색할 때 올려야한다.
