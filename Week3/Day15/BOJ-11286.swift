//
//  BOJ-11286
//  백준 11286번 - 절댓값 힙
//
//  Created by 손지영 on 2026/02/05
//  난이도: 실버1 | 소요시간: 27분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/11286
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 가장 작은값 출력, minHeap
///     - 절대값 중 가장 작은 수 출력, 그 값을 배열에서 제거
///     - 절대값이 같으면 음수 출력
///     - 입력받는 값이 0이면 출력, 0이 아니면 입력
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
    
    var heap = MinHeap()
    
    for _ in 0..<n {
        let x = Int(readLine()!)!
        
        if x == 0 {
            print(heap.minValue ?? 0)
            _ = heap.pop()
        } else {
            heap.push(x)
        }
    }
}

solution()

struct MinHeap {
    private var heap = Heap<Int>(priority: { a, b in
        let aa = abs(a); let bb = abs(b)
        return aa == bb ? a < b : aa < bb
    })
    
    var minValue: Int? { heap.first() }
    
    mutating func push(_ v: Int) { heap.push(v) }
    mutating func pop() -> Int? { heap.pop() }
}

struct Heap<T> {
    private var store: [T] = []
    private let priority: (T, T) -> Bool
    
    init(priority: @escaping (T, T) -> Bool) {
        self.priority = priority
    }
    
    var isEmpty: Bool { store.isEmpty }
    var count: Int { store.count }
    
    func first() -> T? {
        return store.first
    }
    
    mutating func push(_ v: T) {
        store.append(v)
        siftUp(store.count - 1)
    }
    
    mutating func pop() -> T? {
        guard !store.isEmpty else { return nil }
        
        if store.count == 1 {
            return store.removeLast()
        }
        
        var temp = store[0]
        
        store[0] = store.removeLast()
        
        siftDown(0)
        
        return temp
    }
    
    private func parent(_ i: Int) -> Int { (i - 1) / 2 }
    private func left(_ i: Int) -> Int { (i * 2) + 1 }
    private func right(_ i: Int) -> Int { (i * 2) + 2 }
    
    private mutating func siftUp(_ index: Int) {
        var child = index
        
        while child > 0 {
            var parent = parent(child)
            if priority(store[child], store[parent]) {
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
            
            if left < store.count, priority(store[left], store[candidate]) {
                candidate = left
            }
            
            if right < store.count, priority(store[right], store[candidate]) {
                candidate = right
            }
            
            if parent == candidate { break }
            
            store.swapAt(parent, candidate)
            parent = candidate
        }
    }
}

// ============================================
// ❌ 헷갈린점
// ============================================
