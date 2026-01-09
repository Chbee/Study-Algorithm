
import Foundation

// MARK: - Floyd
// 모든 노드에서 다른 모든 노드까지 가는데 최소비용 O(V^3)
//
// MSTExample.png 기준
// 양방향 이동을 중복으로 하지 않음
//
// 노드 j -> 노드 i 비용 배열 만들기, 초기값 : INF
// j -> i 비용이 표로 정리되는 형태로 상상
// 모든 노드에 대해 해당 노드를 "거쳐가서" 비용이 작아질 경우 값 갱신.
//
// (1) -> (4) 이동의 초기값은 INF
// 1. (2)를 거치게 되면 INF에서 7로 비용이 줄어듬 -> 7로 갱신
// 2. (3)을 거치는 방법 확인, 비용이 11이 됨 -> 갱신안함
//
// https://www.acmicpc.net/problem/11404
//
/*
 1. 아이디어
    - 모든점 -> 모든점: 플로이드
    - 거리값 무한대 설정, 자기 자신으로 가는 값 0
 2. 시간복잡도
    - 다익스트라 사용할 경우: ElogV * V
            -> 1e5(E) * 10(logV) * 1e2(V) = 1e8 : 시간 초과 가능성
    - 플로이드 사용할 경우: V^3
            -> 1e6
 3. 자료구조
    - 거리배열: [[Int]]
            비용 최대?
                = 간선 최대 비용(1e5) * 노드 최대 갯수(1e2) = 1e7 Int사용가능
 */

func solution() {
    
    let n = Int(readLine()!)!
    let m = Int(readLine()!)!
    
    let _infArr = Array(repeating: Int.max, count: n+1)
    var rs = Array(repeating: _infArr, count: n+1)
    
    for i in 1..<n+1 {
        (rs[i])[i] = 0
    }
    
    for _ in 0..<m {
        let input = readLine()!.split(separator: " ").compactMap { Int($0) }
        let a = input[0]
        let b = input[1]
        let c = input[2]
        
        (rs[a])[b] = min((rs[a])[b], c)
    }
    
    for k in 1..<n+1 { // 거치는 값
        for j in 1..<n+1 { // 시작노드
            for i in 1..<n+1 { // 도착노드
                if rs[j][k] != Int.max && rs[k][i] != Int.max {
                    if (rs[j])[i] > (rs[j])[k] + (rs[k])[i] {
                        (rs[j])[i] = (rs[j])[k] + (rs[k])[i]
                    }
                }
            }
        }
    }
    
    for j in 1...n {
        print((1...n).map { rs[j][$0] == Int.max ? "0" : String(rs[j][$0]) }.joined(separator: " "))
    }
}

solution()

// MARK: - TIPs
// 한점 -> 여러점: 다익스트라 ElogV
// 여러점 -> 여러점: 플로이드 V^3
