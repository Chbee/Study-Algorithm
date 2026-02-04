//
//  BOJ-1927
//  백준 1927번 - 최소 힙
//
//  Created by 손지영 on 2026/02/04
//  난이도: 실버2 | 소요시간: 13분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1927
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심 아이디어
///     - 입력받은 값이 0이면 최소값 출력 후 pop, 0이 아니면 push
/// 2. 자료구조
///     - minHeap [Int]
/// 3. 시간복잡도
///     - O(logN)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var minHeap = MinHaep<Int>()
    
    for _ in 0..<n {
        let x = Int(readLine()!)!
        
        if x == 0 {
            print(minHeap.minVal() ?? "0")
            minHeap.pop()
        } else {
            minHeap.push(x)
        }
    }
}

solution()

struct MinHaep<T: Comparable> {
    private var heap = Heap<T>(sort: <)
    
    func minVal() -> T? {
        return heap.first()
    }
    
    mutating func push(_ v: T) { heap.push(v) }
    mutating func pop() -> T? { heap.pop() }
}

struct Heap<T> {
    private var store: [T] = []
    private let sort: (T, T) -> Bool
    
    init(sort: @escaping (T, T) -> Bool) {
        self.sort = sort
    }
    
    var isEmpty: Bool { store.isEmpty }
    var count: Int { store.count }
    
    mutating func push(_ value: T) {
        store.append(value)
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
    
    func first() -> T? {
        return store.first
    }
    
    private func parent(_ i: Int) -> Int { (i - 1) / 2 }
    private func left(_ i: Int) -> Int { i * 2 + 1 }
    private func right(_ i: Int) -> Int { i * 2 + 2 }
    
    private mutating func siftUp(_ index: Int) {
        var child = index
        
        while child > 0 {
            let parent = parent(child)
            
            if sort(store[child], store[parent]) {
                store.swapAt(child, parent)
                child = parent
            } else {
                break
            }
        }
    }
    
    private mutating func siftDown(_ index: Int) {
        var parent = index
        
        while true {
            let left = left(parent)
            let right = right(parent)
            var candidate = parent
            
            if left < store.count && sort(store[left], store[candidate]) {
                candidate = left
            }
            
            if right < store.count && sort(store[right], store[candidate]) {
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
