//
//  BOJ-20055
//  백준 20055번 - 컨베이어 벨트 위의 로봇
//
//  Created by 손지영 on 2026/02/20
//  난이도: 골드5 | 소요시간: 50분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/20055
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 1번칸 올리는곳, N번칸 내리는 곳
///     - 내구도와 간격이 1씩
///     - 로봇의 이동이 발생하면 내구도가 1만큼 감소함
///     - 로봇 옮기기 순서
///         1. 로봇과 함께 한 칸 회전
///         2. 내구도가 1 이상 있고, 이동하려는 칸에 로봇이 없으면 이동, 안되면 정지
///         3. 올리는 위치의 칸의 내구도가 0이 아니면 로봇을 올림
///         4. 내구도가 0인 칸의 개수가 K개 이상이면 과정 종료 아니면 1로 이동
///     - 현재 바라보는 칸의 Idx 필요
///     - 내구도가 0일 때 마다 수집하는 변수 필요
///     - 3x2 일 때, 1 -> 2 -> 3 -> N -> N-1 -> N-2, 두번째 배열을 역순으로 혹은 N - i
///     - [0][0]: 올리는곳 [1][0]: 내리는곳
/// 2. 자료구조
///     - broken, step Int
///     - position [Bool]
/// 3. 시간복잡도
///     - O(N * 찾아내는 단계)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let k = input[1]
    
    var a = readLine()!.split(separator: " ").map { Int($0)! }
    
    var broken = a.filter { $0 == 0 }.count
    var step = 0
    
    var position = Array(repeating: false, count: n)
    
    
    while broken < k {
        step += 1
        rotate()
        
        for i in stride(from: n - 2, through: 0, by: -1) {
            if position[i] && !position[i + 1] && a[i + 1] > 0 {
                position[i] = false
                position[i+1] = true
                a[i+1] -= 1
                if a[i+1] == 0 { broken += 1 }
            }
        }
        position[n-1] = false
        
        if !position[0] && a[0] > 0 {
            position[0] = true
            a[0] -= 1
            if a[0] == 0 { broken += 1 }
        }
        
    }
    
    func rotate() {
        let lastIdx = 2 * n - 1
        let tempA = a[lastIdx]
        for i in stride(from: lastIdx, to: 0, by: -1) {
            a[i] = a[i-1]
        }
        a[0] = tempA
        
        for i in stride(from: n - 1, to: 0, by: -1) {
            position[i] = position[i-1]
        }
        position[0] = false
        position[n-1] = false
    }
    
    print(step)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
