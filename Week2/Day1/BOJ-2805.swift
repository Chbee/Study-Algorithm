//
//  BOJ-2805
//  백준 2805번 - 나무 자르기
//
//  Created by 손지영 on 2026/01/22 22:11
//  난이도: 실버2 | 소요시간: 25분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2805
//

import Foundation


// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 잘린 나무만 들고감.
//      - 잘린다는 것의 기준은 H보다 클것. (같아도 안됨)
//      - 최소 M을 구하기 위한 H의 최댓값
//      - H를 구하기 위한 M을 구하기 위한..
//      - left: 0, right: max?
//      - mid로 잘랐을 때의 나무 합이
//          - M 이면 그걸 출력
//          - M보다 작으면, right = mid - 1
//          - M보다 크거나 같으면,  left = mid + 1
// 2. 자료구조
//      - O(logH): 이진탐색,  O(N): max 찾기, sum 찾기
//      - O(NlogH + N)
//          ~= 2,000,000,000 ~= 2e9 (1e3 ~= 2^10, 30*2 = 31)
//          ~= 3.1e7 + 1e6 ~= 3.2e7
// 3. 시간 복잡도

// ============================================
// 📌 주의사항
// ============================================
//

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let _ = input[0]
    let m = input[1]
    
    let trees = readLine()!.split(separator: " ").map { Int($0)! }
    
    var left = 0
    var right = 0
    
    for tree in trees {
        right = max(right, tree)
    }
    
    func getSum(with divider: Int) -> Int {
        var sum = 0
        for tree in trees {
            if tree > divider {
                sum += (tree - divider)
            }
        }
        return sum
    }
    
    var result = 0
    
    while left <= right {
        let mid = left + (right - left) / 2
        // 나무의 길이가 보다 크거나 같을 수 있음
        if getSum(with: mid) >= m {
            result = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    
    print(result)
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
//
