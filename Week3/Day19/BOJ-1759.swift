//
//  BOJ-1759
//  백준 1759번 - 암호 만들기
//
//  Created by 손지영 on 2026/02/16
//  난이도: 골드5 | 소요시간: 14분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1759
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 서로 다른 L개의 알파벳 소문자 + 최소 한개의 모음 + 최소 두개의 자음
///     - 암호에서 "증가하는 순서"로 배열 -> ASCII Code
///     - 가능성 있는 모든 암호를 구하라
///     - C(C, L)
///         1. C를 ASCII Code로 오름차순 함
///         2. 중복이 되지 않으므로 내가 선택한 것 보다 인덱스 하나 크게 해서 선택하게끔 함
///         3. temp에 담긴 비밀번호가 완성되면 rs에 추가
/// 2. 자료구조
///     - rs String
///     - temp [String]
/// 3. 시간복잡도
///     - O(C(C, L) * L)
///     - O(ClogC)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let l = input[0]
    let c = readLine()!.split(separator: " ").map({ String($0) }).sorted()
    
    var rs = ""
    var temp = [String]()
    
    let vowels = ["a","e","i","o","u"]
    
    func dfs(start: Int) {
        if temp.count == l {
            let vCount = temp.filter { vowels.contains($0) }.count
            let cCount = l - vCount
            if vCount >= 1 && cCount >= 2 {
                rs += temp.joined() + "\n"
            }
            return
        }
        
        for i in start..<c.count {
            temp.append(c[i])
            dfs(start: i + 1)
            temp.removeLast()
        }
    }
    
    dfs(start: 0)
    
    print(rs)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
