//
//  BOJ-9372
//  백준 9372번 - 상근이의 여행
//
//  Created by 손지영 on 2026/02/06
//  난이도: 실버4 | 소요시간: 17분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/9372
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 가장 적은 종류의 비행기
///     - 중복 방문 가능
///     - UnionFind 사용
/// 2. 자료구조
///     - UnionFind
///         - parent [Int]
///         - size [Int]
/// 3. 시간복잡도
///     - UnionFind 초기화: O(N)
///     - union 수행: O(M)
///     ~= O(N + M) ~= 1e3 + 1e4 = 1.1e4
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let t = Int(readLine()!)!
    
    for _ in 0..<t {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let n = input[0]; let m = input[1]
        
        var union = UnionFind(n)
        
        var result = 0
        
        for _ in 0..<m {
            let input = readLine()!.split(separator: " ").map { Int($0)! }
            let a = input[0]; let b = input[1]
            
            if union.union(a, b) { result += 1 }
        }
        
        print(result)
    }
}

solution()

struct UnionFind {
    private var parent: [Int]
    private var size: [Int]
    
    init(_ n: Int) {
        parent = Array(0..<(n + 1))
        size = Array(repeating: 0, count: n + 1)
    }
    
    mutating func find(_ x: Int) -> Int {
        if parent[x]  == x { return x }
        parent[x] = find(parent[x])
        return parent[x]
    }
    
    mutating func union(_ a: Int, _ b: Int) -> Bool {
        var ra = find(a)
        var rb = find(b)
        
        if ra == rb { return false }
        
        if size[ra] < size[rb] {
            swap(&ra, &rb)
        }
        
        parent[rb] = ra
        size[ra] += size[rb]
        
        return true
    }
}

// ============================================
// ❌ 헷갈린점
// ============================================
