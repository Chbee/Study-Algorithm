//
//  BOJ-10845
//  백준 10845번 - 큐 (-)
//
//  Created by 손지영 on 2026/01/05
//  난이도: 실버4 | 소요시간: 20분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/10845
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 사용할 자료구조/알고리즘:
//    - 큐 (FIFO: First In First Out)

// 2. 시간복잡도:
//    - push, pop, size, empty, front, back

// 3. 접근 방법:
//    - 명령수 readLine으로 받기
//    - 각 명령 enum 처리
//    - pop, front, back에 해당하는 값 없으면 -1 출력
//    - empty 이면 0출력, 아니면 1출력

// ============================================
// 📌 주의사항
// ============================================
// - 예외 명령어가 들어오는 일 없음
// - 1 ~ 10,000개 처리 가능

// ============================================
// 🔨 구현
// ============================================

enum Command: String {
    case push, pop, size, empty, front, back
}

func start() {
    
    let commandSize = readLine()!
    
    var queue = [Int]()
    
    guard let size = Int(commandSize),
          size > 0, size <= 10_000
    else { return }
    
    for _ in 0..<size {
        let inputStr = readLine()!.split(separator: " ")
        
        switch inputStr[0] {
        case Command.push.rawValue:
            guard let number = Int(inputStr[1]) else { continue }
            queue.append(number)
        case Command.pop.rawValue:
            if queue.isEmpty { print(-1); continue }
            print(queue.removeFirst())
        case Command.size.rawValue:
            print(queue.count)
        case Command.empty.rawValue:
            print(queue.isEmpty ? 1 : 0)
        case Command.front.rawValue:
            print(queue.first ?? -1)
        case Command.back.rawValue:
            print(queue.last ?? -1)
        default:
            print("미지원 명령어.")
        }
    }
    
}

start()
