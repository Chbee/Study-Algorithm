//
//  BOJ-2309
//  백준 2309번 - 일곱 난쟁이
//
//  Created by 손지영 on 2025/01/07
//  난이도: 브론즈1 | 소요시간: 50분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2309
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 사용할 자료구조/알고리즘:
//      - 투포인터
//      - 수열: [Int]
//      - 찾은 난쟁이: [Int]
//      - sum: 찾은 난쟁이들의 키
//      - target: 찾을 난쟁이들의 키
//
// 2. 시간복잡도:
//      - 투포인터: O(N)
//      - 오름차순 정렬: O(NlogN)
//
// 3. 접근 방법:
//      - N수열의 M개의 합이 7
//      - 정답이 여러가지일때는 아무거나 출력 -> 하나만 찾으면 됨
//      - 투포인터로 더하고 빼면서 100인거 찾으면 바로 출력
//      - 기본으로 0 인덴스를 더하고, 1부터 n까지 찾는다. 배열은 7개여야함

// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    var sequence = [Int]()
    
    for _ in 0..<9 {
        sequence.append(Int(readLine()!)!)
    }
    
    sequence.sort()
    
    let total = sequence.reduce(0, +)
    let twoTarget = total - 100 // 찾아야하는 값
    
    if twoTarget <= 0 { return }
    
    var start = 0
    var end = sequence.count - 1
    
    var targetLeft = -1
    var targetRight = -1
    
    while start < end {
        let pair = sequence[start] + sequence[end]
        
        if pair == twoTarget {
            targetLeft = start
            targetRight = end
            break
        } else if pair < twoTarget {
            start += 1
        } else {
            end -= 1
        }
    }
    
    for i in 0..<sequence.count {
        if i == targetLeft || i == targetRight { continue }
        print(sequence[i])
    }
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
// 투포인터 접근방식. 중간값을 어떻게 처리할것이냐.
