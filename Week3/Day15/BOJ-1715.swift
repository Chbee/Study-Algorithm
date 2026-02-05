//
//  BOJ-1715
//  백준 1715번 - 카드 정렬하기
//
//  Created by 손지영 on 2026/02/05
//  난이도: 골드4 | 소요시간: 30분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1715
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 카드 묶음의 최소 비교
///     - 총 합이 작게 만들것.
///     - 10 20 40
///         1. (10 + 40) + (50 + 20) = 120
///         2. (10 + 20) + (30 + 40) = 100
///         3. (20 + 40) + (50 + 10) = 120
///         => 즉, 작은 수 부터 더하는것이 좋다.
///     - minHeap으로 pop하면서 더해나가는것이 좋겠다.
///     - "두개씩 묶는것"은 어떻게 처리하는게 좋을까.
///         - 두 수를 pop해서 더한다
///         - 그 수를 다시 push한다.
/// 2. 자료구조
///     - minHeap [Int]
/// 3. 시간복잡도
///     - O(NlogN)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var minHeap = MinHeap<Int>()
    
    for _ in 0..<n {
        minHeap.push(Int(readLine()!)!)
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

solution()

struct MinHeap<T: Comparable> {
    var heap = Heap<T>(priority: <)
    
    var isEmpty: Bool { heap.isEmpty }
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
    
    var first: T? { return store.first }
    
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
    private func left(_ i: Int) -> Int { i * 2 + 1 }
    private func right(_ i: Int) -> Int { i * 2 + 2 }
    
    private mutating func siftUp(_ i: Int) {
        var child = i
        
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
