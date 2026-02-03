//
//  BOJ-1697
//  백준 1697번 - 숨바꼭질
//
//  Created by 손지영 on 2026/02/03
//  난이도: 실버1 | 소요시간: 17분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1697
//

// ============================================ 
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - x-1, x+1, 2*x를 사용했을 때 가장 빠른 시간
///     - bfs
///     - total = 0
///     - queue, dist
///     - dist가 -1이면 처음 방문, -1이 아니면 이미 방문함
///     while head < queue.count
///         var now = head[head]
///         head += 1
///
///         now + 1 <= 100000
///             dist[now + 1] = dist[now] + 1
///         now - 1 > 0
///             dist[now - 1] = dist[now] + 1
///         now * 2 <= 100000
///             dist[now * 2] = dist[now] + 1
///     dist[k]
/// 2. 자료구조
///     dist [Int], count: 100001
///     queue [Int]
/// 3. 시간복잡도
///     O(N)
// ============================================
// 📌 주의사항
// ============================================
///
// ============================================
// 🔨 구현
// ============================================
func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let k = input[1]
    
    let max = 100001
    
    var dist = Array(repeating: -1, count: max)
    
    var queue = [n]
    var head = 0
    dist[n] = 0
    
    while head < queue.count {
        let now = queue[head]
        head += 1
        
        if now == k { break }
        
        let right = now + 1
        if right < max, dist[right] == -1 {
            dist[right] = dist[now] + 1
            queue.append(right)
        }
        
        let left = now - 1
        if left >= 0, dist[left] == -1 {
            dist[left] = dist[now] + 1
            queue.append(left)
        }
        
        let double = now * 2
        if double < max, dist[double] == -1 {
            dist[double] = dist[now] + 1
            queue.append(double)
        }
    }
    
    print(dist[k])
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
