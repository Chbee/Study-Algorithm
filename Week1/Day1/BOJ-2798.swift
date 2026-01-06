//
//  BOJ-2798
//  백준 2798번 - 블랙잭
//
//  Created by 손지영 on 2026/01/06 09:32
//  난이도: 브론즈2 | 소요시간: 40분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2798
//

import Foundation


// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 사용할 자료구조/알고리즘:
//    - 카드 배열 (정수 랜덤 배열)
//    - 합을 구하는 배열

// 2. 시간복잡도:
//    - O(n^3)? 배열을 한번씩 순회해야하기 때문에

// 3. 접근 방법:
//    - Int Random 배열 생성 : [N]
//    - 생성된 배열로 3개를 더한 모든 경우의 수에 대한 배열 생성 : [M]
//    - [M]에서 M과 가장 근사치가 작고, M을 넘지 않는 값이 있는지 확인
//    - 있으면 해당 값 출력, 없으면 카드 선택 입력 받지않고 종료

// ============================================
// 📌 주의사항
// ============================================
// - N: 카드의 수, M: 카드 3장 합 기준값, 카드는 N 중에서 3장 선택
// - 카드의 합이 M을 넘지 않아야함
// - 카드 값은 100,000을 넘지 않는 양의 정수
// - M을 넘지 않는 카드 3장을 찾을 수 있는 경우에만 입력으로 주어짐

// ============================================
// 🔨 구현
// ============================================


func solution() {
    // 구현 시작
    
    let startCommands = readLine()!.split(separator: " ")
    
    guard let cardsNum = Int(startCommands[0]), let targetSum = Int(startCommands[1]) else { return }
    
    guard cardsNum > 2 else {
        print("카드는 반드시 3장 이상 필요합니다.")
        return
    }
    
    var cardList = readLine()!.split(separator: " ")
        .compactMap { Int($0) }
        .filter { $0 > 0 && 0 < 100_000 }
    
    guard cardList.count == cardsNum else { return }
    
    var sumList = [Int]()
    var maxSum = -1
    
    for (i, num) in cardList.enumerated() {
        for (j, next) in cardList.enumerated() where j > i {
            let sum = num + next
            for (k, third) in cardList.enumerated() where k > j {
                let total = sum + third
                if total == targetSum { print(total); return }
                else if total < targetSum { maxSum = max(maxSum, total) }
            }
        }
    }
    
    print(maxSum > -1 ? maxSum : "일치하는 카드의 값이 없습니다.")
}

solution()
