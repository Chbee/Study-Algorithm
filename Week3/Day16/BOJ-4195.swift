//
//  BOJ-4195
//  백준 4195번 - 친구 네트워크
//
//  Created by 손지영 on 2026/02/06
//  난이도: 골드2 | 소요시간: 30분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/4195
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 친구 네트워크에 몇 명이 있는지 구하기.
///     - 각 번호를 부여하고.. 번호 사이에 있는걸로 봐야할듯.
/// 2. 자료구조
///     - id [String: Int]
///     - UnionFind
///         - parent [Int]
///         - size [Int]
/// 3. 시간복잡도
///     - O(F) ~= 1e5
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let t = Int(readLine()!)!
    
    for _ in 0..<t {
        let f = Int(readLine()!)!
        
        var id = [String: Int]()
        var n = 1
        
        var uf = UnionFind(2*f)
        
        for _ in 0..<f {
            let fr = readLine()!.split(separator: " ").map { String($0) }
            
            let left = getId(fr[0])
            let right = getId(fr[1])
            
            uf.union(left, right)
            print(uf.getSize(left))
        }
        
        func getId(_ name: String) -> Int {
            if let v = id[name] { return v }
            id[name] = n
            n += 1
            return id[name]!
        }
    }
    
}

solution()

struct UnionFind {
    private var parent: [Int]
    private var size: [Int]
    
    init(_ n: Int) {
        parent = Array(0...n)
        size = Array(repeating: 1, count: n + 1)
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
    
    mutating func getSize(_ x: Int) -> Int {
        return size[find(x)]
    }
}

// ============================================
// ❌ 헷갈린점
// ============================================
/// parent의 크기
