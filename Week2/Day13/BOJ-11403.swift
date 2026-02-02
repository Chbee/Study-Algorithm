//
//  BOJ-11403
//  백준 11403번 - 경로 찾기
//
//  Created by 손지영 on 2026/02/02
//  난이도: 실버1 | 소요시간: 11분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/11403
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심 아이디어
/// 가중치 없는. 모든 정점에 대해 양수인 경로가 있는지 없는지 -> 플로이드
/// for k in 1...n // 중간지점
///     for j in 1...n // 가로
///         for i in 1...n // 세로
///             if dist[j][k] == 1 && dist[k][i] == 1
///               dist[j][i] = 1
/// 2. 자료구조
///     dist [[Int]]
/// 3. 시간 복잡도
/// N^3... 100^3 = 1000000 = 1e6
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var dist = Array(repeating: Array(repeating: 0, count: n+1), count: n+1)
    
    for i in 1...n {
        var line = [0]
        line.append(contentsOf: readLine()!.split(separator: " ").map { Int($0)! })
        dist[i] = line
    }
    
    for k in 1...n {
        for j in 1...n {
            for i in 1...n {
                if dist[j][k] == 1 && dist[k][i] == 1 {
                    dist[j][i] = 1
                }
            }
        }
    }
    
    for i in 1...n {
        print(dist[i][1...n].map({ String($0) }).joined(separator: " "))
    }
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================

