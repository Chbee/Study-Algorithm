//
//  BOJ-5063
//  백준 5063번 - TGN
//
//  Created by 손지영 on 2026/02/09
//  난이도: 브론즈3 | 소요시간: 5분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/5063
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 광고를 할지말지 최대한의 수익을 위함
///     - r: 광고 하지 않았을 때의 수익, e: 광고를 했을 때의 수익, c: 광고 비용
///     - 광고해야하면 advertise, 하지 않아야하면 do not advertise, 수익차가 없으면 does not matter
///     - 광고 했을 때의 순수익 = e - c
///     r > e - c : do not advertise
///     r < e - c : advertise
///     r == e - c : does not matter
/// 2. 자료구조
/// 3. 시간복잡도
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let t = Int(readLine()!)!
    
    for _ in 0..<t {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let r = input[0]; let e = input[1]; let c = input[2]
        
        let ad = e - c
        if r > ad { print("do not advertise") }
        else if r < ad { print("advertise") }
        else { print("does not matter") }
    }
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
