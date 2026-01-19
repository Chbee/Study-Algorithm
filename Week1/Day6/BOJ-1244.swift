//
//  BOJ-1244
//  백준 1244번 - 스위치 켜고 끄기
//
//  Created by 손지영 on 2026/01/19 09:10
//  난이도: 실버4 | 소요시간: 30분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/1244
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 1과 0의 상태 스위치
//      - 남: 스위치 번호가 본인이 받은 숫자의 배수이면 상태를 변경함. (3번을 받으면 3의 배수에 대한 스위치 모두 변경)
//      - 여: 본인이 받은 스위치를 중심으로 좌우 대칭이면서 가장 많은 스위치를 포함하는 구간에 대해 모든 상태 변경. 구간의 개수는 항상 홀수.
//      - 1-based 배열
//      - 남일때 여일때 사용해야하는 알고리즘 다름.
//          - 남: dfs로 처리하면 될듯, 시작점을 받은 숫자로 해서, 스위치 개수만큼 확인할 때 까지 받은 숫자의 배수의 index를 모두 찾아 변경
//              -> start: inputValue, 방문 했으면 건너띔. 방문 안했으면 방문 처리 후 index + inputValue 값을 찾을텐데, 이 값이 스위치의 최대값보다 작거나 같아야함.
//          - 여: "중심으로 좌우 대칭", 입력값이 3이면 3을 중심으로 대칭되는것을 찾아야함. two pointer?
//              -> 대칭.. 일단 3이 들어오면 2와 4를 탐색해야함. 2와 4가 같다면 1와 5를 탐색해야함.
//              -> 탐색 범위를 넓혀갈 때, index가 1...스위치 최대값 안에서 움직여야함. 이걸 넘어가면 탐색 종료.
//              -> left, right 값을 업데이트 해주면 될듯.
// 2. 자료구조
//      - sequence: [Int]
//      - left, right: Int
// 3. 시간 복잡도
//      - 남: O(N)
//      - 여: O(N)
//      - N은 100이하의 정수, 2e2이므로 충분.

// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let cnt = Int(readLine()!)!
    
    var s = Array(repeating: false, count: cnt + 1)
    
    let inputS = readLine()!.split(separator: " ").map { Int($0)! }
    for (i, v) in inputS.enumerated() {
        s[i+1] = v == 1 ? true : false
    }
    
    let studentNum = Int(readLine()!)!
    
    for _ in 0..<studentNum {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        
        let isMan = input[0] == 1
        let start = input[1]
        
        if isMan {
            dfs(index: start, addNum: start)
        } else {
            var left: Int = start
            var right: Int = start
            
            twoPointer(left: &left, right: &right)
            
            for i in left...right {
                s[i].toggle()
            }
        }
    }
    
    func dfs(index: Int, addNum: Int) {
        s[index].toggle()
        
        guard index + addNum <= cnt else { return }
        dfs(index: index + addNum, addNum: addNum)
    }
    
    func twoPointer(left: inout Int, right: inout Int) {
        guard left - 1 >= 1, right + 1 <= cnt else { return }
        
        if s[left - 1] == s[right + 1] {
            left = left - 1
            right = right + 1
            twoPointer(left: &left, right: &right)
        }
    }
    
    var line: [String] = []
    for i in 1...cnt {
        line.append(s[i] ? "1" : "0")
        if i % 20 == 0 || i == cnt {
            print(line.joined(separator: " "))
            line.removeAll(keepingCapacity: true)
        }
    }
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
