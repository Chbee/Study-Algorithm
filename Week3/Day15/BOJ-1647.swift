//
//  BOJ-1647
//  백준 1647번 - 도시 분할 계획
//
//  Created by 손지영 on 2026/02/04
//  난이도: 골드4 | 소요시간: 50분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1647
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심 아이디어
///     - 연결되도록 분할...
///     - 유지비의 합을 최소로
///     - 연결된 집은 제외를 한다면?
///     - 연결된 집을 알기 위해 Visited 필요.
///     - while let (to_city, value)? = heap.pop()
///         if to_city != visitied
///             to_city = visitied
///             result += value
/// 2. 자료구조
///     minHeap [Edge]
///     graph (n, c) (다음 노드, 비용)
///     visited [Bool]
///     result Int
/// 3. 시간복잡도
///     O(MlogN)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]
    
    var visited = Array(repeating: false, count: n + 1)
    var graph = Array(repeating: [(Int, Int)](), count: n + 1)
    
    var minHeap = MinHeap<Edge>()
    
    for _ in 0..<m {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        
        let u = input[0]; let v = input[1]; let w = input[2]
        graph[u].append((v, w))
        graph[v].append((u, w))
    }
    
    minHeap.push(Edge(to: 1, cost: 0))
    
    var result = 0
    var visitedCount = 0
    var maxEdge = 0
    
    while let edge = minHeap.pop() {
        let v = edge.to
        
        if visited[v] { continue }
        
        visited[v] = true
        visitedCount += 1
        
        result += edge.cost
        
        if edge.cost > maxEdge { maxEdge = edge.cost }
        
        for (next, cost) in graph[v] {
            if !visited[next] {
                minHeap.push(Edge(to: next, cost: cost))
            }
        }
        
        if visitedCount == n { break }
    }
    
    print(result - maxEdge)
}

solution()

struct Edge: Comparable {
    var to: Int
    var cost: Int
    
    static func < (lhs: Edge, rhs: Edge) -> Bool {
        return lhs.cost < rhs.cost
    }
}

struct MinHeap<T: Comparable> {
    var heap = Heap<T>(priority: <)
    
    mutating func push(_ v: T) { heap.push(v) }
    mutating func pop() -> T? { heap.pop() }
}

struct Heap<T> {
    private var store: [T] = []
    private let priority: (T, T) -> Bool
    
    init(priority: @escaping (T, T) -> Bool) {
        self.priority = priority
    }
    
    var isEmpty: Bool { store.isEmpty }
    var count: Int { store.count }
    var first: T? { store.first }
    
    mutating func push(_ v: T) {
        store.append(v)
        siftUp(store.count - 1)
    }
    
    mutating func pop() -> T? {
        guard !store.isEmpty else { return nil }
        
        if store.count == 1 {
            return store.removeLast()
        }
        
        let temp = store[0]
        store[0] = store.removeLast()
        siftDown(0)
        
        return temp
    }
    
    private func parent(_ i: Int) -> Int { (i - 1) / 2 }
    private func left(_ i: Int) -> Int { 2 * i + 1 }
    private func right(_ i: Int) -> Int { 2 * i + 2 }
    
    private mutating func siftUp(_ i: Int) {
        var child = i
        
        while child > 0 {
            let parent = parent(child)
            
            if priority(store[child], store[parent]) {
                store.swapAt(child, parent)
                child = parent
            } else {
                break
            }
        }
    }
    
    private mutating func siftDown(_ i: Int) {
        var parent = i
        
        while true {
            let left = left(parent)
            let right = right(parent)
            
            var candidate = parent
            
            if left < store.count, priority(store[left], store[candidate]) {
                candidate = left
            }
            
            if right < store.count, priority(store[right], store[candidate]) {
                candidate = right
            }
            
            if candidate == parent { break }
            
            store.swapAt(parent, candidate)
            parent = candidate
        }
    }
}


// ============================================
// ❌ 헷갈린점
// ============================================
/// 방문 여부를 어떻게 확인할것인가
/// 비용 관리는 어떻게 할것인가.
