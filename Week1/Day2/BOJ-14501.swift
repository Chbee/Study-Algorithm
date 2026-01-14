//
//  BOJ-14501
//  백준 14501번 - 퇴사
//
//  Created by 손지영 on 2025/01/07
//  난이도: 실버3 | 소요시간: 60 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/14501
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 사용할 자료구조/알고리즘:
//      - 날짜, 수익 배열: [Int]
//      - 최대 수익 배열: [Int]
//      -
//      -
//
// 2. 시간복잡도:
//      -
//
// 3. 접근 방법:
//      - 선택했을 때와 선택하지 않았을 때를 모두 고려해서 재귀를 통해 max를 찾는다.
//          : 재귀에 상담 시작 스케쥴을 받아서, 내부에 for문을 두고 받아온 시작 스케쥴과 종료 스케쥴만큼 반복.
//          : for문에서 다음 날을 선택하는 기준은 다음날을 진행했을 때 N일을 넘지 않아야한다.
//          : for문 시작할 때 day값이 n+1값과 비교해서 같을 때 값을 출력함
//          : for문 시작할 때 day값이 n+1값 보다 크면 즉시 return > 충족하지 않는 조건이므로.
//          : 시간 복잡도가 2^N이라서 충분하지만 DP로 풀어보고 싶으므로 DP로 접근.
//      - 두번째 접근. 이전값 활용
//          : 오늘을 선택, 오늘을 선택 안함을 기준으로 처리.
//          : 오늘을 선택했는데, 상담 날짜를 봤더니 퇴사일이 넘어가면 -> 최대값을 미래 날짜로 변경
//          : 오늘을 선택했는데, 상담 날짜를 봤더니 상담이 가능하면 -> 오늘 발생한 수익과, 미래에 발생할 수익의 합과 내일 발생할 수익의 최대값으로 최신화
//
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    
    var t = Array(repeating: 0, count: n+1)
    var p = Array(repeating: 0, count: n+1)
    for i in 1..<n+1 {
        let input = readLine()!.split(separator: " ").compactMap { Int($0) }
        t[i] = input[0]
        p[i] = input[1]
    }
    
    var maxV = Array(repeating: 0, count: n + 2)
    maxV[n+1] = 0
    
    for today in stride(from: n, through: 1, by: -1) {
        if today + t[today] > n + 1 {
            maxV[today] = maxV[today + 1]
        } else {
            let willMax = p[today] + maxV[today + t[today]]
            maxV[today] = max(willMax, maxV[today + 1])
        }
    }
    
    print(maxV[1])
}

func claude() {
    let N = Int(readLine()!)!
    var T = [0] // 더미
    var P = [0] // 더미

    for _ in 0..<N {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        T.append(input[0])
        P.append(input[1])
    }

    var dp = [Int](repeating: 0, count: N + 2)

    for i in stride(from: N, through: 1, by: -1) {
        if i + T[i] > N + 1 {
            dp[i] = dp[i + 1]
        } else {
            dp[i] = max(P[i] + dp[i + T[i]], dp[i + 1])
        }
    }

    print(dp[1])  // 최댓값 찾는 게 아니라 dp[1] 출력!
}

//claude()

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
// 점화식을 세울것, 큰 값부터 처리할것
