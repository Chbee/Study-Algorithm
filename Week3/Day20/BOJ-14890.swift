//
//  BOJ-14890
//  백준 14890번 - 경사로
//
//  Created by 손지영 on 2026/02/20
//  난이도: 골드3 | 소요시간: 50분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/14890
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 지나갈 수 있는길
///     - 길에 속한 모든 칸의 높이가 같아야함.
///     - 경사로로 지나갈 수 있는 길을 만들 수 있음, 경사로의 값은 1, 길이는 L
///         - 낮은칸에 놓으며, L개의 연속된 칸에 경사로의 바닥이 모두 접해야함 -> 1에서 2로 경사로를 둘때 2개의 1의 칸과 접해있어야함.
///         - 낮은 칸과 높은 칸의 높이 차이는 1이어야 함
///         - 경사로를 놓을 낮은 칸의 높이는 모두 같아야하고, L개의 칸이 연속되어 있어야 함
///     - map[i][j] 일때 map[1...n][1...j], map[1...i][1...n]끼리 봐야함
///     - 높이가 바뀌는 지점에서 -L한 인덱스가 변경되는 높이보다 -1 되어야 이동 가능함
/// 2. 자료구조
///     - map [[Int]]
///     - arr [[Int]]
/// 3. 시간복잡도
///     - O(N^2)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let l = input[1]
    
    var map = [[Int]]()
    
    for _ in 0..<n {
        map.append(readLine()!.split(separator: " ").map { Int($0)! })
    }
    
    var arr = [[Int]]()
    
    for i in 0..<n {
        arr.append(map[i])
        var temp = [Int]()
        for j in 0..<n {
            temp.append(map[j][i])
        }
        arr.append(temp)
    }
    
    var rs = 0
    
    for line in arr {
        if Set(line).count == 1 { rs += 1; continue }
        
        var step = 1
        var possible = true
        
        for i in 1..<line.count {
            let diff = line[i] - line[i-1]
            
            if diff == 0 { step += 1; continue }
            else if diff == 1
            {
                // 필요한 경사의 길이보다 작으면 올라가지 못함
                if step < l { possible = false; break }
                step = 1
            }
            else if diff == -1
            {
                // 필요한 경사의 길이보다 작으면 내려가지 못함
                if step < 0 { possible = false; break }
                step = -l + 1
            }
            else
            {
                possible = false
                break
            }
        }
        
        if possible && step >= 0 { rs += 1; }
    }
    
    print(rs)
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================

/*
swift BOJ-14890.swift <<EOF
6 2
3 3 3 3 3 3
2 3 3 3 3 3
2 2 2 3 2 3
1 1 1 2 2 2
1 1 1 3 3 1
1 1 2 3 3 2
EOF
 */

/*
swift BOJ-14890.swift <<EOF
6 2
3 2 1 1 2 3
3 2 2 1 2 3
3 2 2 2 3 3
3 3 3 3 3 3
3 3 3 3 2 2
3 3 3 3 2 2
EOF
*/

/*
swift BOJ-14890.swift <<EOF
6 3
3 2 1 1 2 3
3 2 2 1 2 3
3 2 2 2 3 3
3 3 3 3 3 3
3 3 3 3 2 2
3 3 3 3 2 2
EOF
 */
