//
//  BOJ-1043
//  백준 1043번 - 거짓말
//
//  Created by 손지영 on 2026/02/06
//  난이도: 골드4 | 소요시간: 50분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1043
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 진실: 조합에 속함, 거짓(과장): 진실과 같은 조합에 속하지 않음
///     - 진실을 아는 사람이 0이면 바로 파티갯수 출력, 아니면 가능한 파티 개수 출력
///     - p < 입력받는 참석자 수와 사람들의 번호
///         var canLying = true
///         for i in 0..<p[0].count
///             if isSameSet(p[i], 진실을아는사람들) == true: canLying = false; break
///
///         if canLying { 거짓말 가능한 파티 개수 += 1 }
/// 2. 자료구조
///     - UnionFind
///         - parent [Int]
///         - size [Int]
///     - 진실을아는사람들 [Int]
///     - 거짓말 가능한 파티 개수 Int
/// 3. 시간복잡도
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]
    
    let t = readLine()!.split(separator: " ").map { Int($0)! }
    
    if t.count == 1, t[0] == 0 { print(m) }
    else {
        
        var uf = UnionFind(n)
        var partyReps = [Int]()
        
        /// 진실을 아는 사람 입장
        let truth = Array(t[1..<t.count])
        
        for i in 1..<truth.count {
            uf.union(truth[i], truth[i-1])
        }
        
        /// 파티 별 입장
        for _ in 0..<m {
            let p = readLine()!.split(separator: " ").map { Int($0)! }
            
            let e = Array(p[1..<p.count])
            partyReps.append(e.first!)
            
            for i in 1..<e.count {
                uf.union(e[i], e[i-1])
            }
        }
        
        var result = 0
        
        let truthRoot = uf.find(truth.first!)
        
        for e in partyReps {
            var canLie = true
            if uf.find(e) == truthRoot {
                canLie = false
            }
            if canLie { result += 1 }
        }
        
        print(result)
    }
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
    
    mutating func setSize(_ x: Int) -> Int {
        return size[find(x)]
    }
}

// ============================================
// ❌ 헷갈린점
// ============================================

/*
swift BOJ-1043.swift <<EOF
4 5
1 1
1 1
1 2
1 3
1 4
2 4 1
EOF
 => 2 */

/*
swift BOJ-1043.swift <<EOF
10 9
4 1 2 3 4
2 1 5
2 2 6
1 7
1 8
2 7 8
1 9
1 10
2 3 10
1 4
EOF
=> 4 */
