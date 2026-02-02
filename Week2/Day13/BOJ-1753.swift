//
//  BOJ-1753
//  백준 1753번 - 최단경로
//
//  Created by 손지영 on 2026/02/02
//  난이도: 골드4 | 소요시간: - | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1753
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
///  1. 핵심아이디어
///     주어진 시작점 -> 모든 정점으로의 "최단 경로" 다익스트라, HEAP
///     (V: 간선, E: 가중치)로 저장
///     비용은 초기값이 Int.max, 시작점은 0, 인접한 노드의 경로 비용으로 업데이트
///     while heap에서 pop하며 진행 (ew, ev) = heap.pop()
///         dist[ev]의 값이 ew와 다르면 건너띔 (중복 노드 고려x)
///         edge[ev]로 인접한 모든 노드 찾기
///             dist[인접한_노드의_연결된_노드]의 비용이 ew + 인접한_노드 비용보다 크면
///                 dist에 값을 업데이트 해주고 heap에 추가
///  2. 자료구조
///     heap [(비용: Int, 노드: Int)]
///     edge [(비용: Int, 노드: Int)] - 인접리스트
///     dist [Int]
///  3. 시간복잡도
///     - heap: O(ElogV)
///     - E: 3e5
///     - V: 2e4 logV ~= log10^4 log ~= 10^2 = 2^10, 10^4 = 2^20 ~= 20
///     - 2e1 * 3e5 ~= 6e6
///
// ============================================
// 📌 주의사항
// ============================================
//
// ============================================
// 🔨 구현
// ============================================

typealias Edge = (w: Int, n: Int)

struct MinHeap {
    private var a: [Edge] = []
    
    var isEmpty: Bool { a.isEmpty }
    
    mutating func push(_ x: Edge) {
        a.append(x)
        siftUp(from: a.count - 1)
    }
    
    mutating func pop() -> Edge? {
        guard !a.isEmpty else { return nil }
        if a.count == 1 { return a.removeLast() }
        
        a.swapAt(0, a.count - 1)
        let minVal = a.removeLast()
        siftDown(from: 0)
        return minVal
    }
    
    private mutating func siftUp(from index: Int) {
        var child = index
        while child > 0 {
            let parent = (child - 1) / 2
            if a[child].w < a[parent].w {
                a.swapAt(child, parent)
                child = parent
            } else {
                break
            }
        }
    }
    
    private mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = parent * 2 + 1
            let right = left + 1
            var candiate = parent
            
            if left < a.count && a[left].w < a[candiate].w {
                candiate = left
            }
            if right < a.count && a[right].w < a[candiate].w {
                candiate = right
            }
            
            if candiate == parent { break }
            
            a.swapAt(parent, candiate)
            parent = candiate
        }
    }
}

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let v = input[0]; let e = input[1]
    
    let k = Int(readLine()!)!
    
    var edge = Array(repeating: [Edge](), count: v+1)
    var dist = Array(repeating: Int.max, count: v+1)
    
    for _ in 0..<e {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        
        let u = input[0]
        let v = input[1]
        let w = input[2]
        
        edge[u].append(Edge(w: w, n: v))
    }
    
    dist[k] = 0
    
    var heap = MinHeap()
    heap.push(Edge(w: 0, n: k))
    
    while let (ew, en) = heap.pop() {
        if dist[en] != ew { continue }
        
        for next in edge[en] {
            let nw = next.w
            let nv = next.n
            
            if dist[nv] > ew + nw {
                dist[nv] = ew + nw
                heap.push(Edge(w: ew + nw, n: nv))
            }
        }
    }
    
    for i in 1...v {
        if dist[i] == Int.max { print("INF") }
        else { print(dist[i]) }
    }
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
//

