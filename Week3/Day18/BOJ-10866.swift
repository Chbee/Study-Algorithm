//
//  BOJ-10866
//  백준 10866번 - 덱
//
//  Created by 손지영 on 2026/02/12
//  난이도: 실버4 | 소요시간: 22분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/10866
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - push_front / push_back
///     - array에서 앞에 넣으면 O(N)의 연산이 발생함 때문에 이렇게 하면 안됨
///     - 0인덱스가 존재하는데 front에 넣으면 별도 array로 가지고 있어야할듯
///     - pop_front를 하면 별도 array를 먼저 수행하고 그거 다 수행하면 기존 array에서 수행.
/// 2. 자료구조
///     - front [Int]
///     - back [Int]
/// 3. 시간복잡도
///     - O(N)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var front = [Int]()
    var back = [Int]()
    
    for _ in 0..<n {
        let input = readLine()!.split(separator: " ")
        let c = String(input[0])
        
        if c == "push_front"
        {
            let x = Int(input[1])!
            front.append(x)
        }
        else if c == "push_back"
        {
            let x = Int(input[1])!
            back.append(x)
        }
        else if c == "pop_front"
        {
            if front.isEmpty {
                front = back.reversed()
                back = []
            }
            print(front.isEmpty ? -1 : front.removeLast())
        }
        else if c == "pop_back"
        {
            if back.isEmpty {
                back = front.reversed()
                front = []
            }
            print(back.isEmpty ? -1 : back.removeLast())
        }
        else if c == "size"
        {
            print(back.count + front.count)
        }
        else if c == "empty"
        {
            print(back.isEmpty && front.isEmpty ? 1 : 0)
        }
        else if c == "front"
        {
            print(front.last ?? (back.first ?? -1))
        }
        else if c == "back"
        {
            print(back.last ?? (front.first ?? -1))
        }
    }
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
