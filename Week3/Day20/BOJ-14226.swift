//
//  BOJ-14226
//  백준 14226번 - 이모티콘
//
//  Created by 손지영 on 2026/02/19
//  난이도: 골드4 | 소요시간: 22분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/14226
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 초기값: 이모티콘 1개
///     - 이모티콘 s개
///     - 모든 이모티콘 복사 및 붙여넣기, 중 하나 삭제 -> 각 연산은 1초씩 소요
///     - s개를 만드는데 걸리는 시간의 최솟값
///     - 붙여넣기 할때 +1, 삭제할때 -1
///     - BFS로 우선 풀어보기
///     - (스크린에 있는 스티커 수, 클립 보드에 잇는 스티커 수)
///     - (1, 0) < 기본값
///     - 이모티콘 모두 복사 => (screen, screen, time + 1)
///     - 클립보두 모두 붙여넣기 => (screen + clipboard, clipboard, time + 1)
///     - 화면에 있는 이모티콘 하나 삭제 => (screen - 1, clipboard, time + 1)
///     - 단순 BFS는 메모리 초과 됨. 메모리를 줄일 수 있는 방법이 필요. 이미 계산한 값인지 확인 필요: 최솟값을 찾는것이므로
///     - visitied[s][c] = false면 동작. 기본값: target * 2
/// 2. 자료구조
///     - state (Int, Int, Int)
///     - queue [State]
///     - head Int
///     - visited [[Bool]]
/// 3. 시간복잡도
///     - O(N^2)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let target = Int(readLine()!)!
    
    typealias State = (s: Int, c: Int, t: Int)
    
    let maxV = target * 2
    var visited = Array(repeating: Array(repeating: false, count: maxV + 1), count: maxV + 1)
    
    var queue = [State]()
    queue.append(State(s: 1, c: 0, t: 0))
    visited[1][0] = true
    var head = 0
    
    while head < queue.count {
        let (s, c, t) = queue[head]
        head += 1
        
        if s == target {
            print(t)
            break
        }
        
        if s > 0 && !visited[s - 1][c] {
            visited[s - 1][c] = true
            queue.append(State(s: s - 1, c: c, t: t + 1))
        }
        
        if c > 0 && s + c <= maxV && !visited[s + c][c] {
            visited[s + c][c] = true
            queue.append(State(s: s + c, c: c, t: t + 1))
        }
        
        if !visited[s][s] {
            visited[s][s] = true
            queue.append(State(s: s, c: s, t: t + 1))
        }
        
    }
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
