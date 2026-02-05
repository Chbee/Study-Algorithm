//
//  BOJ-13975
//  백준 13975번 - 파일 합치기 3
//
//  Created by 손지영 on 2026/02/04
//  난이도: 골드4 | 소요시간: 23분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/13975
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 두 개의 파일을 합쳐 하나의 임시파일 생성
///         -> 합친 값을 push
///     - 최종적으로 한개의 파일을 완성하는데 필요한 비용의 총 합
///     - 비용: 두 개의 파일을 합칠 때 필요한 시간등에 대한 것.
///     - 40, 30, 30, 50
///         1. (40 + 30) + (30 + 50) + 70 + 80 = 300
///         2. (30 + 30) + (60 + 40) + 100 + 50 = 310
/// 2. 자료구조
///     - minHeap
/// 3. 시간복잡도
///     - O(NlogN)
///         -> 1e4 10^4 ~= 2^20
///         -> NlogN = 1e4 * 2e1 = 2e5
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let t = Int(readLine()!)!
    
    for _ in 0..<t {
        let _ = Int(readLine()!)
        
        var minHeap = MinHeap<Int>()
        
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        input.forEach {
            minHeap.push($0)
        }
        
        var result = 0
        
        while minHeap.count > 1 {
            let left = minHeap.pop() ?? 0
            let right = minHeap.pop() ?? 0
            
            let sum = left + right
            result += sum
            minHeap.push(sum)
        }
        
        print(result)
    }
}

solution()

struct MinHeap<T: Comparable> {
    var heap = Heap<T>(priority: <)
    
    var count: Int { heap.count }
    
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
    
    mutating private func siftUp(_ index: Int) {
        var child = index
        
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
    
    mutating private func siftDown(_ index: Int) {
        var parent = index
        
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


/*
swift BOJ-13975.swift <<EOF
2
4
40 30 30 50
15
1 21 3 4 5 35 5 4 3 5 98 21 14 17 32
EOF
 */
