//
//  BOJ-9372
//  백준 9372번 - 상근이의 여행
//
//  Created by 손지영 on 2026/01/18 16:25
//  난이도: 실버4 | 소요시간: - | 상태: ❌
//  링크: https://www.acmicpc.net/problem/9372
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 최대한 적은 종류
//      - dfs로 가능한가?
//          -> V+E = 1000+10000 = 11000 ~= 1e4 * T(100) ~= 1e6 가능!
//      - 양방향이므로 graph [[(Int, Int)]]
//      - 다음 노드 찾을 때 +1
//      - 방문했으면 건더띔?
// 2. 자료구조
//      - Nodes(v: Int, nv: Int)
//      - map [[Nodes]]
//      - count Int
// 3. 시간 복잡도
//      - V+E = 1000+10000 = 11000 ~= 1e4 * T(100) ~= 1e6

// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    typealias Nodes = (v: Int, nv: Int)
    let t = Int(readLine()!)!
    
    for _ in 0..<t {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let n = input[0]; let m = input[1]
        
        var map = Array(repeating: [Nodes](), count: n+1)
        var chk = Array(repeating: false, count: n+1)
        
        for _ in 0..<m {
            let input = readLine()!.split(separator: " ").map { Int($0)! }
            let v = input[0]; let nv = input[1]
            
            map[v].append(Nodes(v: v, nv: nv))
            map[nv].append(Nodes(v: nv, nv: v))
        }
        
        var result = 0
        
        func dfs(node: Int) {
            chk[node] = true
            
            for node in map[node] {
                if chk[node.nv] == false {
                    result += 1
                    dfs(node: node.nv)
                }
            }
        }
        
        dfs(node: 1)
        
        print(result)
    }
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
// "연결된 노드"는 1부터 시작해도 됨
