//
//  BOJ-2606
//  백준 2606번 - 바이러스
//
//  Created by 손지영 on 2026/01/18 14:14
//  난이도: 실버3 | 소요시간: 10분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2606
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심아이디어
//      - 시작점에서 연결된 모든 노드들 검색 (무방향인것 같음 = 양방향)
//      - 자식 탐색 (dfs)
//      - 시작점에서 검색되는 자식 노드에 모두 방문함. (방문 이미 했던거면 건너띔)
//      - 1번부터 시작.(항상)
// 2. 자료구조
//      - Nodes(v: Int, nv: Int)
//      - [Nodes]
//      - [Bool] : 방문여부 확인
// 3. 시간복잡도
//      - O(V+E), 최악 O(N^2) N이 100이므로 O(10_000) : 충분.
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let v = Int(readLine()!)!
    let e = Int(readLine()!)!
    
    typealias Nodes = (v: Int, nv: Int)
    var nodes = Array(repeating: [Nodes](), count: v+1)
    
    for _ in 0..<e {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let first = input[0]; let second = input[1]
        
        nodes[first].append(Nodes(v: first, nv: second))
        nodes[second].append(Nodes(v: second, nv: first))
    }
    
    var chk = Array(repeating: false, count: v+1)
    var computer = 0
    
    func dfs(node: Int) {
        for node in nodes[node] {
            let nv = node.nv
            if chk[nv] == false {
                chk[nv] = true
                computer += 1
                dfs(node: nv)
            }
        }
    }
    
    chk[1] = true
    dfs(node: 1)
    
    print(computer)
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
