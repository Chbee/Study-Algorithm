
import Foundation

// MARK: - BackTracking
//
// 모든 경우의 수를 확인해야할때
// for만으로는 불가한 경우 (깊이가 달라질 때)
// 예로, 순열(M개의 숫자 중 N개를 뽑을 때, 순서가 상관이 있는것)을
// 재귀함수를 통해 필요한 깊이만큼 탐색함
//
// https://www.acmicpc.net/problem/15649
//
// 1. 아이디어
//  - 1부터 N중에 하나 선택 (for문)
//  - 다음 1부터 N부터 선택할 때 이미 선택한 값이 아닌 경우 선택 (방문 여부 체크)
//  - M개를 선택할 경우 프린트 (결과값.count == M일때)
// 2. 시간복잡도
//  - 중복이 가능: N^N, N이 8까지 가능
//  - 중복이 불가: N!, N이 10까지 가능
// 3. 자료구조
//  - 방문 여부 확인: [Bool]
//  - 결과값 저장: [Int]
//
// -----

func solution() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let n = input[0]; let m = input[1]
    
    var result = [Int]()
    var chk = Array(repeating: false, count: n + 1) // 동일한 index를 사용하기 위해서 하나 더 크게 만들고, firstItem은 사용안함
    
    func recur(_ num: Int) {
        if num == m {
            print(result.map({ String($0) }).joined(separator: " "))
            return
        }
        
        for i in 1..<(n+1) {
            if chk[i] == false {
                chk[i] = true
                result.append(i)
                recur(num + 1)
                chk[i] = false
                _ = result.removeLast()
            }
        }
    }
    
    recur(0)
}

solution()

// 선택 취소가 왜 필요한가
func example() {
    let n = 4
    let m = 2
    
    var result = [Int]()
    var chk = Array(repeating: false, count: n + 1)
    
    // 이 조건이면, [1, 2, 3, 4] 중에 2개를 순서 상관있이 출력해야함.
    
    func recur(_ num: Int) {
        if num == m {
            print(result)
            return
        }
        
        for i in 1..<(n+1) {
            if chk[i] == false {
                chk[i] = true
                result.append(i)
                recur(num + 1)
                chk[i] = false
                result.dropLast()
            }
        }
    }
    
    recur(0)
    
    // 위 동작이 실행되는데 만약 선택 취소가 없으면
    // recur(0)
    //  1..<5
    //  i=1: chk[1]=true, result=[1], recur(1) 호출
    //      num=1
    //      i=1: chk[1]=true 패스
    //      i=2: chk[2]=true, result=[1,2], recur(2) 호출
    //      num=2
    //      m==2==sum으로 반복문 종료하고 [1,2] 출력
    //  i=2: chk[2]가 이미 true pass
    //  i=3: chk[3]=true, result=[1,2,3] < 여기서 이미 오류
    //  다음 깊이를 탐색할 때 초기화를 위해 drop 필요
}
