//
//  BOJ-1697
//  백준 1697번 - 숨바꼭질
//
//  Created by 손지영 on 2026/02/02
//  난이도: 실버1 | 소요시간: 45분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1697
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심 아이디어
///     - 걷는다면 좌우, 순간이동은 2X로 이동 (1초마다)
///     - 점 N이 점K가 될 수 있는 가장 빠른 시간
///     - x-1, x+1, 2*x를 적절히 조합했을 때 가장 빠른시간
///     - 각 위치를 최소 시간 순서로 확장해야함
///     - queue[Int], head
/// 2. 자료구조
///     - queue[Int]
/// 3. 시간복잡도
///     - O(N) 1e5
// ============================================
// 📌 주의사항
// ============================================
//
// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]
    let k = input[1]
    
    let maxV = 100000
    var dist = Array(repeating: -1, count: maxV + 1)
    
    func dfs(start: Int) -> Int {
        var queue = [Int]()
        var head = 0
        
        dist[start] = 0
        queue.append(start)
        
        while head < queue.count {
            let now = queue[head]
            head += 1
            
            if now == k { return dist[now] }
            
            let left = now - 1
            if left >= 0, dist[left] == -1 {
                dist[left] = dist[now] + 1
                queue.append(left)
            }
            
            let right = now + 1
            if right <= maxV, dist[right] == -1 {
                dist[right] = dist[now] + 1
                queue.append(right)
            }
            
            let double = now * 2
            if double <= maxV, dist[double] == -1 {
                dist[double] = dist[now] + 1
                queue.append(double)
            }
        }
        return -1
    }
    
    print(dfs(start: n))
}

//solution()

// ============================================
// ❌ 헷갈린점
// ============================================
///
