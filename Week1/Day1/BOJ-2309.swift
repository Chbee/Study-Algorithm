//
//  BOJ-2309
//  백준 2309번 - 일곱 난쟁이
//
//  Created by 손지영 on 2026/01/06 15:34
//  난이도: 브론즈1 | 소요시간: 20분 | 상태: 완료
//  링크: https://www.acmicpc.net/problem/2309
//

import Foundation


// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 사용할 자료구조/알고리즘:
//    - 완전탐색, 백트래킹, 재귀

// 2. 시간복잡도:
//    - O(C(9,7) * 7) ~ O(1)

// 3. 접근 방법:
//    - 7개를 조합하는 재귀

// ============================================
// 📌 주의사항
// ============================================
// - 항상 7개의 출력 있어야함
// - 오름차순
// - 100을 넘지않는 자연수들의 합이 100이 되어야함

// ============================================
// 🔨 구현
// ============================================


func solution() {
    var inputData = [Int]()
    for _ in 0..<9 {
        guard let input = readLine(), let intValue = Int(input), intValue <= 100 else { return }
        inputData.append(intValue)
    }
    
    guard inputData.count == 9 else { return }
    
    var result: [Int] = []
    let findNumber = 7
    var isFound = false
    
    combination(from: inputData, sum: 0, start: 0, select: findNumber, isFound: &isFound, current: [], result: &result)
    
    print(result.map(String.init).joined(separator: "\n"))
}

private func combination(from inputData: [Int], sum: Int, start: Int, select: Int, isFound: inout Bool, current: [Int], result: inout [Int]) {
    if isFound { return }
    
    if current.count == select {
        guard sum == 100 else { return }
        result = current.sorted(by: { $0 < $1 })
        isFound = true
        return
    }
    
    for i in start..<inputData.count {
        combination(from: inputData, sum: sum + inputData[i], start: i+1, select: select, isFound: &isFound, current: current + [inputData[i]], result: &result)
    }
}

solution()
