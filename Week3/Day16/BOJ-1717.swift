//
//  BOJ-1717
//  백준 1717번 - 집합의 표현
//
//  Created by 손지영 on 2026/02/06
//  난이도: 골드5 | 소요시간: 12분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1717
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - n + 1개의 집합. 입력에 대해 a b가 같은 집합인지 확인
///     - UnionFind의 union이 true면 yes, false면 no 출력
/// 2. 자료구조
///     - UnionFind
///         - parent[Int]
///         - size[Int]
/// 3. 시간복잡도
///     - O(N + M) = 1e6 + 1e5 = 1.1e6
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]
    
    var union = UnionFind(n)
    
    for _ in 0..<m {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let x = input[0]; let a = input[1]; let b = input[2]
        
        if x == 1 {
            print(union.isSameSet(a, b) ? "YES" : "NO")
        } else if x == 0 {
            union.union(a, b)
        }
    }
}

solution()

struct UnionFind {
    private var parent: [Int]
    private var size: [Int]
    
    init(_ n: Int) {
        parent = Array(0..<n+1)
        size = Array(repeating: 0, count: n+1)
    }
    
    mutating func find(_ x: Int) -> Int {
        if parent[x] == x { return x }
        parent[x] = find(parent[x])
        return parent[x]
    }
    
    mutating func union(_ a: Int, _ b: Int) {
        var ra = find(a)
        var rb = find(b)
        
        if ra == rb { return }
        
        if size[ra] < size[rb] {
            swap(&ra, &rb)
        }
        
        parent[rb] = ra
        size[ra] += size[rb]
    }
    
    mutating func isSameSet(_ a: Int, _ b: Int) -> Bool {
        return find(a) == find(b)
    }
}

// ============================================
// ❌ 헷갈린점
// ============================================
/// union은 하나의 집합으로 합치는것이고, isSameSet은 같은 집합인지 확인하는것이다.
