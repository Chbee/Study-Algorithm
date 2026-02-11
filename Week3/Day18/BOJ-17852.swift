//
//  BOJ-17852
//  백준 17852번 - Retribution!
//
//  Created by 손지영 on 2026/02/10
//  난이도: 실버1 | 소요시간: 62분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/17852
//

import Foundation
import Glibc

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 타르 저장소, 깃털 보관소
///     - 타르 저장소와 심사위원 위치 사이의 거리가 가장 짧은 저장소를 찾아, 배정
///     - 모든 심사위원에게 배정될 때 까지 반복
///     - 깃털 보관소로 다시 배정
///     - 동점일 경우, 낮은 번호의 심판관 -> 낮은 번호의 보관소/저장소
///     - 근처의 xy를 탐색. 최대값은 입력받는 n, m, p
///     - 방문여부를 체크하고 count +=1 해야하는데
/// 2. 자료구조
///     - n: 심사위원 수
///     - m: 타르 저장소 수
///     - p: 깃털 저장소 수
///     - ns: [(Int, Int)] - 심사위원 위치
///     - ms: [(Int, Int)] - 타르 저장소 위치
///     - ps: [(Int, Int)] - 깃털 저장소 위치
/// 3. 시간복잡도
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]; let p = input[2]
    
    typealias Point = (x: Int, y: Int)
    
    var ns = Array(repeating: Point(x: 0, y: 0), count: n + 1)
    var ms = Array(repeating: Point(x: 0, y: 0), count: m + 1)
    var ps = Array(repeating: Point(x: 0, y: 0), count: p + 1)
    
    inputV(for: n, in: &ns)
    inputV(for: m, in: &ms)
    inputV(for: p, in: &ps)
    
    func inputV(for k: Int, in arr: inout [Point]) {
        for i in 1...k {
            let input = readLine()!.split(separator: " ").map { Int($0)! }
            arr[i] = Point(x: input[0], y: input[1])
        }
    }
    
    typealias Pair = (d: Double, j: Int, s: Int)
    
    var mValue = [Pair]()
    mValue.reserveCapacity(n * m)
    var pValue = [Pair]()
    pValue.reserveCapacity(n * p)
    
    for j in 1...n {
        for s in 1...m {
            let dx = Double(ms[s].x - ns[j].x)
            let dy = Double(ms[s].y - ns[j].y)
            let d = sqrt(dx * dx + dy * dy)
            mValue.append(Pair(d: d, j: j, s: s))
        }
        
        for s in 1...p {
            let dx = Double(ps[s].x - ns[j].x)
            let dy = Double(ps[s].y - ns[j].y)
            let d = sqrt(dx * dx + dy * dy)
            pValue.append(Pair(d: d, j: j, s: s))
        }
    }
    
    mValue.sort {
        if $0.d != $1.d { return $0.d < $1.d }
        if $0.j != $1.j { return $0.j < $1.j }
        return $0.s < $1.s
    }
    
    pValue.sort {
        if $0.d != $1.d { return $0.d < $1.d }
        if $0.j != $1.j { return $0.j < $1.j }
        return $0.s < $1.s
    }
    
    var rs = 0.0
    
    rs += sortByDistance(store: mValue, storeCnt: m)
    rs += sortByDistance(store: pValue, storeCnt: p)
    
    func sortByDistance(store: [Pair], storeCnt: Int) -> Double {
        var rs = 0.0
        var matched = 0
        
        var nVisitied = Array(repeating: false, count: n + 1)
        var sVisited = Array(repeating: false, count: storeCnt + 1)
        
        for p in store {
            if !nVisitied[p.j] && !sVisited[p.s] {
                nVisitied[p.j] = true
                sVisited[p.s] = true
                rs += p.d
                
                matched += 1
                if matched == n { break }
            }
        }
        
        return rs
    }
    
    print(rs)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
/// "쌍으로"하는 최소 값에 대한 이해
/// 유클리드 거리?
