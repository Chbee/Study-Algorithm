//
//  BOJ-13549
//  백준 13549번 - 숨바꼭질 3
//
//  Created by 손지영 on 2026/02/24
//  난이도: 골드5 | 소요시간: 53분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/13549
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심 아이디어
///     - 걸을때: 1초, x-1, x+1
///     - 순간이동할때: 0초, 2*x
///     - n으로 k로 가기 위한 가장 빠른 시간
///     - 가중치가 0 아니면 1이므로 deque를 활용하면 된다고 함..
/// 2. 자료구조
///     - visited [Bool]
///     - deque [(Int, Int)]
/// 3. 시간복잡도
///     - O(N)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    var n = input[0]; let k = input[1]
    
    let maxK = 100_000
    
    var visited = Array(repeating: false, count: maxK + 1)
    
    func bfs(x: Int) {
        var deque = Deque<(Int, Int)>()
        deque.pushRight((x, 0))
        
        while !deque.isEmpty {
            let now = deque.popLeft()!
            
            let x = now.0
            let time = now.1
            
            if x == k {
                print(time); break
            }
            
            for i in [-1, 1, x] {
                let dx = x + i
                
                if dx < 0 || dx > maxK || visited[dx] {
                    continue
                }
                
                visited[dx] = true
                
                if i == x {
                    deque.pushLeft((dx, time))
                } else {
                    deque.pushRight((dx, time + 1))
                }
            }
        }
    }
    
    bfs(x: n)
}

struct Deque<T> {
    private var leftArray: [T] = []
    private var rightArray: [T] = []
    private var leftIndex: Int = 0
    private var rightIndex: Int = 0
    
    var isEmpty: Bool {
        return leftIndex + rightIndex >= leftArray.count + rightArray.count
    }
    
    var size: Int {
        return (leftArray.count + rightArray.count) - (leftIndex + rightIndex)
    }
    
    var front: T? {
        if isEmpty { return nil }
        
        if leftIndex >= leftArray.count {
            return rightArray[rightIndex]
        }
        
        return leftArray[leftIndex]
    }
    
    var back: T? {
        if isEmpty { return nil }
        
        if rightIndex >= rightArray.count {
            return leftArray[leftIndex]
        }
        
        return rightArray.last
    }
    
    mutating func pushLeft(_ element: T) {
        leftArray.append(element)
    }
    
    mutating func popLeft() -> T? {
        if isEmpty { return nil }
        
        if leftIndex >= leftArray.count {
            let element = rightArray[rightIndex]
            rightIndex += 1
            return element
        }
        
        return leftArray.popLast()
    }
    
    mutating func pushRight(_ element: T) {
        rightArray.append(element)
    }
    
    mutating func popRight() -> T? {
        if isEmpty { return nil }
        
        if rightIndex >= rightArray.count {
            let element = leftArray[leftIndex]
            leftIndex += 1
            return element
        }
        
        return rightArray.popLast()
    }
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
