//
//  BOJ-2252
//  백준 2252번 - 줄 세우기
//
//  Created by 손지영 on 2026/02/08
//  난이도: 골드3 | 소요시간: - | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2252
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 두 키를 비교, 일부만
///     - 일부 정보를 가지고 줄 세우기 (일부 정보 = 선행 조건)
///     - A, B: A가 B보다 앞에 서야함
/// 2. 자료구조
/// 3. 시간복잡도
// ============================================
// 📌 주의사항
// ============================================
/// 연습문제로 소요시간 미기입
// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! } // N, M 입력
    let n = input[0]; let m = input[1] // n: 학생 수, m: 비교 횟수
    
    var adj = Array(repeating: [Int](), count: n + 1) // 인접 리스트
    var indeg = Array(repeating: 0, count: n + 1) // 진입차수
    
    for _ in 0..<m {
        let input = readLine()!.split(separator: " ").map { Int($0)! } // A B
        
        let a = input[0]; let b = input[1] // a가 b보다 앞
        adj[a].append(b) // 간선 a -> b
        indeg[b] += 1 // b의 선행조건(진입차수) 증가
    }
    
    var queue = [Int]() // indeg == 0 노드 큐
    queue.reserveCapacity(n) // 성능을 위해 미리 확보
    
    for i in 1...n where indeg[i] == 0 { // 선행조건 없는 노드만 시작 가능
        queue.append(i) // 시작 후보 추가
    }
    
    var head = 0 // 배열 큐 인덱스
    var order = [Int]() // 위상정렬 결과
    
    while head < queue.count { // 큐가 빌 때까지
        let cur = queue[head] // 처리할 노드
        head += 1 // pop 효과
        order.append(cur) // 결과에 추가
        
        for nxt in adj[cur] { // cur 뒤에 와야 하는 노드들
            indeg[nxt] -= 1 // 선행조건 하나 충족
            if indeg[nxt] == 0 { // 모든 선행조건 완료
                queue.append(nxt) // 이제 시작 가능
            }
        }
    }
    
    print(order.map({ String($0) }).joined(separator: " "))
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
