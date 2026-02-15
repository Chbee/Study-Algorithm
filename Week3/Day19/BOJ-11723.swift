//
//  BOJ-11723
//  백준 11723번 - 집합
//
//  Created by 손지영 on 2026/02/14
//  난이도: 실버5 | 소요시간: 32분 (비트연산포함x) | 상태: ✅
//  링크: https://www.acmicpc.net/problem/11723
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - add x input, 단 이미 존재 시 무시
///     - remove x remove, 단 없는 경우 무시
///     - check x 있으면 1, 없으면 0
///     - toggle x 있으면 제거 없으면 x 추가
///     - all 배열을 1...20으로 변경
///     - empty 배열을 빈배열로 변경
///     - remove와 toggle을 어떻게 해야 시간복잡도를 줄일까
///         1. x를 기준으로 배열을 나눠? -> O(N)
///         2. 수의 존재만 변경하고 출력할 때에.... 숫자로 치환하면? O(1)이 되나?
///         3. 그래도 느려서 출력을 한번에 진행하는것으로 변경 시도
///         4. 그래도 시간초과 발생........ 모든 입력 한번에 받아서 처리...로 변경
///         5. 포기!! 비트연산 코드로 풀면 된다는 글을 따라 수정.
/// 2. 자료구조
///     - hasNum [Bool]
///     - rs String
/// 3. 시간복잡도
///     - O(S * M)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let buf = Array(FileHandle.standardInput.readDataToEndOfFile())
    var idx = 0
    let n = buf.count

    @inline(__always)
    func readInt() -> Int {
        var result = 0
        while idx < n && (buf[idx] < 48 || buf[idx] > 57) { idx += 1 }
        while idx < n && buf[idx] >= 48 && buf[idx] <= 57 {
            result = result * 10 + Int(buf[idx] - 48)
            idx += 1
        }
        return result
    }

    // 단어의 첫 글자 + 길이를 반환
    @inline(__always)
    func readCmd() -> (UInt8, Int) {
        while idx < n && (buf[idx] == 32 || buf[idx] == 10 || buf[idx] == 13) { idx += 1 }
        let first = buf[idx]
        let start = idx
        while idx < n && buf[idx] != 32 && buf[idx] != 10 && buf[idx] != 13 { idx += 1 }
        return (first, idx - start)
    }

    let m = readInt()
    var hasNum = Array(repeating: false, count: 21)
    var output = Data()
    output.reserveCapacity(m * 2)
    let one: [UInt8] = [49, 10]  // "1\n"
    let zero: [UInt8] = [48, 10] // "0\n"

    for _ in 0..<m {
        let (c, len) = readCmd()

        // 첫글자+길이로 구분: add(a,3) all(a,3) -> 둘다 3이므로 두번째 글자로 구분 필요
        // add(3): 'd' / all(3): 'l' / check(5) / remove(6) / toggle(6) / empty(5)
        // 첫글자로 구분: a, c, r, t, e
        // a는 len만으론 구분 불가 -> 실제로 세번째 글자: add='d', all='l'
        // 더 간단하게: 길이로 먼저 나누기
        switch c {
        case 97: // 'a'
            if len == 3 { // "add" or "all" - buf[idx-2]로 구분
                if buf[idx - 2] == 100 { // 'd' = add
                    hasNum[readInt()] = true
                } else { // 'l' = all
                    for i in 1...20 { hasNum[i] = true }
                }
            }
        case 114: // 'r' = remove
            hasNum[readInt()] = false
        case 99: // 'c' = check
            let num = readInt()
            output.append(contentsOf: hasNum[num] ? one : zero)
        case 116: // 't' = toggle
            hasNum[readInt()].toggle()
        case 101: // 'e' = empty
            for i in 1...20 { hasNum[i] = false }
        default:
            break
        }
    }

    FileHandle.standardOutput.write(output)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
