//
//  BOJ-1917
//  백준 1917번 - 정육면체 전개도
//
//  Created by 손지영 on 2026/02/25
//  난이도: 골드1 | 소요시간: 80분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1917
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 정육면체 전개도....
///     - 조건을 만족하려면 어떻게 되야하나
///     - 정육면체들의 "상대적 위치".. (참고: [1499번 문제](../Day19/BOJ-14499.swift))
///         - 윗면은 항상 아랫면과 대칭
///         - 동: x+1, 서: x-1, 남: y+1, 북: y-1
///         - dice 인덱스: [top, north, east, west, south, bottom]
///         - 전개도(인덱스 기준)
///                   [1: north]
///         [3: west] [0: top] [2: east]
///                   [4: south]
///                   [5: bottom]
///     - 전개도에서 1이 있는 칸을 DFS로 순회하며 큐브를 굴린다.
///     - 이동 방향(1~4): 동, 서, 남, 북
///     - 이동마다 주사위를 rollE/rollW/rollS/rollN으로 회전시켜 면 배치를 갱신한다.
///     - 방문한 칸 수를 세고, 6면이 모두 채워졌는지 확인한다.
///     - 입력은 6x6 맵 3개이며, 각 맵마다 yes/no를 출력한다.
/// 2. 자료구조
///     - map [[Int]]
///     - check [[Bool]]
///     - Cube.side [Int]
/// 3. 시간복잡도
///     - O(6 * 6)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    final class Cube {
        // [top, north, east, west, south, bottom]
        private var side: [Int]
        private var temp: [Int]
        private var foldCount: Int
        
        init() {
            temp = Array(repeating: 0, count: 6)
            side = Array(repeating: 0, count: 6)
            foldCount = 0
        }
        
        func cubeCheck() -> Bool {
            if foldCount > 6 { return false }
            for i in 0..<6 {
                if side[i] == 0 { return false }
            }
            return true
        }
        
        func setCube(_ value: Int) {
            foldCount += 1
            side[0] = value
        }
        
        func changeSide(_ dir: Int) {
            if dir == 1 { rollE() }
            else if dir == 2 { rollW() }
            else if dir == 3 { rollS() }
            else if dir == 4 { rollN() }
        }
        
        private func rollE() {
            let t = side[0]
            side[0] = side[3]
            side[3] = side[5]
            side[5] = side[2]
            side[2] = t
        }
        
        private func rollW() {
            let t = side[0]
            side[0] = side[2]
            side[2] = side[5]
            side[5] = side[3]
            side[3] = t
        }
        
        private func rollN() {
            let t = side[0]
            side[0] = side[4]
            side[4] = side[5]
            side[5] = side[1]
            side[1] = t
        }
        
        private func rollS() {
            let t = side[0]
            side[0] = side[1]
            side[1] = side[5]
            side[5] = side[4]
            side[4] = t
        }
    }
    
    let dy = [0, 0, 0, 1, -1]
    let dx = [0, 1, -1, 0, 0]
    let reverseDir = [0, 2, 1, 4, 3]
    
    func outOfBounds(_ y: Int, _ x: Int) -> Bool {
        return y < 0 || y >= 6 || x < 0 || x >= 6
    }
    
    for _ in 0..<3 {
        var arr = Array(repeating: Array(repeating: 0, count: 6), count: 6)
        var check = Array(repeating: Array(repeating: false, count: 6), count: 6)
        
        for i in 0..<6 {
            arr[i] = readLine()!.split(separator: " ").map { Int($0)! }
        }
        
        var sy = 0
        var sx = 0
        var found = false
        
        for y in 0..<6 {
            if found { break }
            for x in 0..<6 {
                if arr[y][x] == 1 {
                    sy = y
                    sx = x
                    found = true
                    break
                }
            }
        }
        
        var side = 0
        let cube = Cube()
        
        func validateCubeOperate(_ y: Int, _ x: Int) {
            side += 1
            cube.setCube(side)
            check[y][x] = true
            
            for i in 1...4 {
                let ny = y + dy[i]
                let nx = x + dx[i]
                
                if outOfBounds(ny, nx) || check[ny][nx] || arr[ny][nx] == 0 { continue }
                
                cube.changeSide(i)
                validateCubeOperate(ny, nx)
                cube.changeSide(reverseDir[i])
            }
        }
        
        validateCubeOperate(sy, sx)
        print(cube.cubeCheck() ? "yes" : "no")
    }
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
/// 전개도 찾기 어렵다.
