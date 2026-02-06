//
//  BOJ-20040
//  백준 20040번 - 사이클 게임
//
//  Created by 손지영 on 2026/02/06
//  난이도: 골드4 | 소요시간: 28분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/20040
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 0...n-1
///     - 다시 그을 수 없지만, 교차하는것은 가능하다.
///     - C는 부분집합, 모든 선분을 한번씩만 지나서 출발점으로 되돌아 올 수 있음
///     - 몇차례의 사이클이 완성되었는지, 게임이 진행중인지를 판단
///     - isSameSet이 true이면 출력 및 종료, 아니면 union으로 조합
/// 2. 자료구조
///     - UnionFind
///         - parent [Int]
///         - size [Int]
/// 3. 시간복잡도
///     - O(N+M) = 5e5 + 1e6 = 1.5e6
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
    
    var cycle = 0
    
    for i in 0..<m {
        let round = readLine()!.split(separator: " ").map { Int($0)! }
        let a = round[0]; let b = round[1]
        
        if union.isSameSet(a, b) {
            cycle = i + 1
            break
        }
        
        union.union(a, b)
        
    }
    
    print(cycle)
}

solution()

struct UnionFind {
    private var parent: [Int]
    private var size: [Int]
    
    init(_ n: Int) {
        parent = Array(0..<n)
        size = Array(repeating: 1, count: n)
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
        
        return
    }
    
    mutating func isSameSet(_ a: Int, _ b: Int) -> Bool {
        return find(a) == find(b)
    }
}

// ============================================
// ❌ 헷갈린점
// ============================================
/// 처음 사이클이 발생하면 그 뒤는 안봐도 됨. 문제조건을 잘 이해하자
/// 입력값을 모두 소비하라는 요구가 없음 -> 조건이 맞으면 바로 출력하고 종료해도 됨
