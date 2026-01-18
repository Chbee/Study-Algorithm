//
//  BOJ-1388
//  백준 1388번 - 바닥 장식
//
//  Created by 손지영 on 2026/01/18 17:04
//  난이도: 실버4 | 소요시간: 30분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1388
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 나무판자 1xn 또는 nx1, mxm방 크기
//      - -- & 같은 행: 같은 나무판자, || && 같은열 : 같은 나무판자
//      - "-"이면 x좌표 찾기, "|"이면 y좌표 찾기.
//      - xy 좌표 : map [[String]]
//      - 다음 좌표에 대해 방문 여부를 체크하고, 인접한 판자인지 체크한다음
//        두개 모두 충족하면 방문 처리 + 인접한 판자 cnt +=1
// 2. 자료구조
//      - map[[String]]
//      - chk[[Bool]]
//      - cnt 0
// 3. 시간 복잡도
//      - N*M = 5e1 * 5e1 = 25e2, 아무리 크게 잡아도 1e4 넉넉함.

// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let size = readLine()!.split(separator: " ").map { Int($0)! }
    let n = size[0]; let m = size[1]
    
    var map = Array(repeating: Array(repeating: "", count: m), count: n)
    
    for i in 0..<n {
        let tiles = readLine()!.map { String($0) }
        map[i] = tiles
    }
    
    let dy = [0, -1, 0, 1]
    let dx = [1, 0, -1, 0]
    
    var chk = Array(repeating: Array(repeating: false, count: m), count: n)
    var cnt = 0
    
    func dfs(y: Int, x: Int) {
        (chk[y])[x] = true
        
        let now = (map[y])[x]
        
        for i in 0..<4 {
            let ny = now == "|" ? y + dy[i] : y
            let nx = now == "-" ? x + dx[i] : x
            
            if ny >= 0, ny < n, nx >= 0, nx < m {
                if (chk[ny])[nx] == false && (map[ny])[nx] == now {
                    dfs(y: ny, x: nx)
                }
            }
        }
    }
    
    for y in 0..<n {
        for x in 0..<m {
            if (chk[y])[x] == false {
                cnt += 1
                dfs(y: y, x: x)
            }
        }
    }
    
    print(cnt)
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
// 1-based 고집 그만. 모든 상황에서 만능인것은 아니다.
