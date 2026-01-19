//
//  BOJ-1652
//  백준 1652번 - 누울 자리를 찾아라
//
//  Created by 손지영 on 2026/01/19
//  난이도: 실버5 | 소요시간: 40분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1652
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 연속된 2칸 이상의 빈칸, 가로 세로, 벽이나 짐에 반드시 닿게 됨
//      - 가로도 되고 세로도 되야함.
//      - 방향을 띄우고 있어야하겠는데,,
//      - 일단 떠올려진걸로 구현 시작
//      - y로 한번 훑고 x로 한번 훑기
// 2. 자료구조
//      - map [[Int]]
//      - 가로 cnt, 세로 cnt
// 3. 시간 복잡도
//      - O(N*N*2) 나는 두번 훑을거니까 *2 추가.
//          ~= 100*100*2 = 20000 = 2e4 충분

// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var map = Array(repeating: [String](), count: n+1)
    
    for i in 1...n {
        var row = ["."]
        row.append(contentsOf: readLine()!.map { String($0) })
        map[i] = row
    }
    
    var chk = Array(repeating: Array(repeating: false, count: n+1), count: n+1)
    
    var row = 0
    var col = 0
    
    for y in 1...n {
        rowFind(y: y)
    }
    
    for x in 1...n {
        colFind(x: x)
    }
    
    func rowFind(y: Int) {
        var visitedRow = 0
        for x in 1...n {
            if (map[y])[x] == "." { visitedRow += 1 }
            else {
                if visitedRow >= 2 { row += 1 }
                visitedRow = 0
            }
        }
        if visitedRow >= 2 { row += 1 }
    }
    
    func colFind(x: Int) {
        var visitedCol = 0
        for y in 1...n {
            if (map[y])[x] == "." { visitedCol += 1 }
            else {
                if visitedCol >= 2 { col += 1 }
                visitedCol = 0
            }
        }
        if visitedCol >= 2 { col += 1 }
    }
    
    print("\(row) \(col)")
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
