//
//  BOJ-11724
//  백준 11724번 - 연결 요소의 개수
//
//  Created by 손지영 on 2026/01/14
//  난이도: 실버2 | 소요시간: 60분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/11724
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 아이디어
//      - 무방향 그래프.
//      - 이미 방문한건 true처리하며, 현재 방문한 노드로 연결된 노드가 있는지 확인
//      - 확인이 완료되면 result +1, 다음 노드로 이동하여 찾기 (bfs)
//      - 연결요소가 없다는걸 어떻게 확인할것인가??
//      - 연결요소의 마지막이지만 아직 방문이 필요한 노드가 남아있다는것은 어떻게 확인할것인가??
// 2. 자료구조
//      - graph: [(node: Int, nextNode: Int)], n+1
//      - 연결 요소 개수 : Int
//      - chk [Bool] 노드 방문 여부
// 3. 시간복잡도
//      - dfs O(N+M) N최대값: 1000, M최댓값: N*(N-1)/2 ~= N^N - N + N ~= N^N

// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]
    let m = input[1]
    
    // v: 현재 vertex, nv: 다음 vertext
    typealias Nodes = (v: Int, nv: Int)
    
    var graph = Array(repeating: [Nodes](), count: n + 1)
    var chk = Array(repeating: false, count: n + 1)
    
    var result = 0
    
    for _ in 0..<m {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        graph[input[0]].append(Nodes(v: input[0], nv: input[1]))
        graph[input[1]].append(Nodes(v: input[1], nv: input[0]))
    }
    
    func dfs(node: Int) {
        guard chk[node] == false else { return }
        chk[node] = true
        
        for childNode in graph[node] {
            if chk[childNode.nv] == false {
                dfs(node: childNode.nv)
            }
        }
    }
    
    
    
    for i in 1..<n+1 {
        if chk[i] == false {
            result += 1
            dfs(node: i)
        }
    }
    
    print(result)
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
// 무방향은 단방향이 아니었다!
// 어디서부터 연결된 노드가 완료 된걸로 볼것인가?
