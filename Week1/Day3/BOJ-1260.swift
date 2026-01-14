//
//  BOJ-1260
//  백준 1260번 - DFS와 BFS
//
//  Created by 손지영 on 2026/01/14
//  난이도: 실버2 | 소요시간: 60분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1260
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 사용할 자료구조/알고리즘:
//    - dfs, bfs
//    - 정점 개수: n, 간선 개수: m, 탐색을 시작할 정점의 번호: v
//    - 그래프: [[(Int, Int)]] (간선, 노드)
//    - dfsV: [Int]
//    - bfsV: [Int]
//    - chk: [Bool] 방문여부
//
// 2. 시간복잡도:
//    - bfs: O(V+ElogE)
//    - dfs: O(V+ElogE)
//
// 3. 접근 방법:
//    - 양방향인데 MST 안쓰고 bfs, dfs로 접근 필요
//    - bfs: 너비 우선 탐색
//          방문해야하는 "노드"들을 queue에 담아놓고 하나씩 제거해가며 탐색
//          while문으로 queue들을 하나씩 꺼내서 확인.
//          queue의 cnt가 방문한 것들에 대한 count보다 크거나 같을때 반복문 종료.
//          방문한 것들에 대해 int append
//    - dfs: 깊이 우선 탐색
//          방문 해야하는 것들을 우선 모두 탐색 후 다음 index 탐색
//          for + 재귀 필요
//          for문에는 1..<n+1 만큼 방문 필요
//          방문 여부 확인 및 dfs 실행 (현재 노드, 방문해야하는 노드)
//          dfs 내부에서 방문 한 노드인지 확인 후 방문 안한거면 방문 해야할 노드의 자식 노드로 검색 시작
//    - 공통:
//          이미 방문한건지 체크, 방문 안했으면 진행.

// ============================================
// 📌 주의사항
// ============================================
// -

// ============================================
// 🔨 구현
// ============================================

func solution() {
    typealias Node = (v: Int, nv: Int)
    
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]
    let m = input[1]
    let v = input[2]
    
    var graph = Array(repeating: [Node](), count: n+1)
    
    for _ in 0..<m {
        let graphInput = readLine()!.split(separator: " ").map { Int($0)! }
        graph[graphInput[0]].append(Node(v: graphInput[0], nv: graphInput[1]))
        graph[graphInput[1]].append(Node(v: graphInput[1], nv: graphInput[0]))
    }
    
    func dfs_solution() {
        var result = [Int]()
        var chk = Array(repeating: false, count: n+1)
        
        func dfs(i: Int) {
            chk[i] = true
            result.append(i)
            
            let sortNodes = graph[i].sorted(by: { $0.nv < $1.nv })
            for childNode in sortNodes {
                if chk[childNode.nv] == false {
                    dfs(i: childNode.nv)
                }
            }
        }
        
        dfs(i: v)
        print(result.map { String($0) }.joined(separator: " "))
    }
    
    func bfs_solution() {
        var head = 0
        var result = [Int]()
        
        var chk = Array(repeating: false, count: n+1)
        var queue: [Int] = []
        
        queue.append(v)
        chk[v] = true
        
        func bfs() {
            while head < queue.count {
                let node = queue[head]
                head += 1
                
                result.append(node)
                let newGraph = graph[node].sorted(by: {
                    $0.nv < $1.nv
                })
                for childNode in newGraph {
                    if chk[childNode.nv] == false {
                        chk[childNode.nv] = true
                        queue.append(childNode.nv)
                    }
                }
            }
        }
        bfs()
        print(result.map { String($0) }.joined(separator: " "))
    }
    
    dfs_solution()
    bfs_solution()
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
// 너비를 탐색하는 방법은 생각해도 생각해도 어렵다.
