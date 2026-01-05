//
//  BOJ-10845-reversed
//  백준 10845번 - 큐 (Reversed 2배열 방식)
//
//  Created by 손지영 on 2026/01/05
//  난이도: 실버4 | 소요시간: - | 상태: ✅
//  링크: https://www.acmicpc.net/problem/10845
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 사용할 자료구조/알고리즘:
//    - 큐 (FIFO: First In First Out)
//    - Reversed 2배열 방식

// 2. 시간복잡도:
//    - push: O(1)
//    - pop: 분할상환 O(1)
//    - size, empty, front, back: O(1)

// 3. 접근 방법:
//    - input 배열: push용 (뒤에 추가)
//    - output 배열: pop용 (뒤에서 제거)
//    - output이 비면 input을 뒤집어서 이동

// ============================================
// 📌 주의사항
// ============================================
// - 각 요소는 최대 2번만 이동 (push 1번 + reversed 1번)
// - popLast()만 사용하므로 항상 O(1)

// ============================================
// 🔨 구현
// ============================================

enum Command: String {
    case push, pop, size, empty, front, back
}

var input = [Int]()
var output = [Int]()

func push(_ n: Int) {
    input.append(n)
}

func pop() -> Int {
    if output.isEmpty {
        output = input.reversed()
        input.removeAll()
    }
    return output.popLast() ?? -1
}

func size() -> Int {
    input.count + output.count
}

func empty() -> Int {
    input.isEmpty && output.isEmpty ? 1 : 0
}

func front() -> Int {
    if output.isEmpty {
        return input.first ?? -1
    }
    return output.last ?? -1
}

func back() -> Int {
    if input.isEmpty {
        return output.first ?? -1
    }
    return input.last ?? -1
}

func start() {
    let commandSize = readLine()!

    guard let count = Int(commandSize),
          count > 0, count <= 10_000
    else { return }

    for _ in 0..<count {
        let inputStr = readLine()!.split(separator: " ")

        switch inputStr[0] {
        case Command.push.rawValue:
            guard let number = Int(inputStr[1]) else { continue }
            push(number)
        case Command.pop.rawValue:
            print(pop())
        case Command.size.rawValue:
            print(size())
        case Command.empty.rawValue:
            print(empty())
        case Command.front.rawValue:
            print(front())
        case Command.back.rawValue:
            print(back())
        default:
            print("미지원 명령어.")
        }
    }
}

start()
