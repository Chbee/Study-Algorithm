//
//  BOJ-1389
//  백준 1389번 - 케빈 베이컨의 6단계 법칙
//
//  Created by 손지영 on 2026/02/02
//  난이도: 실버1 | 소요시간: 18분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1389
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심 아이디어
///     최소 몇단계 만에
///     모든 노드에서 모든 노드까지 양방향, 가중치가 가장 작은것: 플로이드
///     for k in 1...n
///         for j in 1...n
///             for i in 1...n
///                 if dist[j][i] > dist[j][k] + dist[k][i]
///                     dist[j][i] = dist[j][k] + dist[k][i]
/// 2. 자료구조
///     dist[[Int]]
///     best Int
///     user Int
/// 3. 시간 복잡도
///     O(N^3)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]
    
    var dist = Array(repeating: Array(repeating: Int.max, count: n+1), count: n+1)
    
    for i in 1...n {
        dist[i][i] = 0
    }
    
    for _ in 1...m {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let a = input[0]
        let b = input[1]
        
        dist[a][b] = 1
        dist[b][a] = 1
    }
    
    var best = Int.max
    var user = 1
    
    for k in 1...n {
        for j in 1...n {
            for i in 1...n {
                if dist[j][k] != Int.max && dist[k][i] != Int.max,
                   dist[j][i] > dist[j][k] + dist[k][i] {
                    dist[j][i] = dist[j][k] + dist[k][i]
                }
            }
        }
    }
    
    for i in 1...n {
        var sum = 0
        for j in 1...n {
            sum += dist[i][j]
        }
        if sum < best {
            best = sum
            user = i
        }
    }

    print(user)
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
/// 출력은 "사람"이다 지인을 많이 아는 "사람"
