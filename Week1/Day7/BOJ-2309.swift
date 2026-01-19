//
//  BOJ-2309
//  백준 2309번 - 일곱 난쟁이
//
//  Created by 손지영 on 2026/01/19
//  난이도: 브론즈1 | 소요시간: 16분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2309
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 합이 100이 되는 난쟁이 수
//      - "아무거나"출력이므로 100이 되는 순간 출력하면 됨
//      - 선택했을때와 하지 않았을 때를 구분하여 계산, num이 100이 오면 array 출력
// 2. 자료구조
//      - 입력받은 난쟁이 수 [Int]
//      - 100이 되는 난쟁이 [Int]
// 3. 시간 복잡도
//      - 출력 시 정렬 O(nlogn)
//      - 전체 탐색 O(2^N)

// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    var input = [Int]()
    
    for i in 0..<9 {
        input.append(Int(readLine()!)!)
    }
    
    var find = [Int]()
    
    func dfs(index: Int) -> Bool {
        if find.count == 7 {
            let total = find.reduce(0) { $0 + $1 }
            if total == 100 {
                for v in find.sorted() {
                    print(v)
                }
                return true
            }
            return false
        }
        
        for i in index..<9 {
            find.append(input[i])
            if dfs(index: i + 1) { return true }
            find.removeLast()
        }
        return false
    }
    
    _ = dfs(index: 0)
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
