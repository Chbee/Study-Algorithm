//
//  BOJ-24196
//  백준 24196번 - Gömda ord
//
//  Created by 손지영 on 2026/02/09
//  난이도: 브론즈4 | 소요시간: 26분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/24196
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 첫글자가 문자열에 포함
///     - A는 다음 문자가 한칸 앞에 있음, B는 두 칸 앞에 있음
///     - 마지막 글자에 도달하면 글자를 가져오고 계산을 완료
///     - ABCDEFGHIJKLMNOPQRSTUVWXYZ
///     - ABKBFA -> ABBA
///         1: A(0) 출력, +1 위치 이동
///         2: B(1) 출력, +2 위치 이동
///         3. B(3) 출력, +2 위치 이동
///         4. A(5) 출력, 마지막이므로 종료
///     - HZBKRYAFEAAAAJ -> HEJ
///         1: H(0) 출력, +8 위치 이동
/// 2. 자료구조
///     - nextStep: Int
///     - rs: String
/// 3. 시간복잡도
///     O(N^2)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    
    let input = readLine()!.map { $0 }
    
    var nextStep = 0
    var rs = [Character]()

    func getASCII(_ v: Character) -> Int {
        return Int(v.asciiValue! - Character("A").asciiValue!) + 1
    }
    
    while nextStep < input.count {
        rs.append(input[nextStep])
        if nextStep == input.count - 1 { break }
        nextStep += getASCII(input[nextStep])
    }
    
    print(String(rs))
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
/// 기준과 실제 발생하는 값에대한 이해
