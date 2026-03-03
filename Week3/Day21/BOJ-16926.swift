//
//  BOJ-16926
//  백준 16926번 - 배열 돌리기 1
//
//  Created by 손지영 on 2026/03/03
//  난이도: 골드5 | 소요시간: 42분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/16926
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 배열을 레이어(테두리) 단위로 분리해서 회전한다.
///     - 각 레이어를 시작점(top,left)에서 따라가며 1차원 배열(temp)에 추출한다.
///     - 반시계 R회 회전은 temp를 왼쪽으로 (R % 둘레길이)만큼 시프트하는 것과 동일하다.
///     - 회전된 1차원 배열을 동일한 경로로 다시 레이어에 써 넣는다.
///     - 이 과정을 모든 레이어(min(N,M)/2개)에 대해 반복한다.
/// 2. 자료구조
///     - map: [[Int]]  (입력 배열)
///     - temp: [Int]   (현재 레이어를 일렬로 펼친 배열)
///     - dy, dx: [Int] (우, 하, 좌, 상 순회용 방향 벡터)
/// 3. 시간복잡도
///     - 각 원소는 자신의 레이어에서 추출 1번, 삽입 1번 처리된다.
///     - 시간복잡도: O(N*M)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let m = input[1]; let r = input[2]
    
    var map = [[Int]]()
    
    for _ in 0..<n {
        map.append(readLine()!.split(separator: " ").map { Int($0)! })
    }
    
    // 회전 가능한 레이어(테두리) 개수
    let size = min(n, m) / 2
    // 우, 하, 좌, 상 순서로 테두리를 순회
    let dy = [0, 1, 0, -1]
    let dx = [1, 0, -1, 0]
    
    func rotate() {
        for l in 0..<size {
            // 현재 레이어의 경계
            let top = l
            let left = l
            let bottom = n - l - 1
            let right = m - l - 1
            
            var y = top
            var x = left
            var dir = 0
            
            // 현재 레이어 둘레 길이(꼭짓점 중복 제거)
            let posi = 2 * ((bottom - top + 1) + (right - left + 1)) - 4
            
            var temp = [Int]()
            
            // 1) 레이어 값을 순서대로 뽑아 1차원 배열로 저장
            for _ in 0..<posi {
                temp.append(map[y][x])
                
                let ny = y + dy[dir]
                let nx = x + dx[dir]
                
                // 다음 칸이 레이어 밖이면 방향 전환
                if ny < top || ny > bottom || nx < left || nx > right {
                    dir = (dir + 1) % 4
                }
                
                y += dy[dir]
                x += dx[dir]
            }
            
            // 반시계 r번 회전 == 왼쪽으로 r칸 시프트
            let k = r % posi
            let rotated = Array(temp[k...]) + Array(temp[..<k])
            
            y = top
            x = left
            dir = 0
            
            var idx = 0
            // 2) 회전된 값을 같은 경로로 다시 채워 넣기
            for _ in 0..<posi {
                map[y][x] = rotated[idx]
                idx += 1
                
                let ny = y + dy[dir]
                let nx = x + dx[dir]
                
                if ny < top || ny > bottom || nx < left || nx > right {
                    dir = (dir + 1) % 4
                }
                
                y += dy[dir]
                x += dx[dir]
            }
        }
    }
    
    rotate()
    
    for line in map {
        print(line.map{ String($0) }.joined(separator: " "))
    }
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
