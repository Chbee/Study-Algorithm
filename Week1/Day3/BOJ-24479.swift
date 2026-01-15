//
//  BOJ-24479
//  백준 24479번 - 알고리즘 수업 - 깊이 우선 탐색 1
//
//  Created by 손지영 on 2026/01/14
//  난이도: 실버2 | 소요시간: 30분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/24479
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 무방향(양방향)그래프, 간선 비용 1
//      - N개의 Vertex
//      - N, M, R = 노드, 간선, 시작점
//      - DFS로 방문할 경우 노드 방문 순서 구하기, 오름차순으로 방문
//      - R로 방문할 수 없는 경우 0 출력.
//      - for문으로 현재 노드와 연결되어 있는 모든 노드들을 오름차순하여 차례대로 방문.
//      - 만약 방문되어 있다면 건너뜀
// 2. 자료구조
//      - 그래프 [[Int]]
//      - 방문순서 [Int] (0: 미방문, 1: 방문)
// 3. 시간 복잡도
//      - O(N+M) ~= 100000 + 200000 ~= 3e5
//      - 오름 차순 정렬 O(NlogN)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    typealias Nodes = (v: Int, nv: Int)
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let v = input[0]
    let e = input[1]
    let r = input[2]
    
    var grid = Array(repeating: [Nodes](), count: v + 1)
    
    var order = Array(repeating: 0, count: v + 1)
    var cnt = 0
    
    for _ in 0..<e {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let v = input[0]
        let nv = input[1]
        
        grid[v].append(Nodes(v: v, nv: nv))
        grid[nv].append(Nodes(v: nv, nv: v))
    }
    
    func dfs(node: Int) {
        cnt += 1
        order[node] = cnt
        
        for nodes in grid[node].sorted(by: { $0.nv < $1.nv}) {
            if order[nodes.nv] == 0 {
                dfs(node: nodes.nv)
            }
        }
    }
    
    dfs(node: r)
    
    for i in 1...v {
        print(order[i])
    }
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
// 반드시 방문 여부일 필요는 없다.
