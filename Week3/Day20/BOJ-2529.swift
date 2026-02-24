//
//  BOJ-2529
//  백준 2529번 - 부등호
//
//  Created by 손지영 on 2026/02/24
//  난이도: 실버1 | 소요시간: 57분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/2529
//

import Foundation

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 부등호를 만족하는 수 중, 최댓값과 최솟값
///     - 선택한 숫자는 모두 달라야함
///     - dfs...
///     - minVal = [Int]; maxVal = [Int]
///     - minVal.count == k+1 && maxVal.count == k+1 return
///     - for i in start...9 -> 최소
///     - for i in stride(from: 9, through: 0, by: -1) -> 최대
///     - 탐색 순서로 답 결정: 오름차순 DFS의 첫 해답이 최소, 내림차순 DFS의 첫 해답이 최대.
///     - 백트래킹/방문 배열로 중복 숫자 제거.
///     - 부등호는 pos-1 기준으로 검사(pos번째 숫자를 넣을 때 s[pos-1] 확인).
/// 2. 자료구조
///     - visited: [Bool] (0~9 사용 여부)
///     - minArr/maxArr: [Int] (정답 수열 저장)
///     - s: [String] (부등호 목록)
/// 3. 시간복잡도
///     - O(10!)
// ============================================
// 📌 주의사항
// ============================================

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let k = Int(readLine()!)!
    var s = readLine()!.split(separator: " ").map { String($0) }
    
    var visited = Array(repeating: false, count: 10)
    
    var minArr = Array(repeating: 0, count: k+1)
    var maxArr = Array(repeating: 0, count: k+1)
    
    func dfsMin(pos: Int, prev: Int) -> Bool {
        if pos == k + 1 {
            return true
        }
        
        for next in 0...9 {
            if visited[next] { continue }
            if pos > 0 {
                guard isValid(prev, next, sign: s[pos - 1]) else { continue }
            }
            visited[next] = true
            minArr[pos] = next
            if dfsMin(pos: pos + 1, prev: next) { return true }
            visited[next] = false
        }
        
        return false
    }
    
    func dfsMax(pos: Int, prev: Int) -> Bool {
        if pos == k + 1 {
            return true
        }
        
        for next in stride(from: 9, through: 0, by: -1) {
            if visited[next] { continue }
            if pos > 0 {
                guard isValid(prev, next, sign: s[pos - 1]) else { continue }
            }
            visited[next] = true
            maxArr[pos] = next
            if dfsMax(pos: pos + 1, prev: next) { return true }
            visited[next] = false
        }
        
        return false
    }
    
    func isValid(_ prev: Int, _ next: Int, sign: String) -> Bool {
        if sign == ">" { return prev > next }
        else if sign == "<" { return prev < next }
        return false
    }
    
    _ = dfsMax(pos: 0, prev: 0)
    visited = Array(repeating: false, count: 10)
    _ = dfsMin(pos: 0, prev: 0)
    
    print(maxArr.map { String($0) }.joined(separator: ""))
    print(minArr.map { String($0) }.joined(separator: ""))
}

solution()

// ============================================
// ❓ 헷갈린점
// ============================================
/// 접근 방법 부터 생각이 안됨
/// for문까지는 쉽게 생각해냈는데, 부호와 숫자와, 중복과, 정렬 등등이 꼬이면서 생각 정리가 안됨.
