//
//  BOJ-9012
//  백준 9012번 - 괄호 (-)
//
//  Created by 손지영 on 2026/01/05
//  난이도: - | 소요시간: 40분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/9012
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 사용할 자료구조/알고리즘:
//    - stack

// 2. 시간복잡도:
//    -

// 3. 접근 방법:
//    - 입력받은 문자열에서 괄호의 카운트를 셈
//    - 카운트가 동일하면 VPS, 아니면 PS로 취급

// ============================================
// 📌 주의사항
// ============================================
// - 문자열의 길이는 2 이상 50 이하
// - 입력 시작은 정수 T의 입력으로 시작
// - 한 줄에 하나씩 결과를 출력
// - 괄호의 순서도 맞아야함

// ============================================
// 🔨 구현
// ============================================

let startPS = "("
let endPS = ")"

func start() {
    guard let inputString = readLine(), let inputNum = Int(inputString) else {
        print("유효한 정수를 입력해주세요.")
        return
    }
    
    for _ in 0..<inputNum {
        let inputStr = readLine()!
        
        guard inputStr.count > 1, inputStr.count < 51 else {
            print("2자리 이상 50자리 이하만 입력할 수 있습니다.")
            return
        }
        
        print(checkIsVPS(readLine()!) ? "YES" : "NO")
    }
}

func checkIsVPS(_ str: String) -> Bool {
    var count = 0
    let inputPS = str.map { String($0) }
    
    for char in inputPS {
        if char == startPS { count += 1 }
        else if char == endPS {
            count -= 1
            if count < 0 { return false }
        }
    }
    
    return count == 0
}

start()
