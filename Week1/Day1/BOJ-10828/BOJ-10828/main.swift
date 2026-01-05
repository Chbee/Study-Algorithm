//
//  BOJ-10828
//  백준 10828번 - 스택 (-)
//
//  Created by 손지영 on 2026/01/05
//  난이도: - | 소요시간: 30분 | 상태: ⏳
//  링크: https://www.acmicpc.net/problem/10828
//

import Foundation


// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 사용할 자료구조/알고리즘:
//    - 스택

// 2. 시간복잡도:
//    - push O(1), pop O(1), size O(1), empty O(1), top O(1)

// 3. 접근 방법:
//    - 명령의 수를 체크해서 보다 많은 명령을 처리하지 않도록 한다.
//    - push는 add를 사용해서 입력하고
//    - pop은 dropLast로 마지막 인자를 찾는다
//    - size는 count를 사용하고
//    - empty는 isEmpty를 사용하고
//    - top은 last를 사용해서 삼항 연산자를 사용한다.

// ============================================
// 📌 주의사항
// ============================================
// - 명령의 수는 1보다 크거나 같고 10000보다 작거나 같다.
// - 명령어는 예외를 두지 않는다
// - 명령의 수를 입력하기 전까지 명령어는 처리하지 않는다
// - 명령어에 숫자가 있다면 숫자 사이에 스페이스가 있어야한다.

// ============================================
// 🔨 구현
// ============================================


enum Command: String {
    case push = "push"
    case pop = "pop"
    case size = "size"
    case empty = "empty"
    case top = "top"
}

func start() {
    guard let inputSize = readLine(), let operateSize = Int(inputSize) else {
        return
    }
    
    guard operateSize > 0, operateSize <= 10_000 else {
        return
    }
    
    var stack = [Int]()
    
    for _ in 0..<operateSize {
        guard let command = readLine() else { return }
        
        let commands = command.split(separator: " ").map { String($0) }
        
        switch commands.first {
        case Command.push.rawValue:
            guard let inputNumberStr = commands.last, let inputNumber = Int(inputNumberStr) else {
                return
            }
            push(inputNumber, in: &stack)
        case Command.pop.rawValue:
            pop(in: &stack)
            
        case Command.size.rawValue:
            size(for: stack)
            
        case Command.empty.rawValue:
            empty(for: stack)
            
        case Command.top.rawValue:
            top(for: stack)
            
        default:
            assertionFailure("지원하지 않는 명령어입니다.")
        }
    }
}

func push(_ number: Int, in arr: inout [Int]) {
    arr.append(number)
}

func pop(in arr: inout [Int]) {
    let popLasted = arr.popLast()
    print(popLasted != nil ? popLasted! : -1)
}

func size(for arr: [Int]) {
    print(arr.count)
}

func empty(for arr: [Int]) {
    let isEmpty = arr.isEmpty
    print(isEmpty ? 1 : 0)
}

func top(for arr: [Int]) {
    let last = arr.last
    print(last != nil ? last! : -1)
}

func convertToInt(from str: String?) -> Int  {
    guard let str = str, let number = Int(str) else {
        fatalError()
    }
    return number
}

start()
