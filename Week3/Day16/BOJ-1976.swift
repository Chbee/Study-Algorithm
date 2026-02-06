//
//  BOJ-1976
//  백준 1976번 - 여행 가자
//
//  Created by 손지영 on 2026/02/06
//  난이도: 골드4 | 소요시간: 13분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1976
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 도시 N개, 길이 있을수도 없을수도 있음
///     - 경로가 가능한지 판단, 중복 방문도 가능
///     - i, j값이 1인것을 union으로 조합.
///     - 마지막 계획이 모두 true이면 YES
/// 2. 자료구조
///     - UnionFind
///         - parent [Int]
///         - size [Int]
/// 3. 시간복잡도
///     - O(N + M) = 2e2 + 1e3 = 1.2e3
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    let _ = Int(readLine()!)!
    
    var union = UnionFind(n)
    
    for j in 1...n {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        for i in 0..<input.count {
            if input[i] == 1 {
                union.union(j, i+1)
            }
        }
    }
    
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    var result = 0
    for i in 1..<input.count {
        if union.isSameSet(input[i-1], input[i]) {
            result += 1
        }
    }
    print(result == (input.count - 1) ? "YES" : "NO")
}

solution()

struct UnionFind {
    private var parent: [Int]
    private var size: [Int]
    
    init(_ n: Int) {
        parent = Array(0..<n+1)
        size = Array(repeating: 1, count: n+1)
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

/*
swift BOJ-1976.swift <<EOF
3
3
0 1 0
1 0 1
0 1 0
1 2 3
EOF
 */
