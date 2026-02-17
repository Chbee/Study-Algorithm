//
//  BOJ-20327
//  백준 20327번 - 배열 돌리기 6
//
//  Created by 손지영 on 2026/02/16
//  난이도: 골드2 | 소요시간: 80분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/20327
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 8개의 연산, 연산별 단계 0<=e<N
///     - 배열을 부분배열로 나눌 때 사용
///     - 단계 먼저 적용 후 연산 적용
///     - 1번 연산: 부분배열 상하 반전
///         = (0,0) (0,1) (1,0) (1,1) -> (1,0) (1, 1) (0, 1) (1, 1)
///         = swapAt([0][0], [1][0]), swapAt([0][1], [1][1])
///     - 2번 연산: 부분 배열 좌우 반전
///         = (0,0) (0,1) (1,0) (1,1) -> (0,1) (0,0) (1,1) (1,0)
///         = swapAt([0][0], [0][1]), swapAt([1][0], [1][1])
///     - 3번 연산: 오른쪽으로 90도 회전
///     - 4번 연산: 왼쪽으로 90도 회전
///     - 5~8번 연산: 부분배열이 한칸
///         - 5번연산: 부분배열을 상하 반전
///         - 6번연산: 부분 배열을 좌우 반전
///         - 7번연산: 부분배열을 오른쪽 90도 회전
///         - 8번연산: 부분배열을 왼쪽 90도 회전
/// 2. 자료구조
///     - map [[Int]]
///     - cmds [(Int, Int)]
///     - temp [[Int]]
/// 3. 시간복잡도
///     - O(R × size^2) = O(R × 2^(2n)) = O(R × 4^n)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]; let r = input[1]
    let size = Int(pow(2.0, Double(n)))

    var map = [[Int]]()

    for _ in 0..<size {
        map.append(readLine()!.split(separator: " ").map { Int($0)! })
    }
    
    var cmds = [[Int]]()

    for _ in 0..<r {
        cmds.append(readLine()!.split(separator: " ").map { Int($0)! })
    }

    for cmd in cmds {
        let l = Int(pow(2.0, Double(cmd[1])))
        switch cmd[0] {
        case 1:
            for sy in stride(from: 0, to: size, by: l) {
                for sx in stride(from: 0, to: size, by: l) {
                    for i in 0..<l/2 {
                        for j in 0..<l {
                            let tmp = map[sy + i][sx + j]
                            map[sy + i][sx + j] = map[sy + l - 1 - i][sx + j]
                            map[sy + l - 1 - i][sx + j] = tmp
                        }
                    }
                }
            }
        case 2:
            for sy in stride(from: 0, to: size, by: l) {
                for sx in stride(from: 0, to: size, by: l) {
                    for i in 0..<l {
                        for j in 0..<l/2 {
                            let tmp = map[sy + i][sx + j]
                            map[sy + i][sx + j] = map[sy + i][sx + l - 1 - j]
                            map[sy + i][sx + l - 1 - j] = tmp
                        }
                    }
                }
            }
        case 3:
            var temp = map
            for sy in stride(from: 0, to: size, by: l) {
                for sx in stride(from: 0, to: size, by: l) {
                    for i in 0..<l {
                        for j in 0..<l {
                            temp[sy + j][sx + l - 1 - i] = map[sy + i][sx + j]
                        }
                    }
                }
            }
            map = temp
        case 4:
            var temp = map
            for sy in stride(from: 0, to: size, by: l) {
                for sx in stride(from: 0, to: size, by: l) {
                    for i in 0..<l {
                        for j in 0..<l {
                            temp[sy + l - 1 - j][sx + i] = map[sy + i][sx + j]
                        }
                    }
                }
            }
            map = temp
        case 5:
            var temp = map
            for sy in stride(from: 0, to: size, by: l) {
                for sx in stride(from: 0, to: size, by: l) {
                    for i in 0..<l {
                        for j in 0..<l {
                            temp[size - l - sy + i][sx + j] = map[sy + i][sx + j]
                        }
                    }
                }
            }
            map = temp
        case 6:
            var temp = map
            for sy in stride(from: 0, to: size, by: l) {
                for sx in stride(from: 0, to: size, by: l) {
                    for i in 0..<l {
                        for j in 0..<l {
                            temp[sy + i][size - l - sx + j] = map[sy + i][sx + j]
                        }
                    }
                }
            }
            map = temp
        case 7:
            var temp = map
            for sy in stride(from: 0, to: size, by: l) {
                for sx in stride(from: 0, to: size, by: l) {
                    for i in 0..<l {
                        for j in 0..<l {
                            temp[sx + i][size - l - sy + j] = map[sy + i][sx + j]
                        }
                    }
                }
            }
            map = temp
        case 8:
            var temp = map
            for sy in stride(from: 0, to: size, by: l) {
                for sx in stride(from: 0, to: size, by: l) {
                    for i in 0..<l {
                        for j in 0..<l {
                            temp[size - l - sx + i][sy + j] = map[sy + i][sx + j]
                        }
                    }
                }
            }
            map = temp
        default:
            break
        }
    }

    for row in map {
        print(row.map { String($0) }.joined(separator: " "))
    }
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================


/*
swift BOJ-20327.swift <<EOF
3 8
1 2 3 4 5 6 7 8
9 10 11 12 13 14 15 16
17 18 19 20 21 22 23 24
25 26 27 28 29 30 31 32
33 34 35 36 37 38 39 40
41 42 43 44 45 46 47 48
49 50 51 52 53 54 55 56
57 58 59 60 61 62 63 64
1 1
2 2
3 1
4 2
5 2
6 1
7 1
8 2
EOF
 */
