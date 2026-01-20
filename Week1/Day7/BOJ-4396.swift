//
//  BOJ-4396
//  백준 4396번 - 지뢰찾기
//
//  Created by 손지영 on 2026/01/19 16:00
//  난이도: 실버4 | 소요시간: 29분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/4396
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심아이디어
//      - 대각선까지 탐색 필요. (우, 우하, 하, 좌하, 좌, 좌상, 상, 우상)
//          dy: [0, -1, -1, -1, 0, 1, 1, 1]
//          dx: [-1, -1, 0, 1, 1, 1, 0, -1]
//      - 해당 위치에서 대각선에서 탐지한 모든 지뢰 출력.
//      - 만약, 클릭한곳이 지뢰가 있는 곳이면 즉시 지뢰 모든 위치 노출 (없는곳은 온점(.) 있는곳은 *)
//      - y, x가 1부터 n까지 모두 탐색해야하고.. 탐색 여부는 저장할 필요 없다. 어차피 순서대로 탐지하고 모든 지뢰를 탐지해야하기 때문
//      - 새로운 ny nx가 0과 8사이에 존재해야하고, 지뢰 저장 위치에서 *이면 cnt + 1, 아니면 그냥 진행
//      - x y의 위치에 지뢰 있으면 찾은걸로 간주.
//      - 편의상 1-based로 접근할것.
// 2. 자료구조
//      - input [[String]]
//      - boom [[String]]
//      - foundBoom Bool
//      - boomCnt: Bool < 이거는 x값 변경될 때 초기화 필요 위치별로 찾으니까.
// 3. 시간복잡도
//      - grid 두 개를 모두 봐야한다.
//      - O(N*M)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var boom = Array(repeating: [String](), count: n+1)
    
    for i in 1...n {
        var row = ["."]
        row.append(contentsOf: readLine()!.map{ String($0) })
        boom[i] = row
    }
    
    var input = Array(repeating: [String](), count: n+1)
    for i in 1...n {
        var row = ["."]
        row.append(contentsOf: readLine()!.map{ String($0) })
        input[i] = row
    }
    
    let dy = [0, -1, -1, -1, 0, 1, 1, 1]
    let dx = [-1, -1, 0, 1, 1, 1, 0, -1]
    
    var foundBoom = false
    
    for y in 1...n {
        for x in 1...n {
            if input[y][x] == "x" && boom[y][x] == "*" {
                foundBoom = true
            }
        }
    }
    
    func countBoom(y: Int, x: Int, num: inout Int) {
        for i in 0..<8 {
            let ny = y + dy[i]
            let nx = x + dx[i]
            
            if ny < 1 || ny > n || nx < 1 || nx > n { continue }
            
            if boom[ny][nx] == "*" { num += 1 }
        }
    }
    
    
    for y in 1...n {
        var result = [String]()
        for x in 1...n {
            if foundBoom && boom[y][x] == "*" {
                result.append("*")
                continue
            }
            var num = 0
            if input[y][x] == "x" {
                countBoom(y: y, x: x, num: &num)
                result.append("\(num)")
            } else {
                result.append(".")
            }
        }
        print(result.joined(separator: ""))
    }
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================


