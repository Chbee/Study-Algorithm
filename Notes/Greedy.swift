
import Foundation

// MARK: - Greedy
// 현재 차례의 최고의 답을 찾는 문제
// 현재의 최선이 왜 나중에도 최고인지 증명이 필요함
//
// 예. 다른 금액 동전이 여러개 주어졋을 때 M원을 최소의 개수
//      1원 N개, 2원 M개, 5원 K개가 주어졌을 때 10원을 만들어야 한다.
//      5원 2개가 최소일것. 왜?를 찾는것이 그리드 -> 큰것부터 확인해야 최소의 개수를 확인할 수 있음
//      만약 어려우면 반례를 찾을것. 예를들면 2원을 먼저 조합할 때 2개 보다 더 작게 사용할 수 있는 경우가 있는가? 없음!
//
// https://www.acmicpc.net/problem/11047
//
// 1. 아이디어
//  - 동전을 저장한뒤 s반대로 뒤집음. 큰 금액의 동전부터 차감
//  - 동전 for문 돌 때, 동전 사용개수 추가, 동전 사용한만큼 K값 갱신
//  - 반례? 동전의 개수가 무한대라서 없는것으로 보임
//  - K를 동전 금액으로 나눈뒤 남은값으로 갱신
// 2. 시간복잡도
//  - 동전의 갯수만큼 for문 -> O(N)
// 3. 자료구조
//  - 동전 금액: [Int]
//  - 현재 남은 금액: Int
//  - 동전 개수: Int
//
// ===============
//

func solution() {
    let inputValue = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = inputValue[0]
    var k = inputValue[1]
    
    var coins = [Int]()
    for _ in 0..<n {
        coins.append(Int(readLine()!)!)
    }
    
    coins.reverse()
    
    // each_coin 사용 갯수 (몫)
    var cnt = 0
    
    for each_coin in coins {
        cnt += (k / each_coin)
        k = k % each_coin // 나머지 금액 구하기
    }
    
    print(cnt)
}

solution()
