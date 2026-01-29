//
//  BOJ-2512
//  백준 2512번 - 예산
//
//  Created by 손지영 on 2026/01/22
//  난이도: 실버3 | 소요시간: 20분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2512
//

import Foundation


// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 가능한 최대의 총 예산..
//      - 정수 상한액, 이상 예산 요청은 모두 상한액을 배정, 이하는 그대로 배정
//      - 상한액을 어떻게 찾을것인가.
//          - 각 지방자치단체의 예산과 상한액중 작은값을 선택했을 때 그 값이 총 예산을 넘지 않아야한다.
//          - 상한액이 x고 이 x는 1부터 예산 총액까지 가능하겠네?
//          - left 1, right 예산들의 최고값, mid left + (right - left) / 2?
//          - 반복문 종료 조건: 지방 자치 단체의 예산과 중위값의 min들의 합이 총 예산을 넘지 않아야함
//      - 최대 예산은 어떻게 계산할것인가. 오른쪽으로 범위를 줄여나가면서 max로 확인?
//      - 그럼 비교 후 지금 값이 맥스일때, 반복문 종료?
// 2. 자료구조
//      - 예산 [Int]
//      - 최대 요청값 Int, 순회 필요
// 3. 시간 복잡도
//      - O(N) -> 최대값 찾기 위한 순회
//      - O(NlogN) -> 지방자치단체 예산 확인

// ============================================
// 📌 주의사항
// ============================================
//

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    let requests = readLine()!.split(separator: " ").map { Int($0)! }
    
    let total = Int(readLine()!)!
    
    var left = 0
    var right = 0
    
    for request in requests {
        right = max(right, request)
    }
    
    var maxBudged = 0
    
    func getTotalBudget(max: Int) -> Int {
        var budged = 0
        
        for request in requests {
            budged += min(request, max)
        }
        
        return budged
    }
    
    while left <= right {
        let mid = left + (right - left) / 2
        
        let budget = getTotalBudget(max: mid)
        if budget <= total {
            maxBudged = max(maxBudged, mid)
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    
    print(maxBudged)
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
//
