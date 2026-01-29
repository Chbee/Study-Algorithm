//
//  BOJ-10816
//  백준 10816번 - 숫자 카드 2
//
//  Created by 손지영 on 2026/01/22
//  난이도: 실버4 | 소요시간: 40분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/10816
//

import Foundation


// ============================================
// 💡 핵심 아이디어
// ============================================
// 1. 핵심 아이디어
//      - 카드 N개, 정수 M개
//      - 정수 M개가 포함된 카드 갯수
//      - 카드 N개 오름차순 정렬.
//      - for in 정수 배열
//      - 카드가 중복일 수 있음.. 중위값 찾았을 때 right까지 하나씩 늘려가며 숫자 찾기?
//      - n[mid] == i일 때, for min+1...right, n[j] == i +1, 아니면 break
//      - 그럼 담을 변수가 있어야겠다.
//      => 이건 최악의 경우
// 2. 자료구조
//      - a [Int]
//      - b [Int]
//      - result [Int]
// 3. 시간 복잡도
//      - NlogN -> a배열 정렬
//      - logN -> b배열 이진 탐색
//      - O(NlogN + NlogN)??

// ============================================
// 📌 주의사항
// ============================================
//

// ============================================
// 🔨 구현
// ============================================

func solution() {
    let n = Int(readLine()!)!
    let a = readLine()!.split(separator: " ").map { Int($0)! }.sorted()
    
    let m = Int(readLine()!)!
    let b = readLine()!.split(separator: " ").map { Int($0)! }
    
    var result = [Int]()
    
    func lowerBound(_ target: Int) -> Int {
        var l = 0
        var r = n
        while l < r {
            let m = (l + r) / 2
            if a[m] < target {
                l = m + 1
            } else {
                r = m
            }
        }
        return l
    }
    
    func upperBound(_ target: Int) -> Int {
        var l = 0
        var r = n
        while l < r {
            let m = (l + r) / 2
            if a[m] <= target {
                l = m + 1
            } else {
                r = m
            }
        }
        return l
    }
    
    for x in b {
        let count = upperBound(x) - lowerBound(x)
        result.append(count)
    }
    
    print(result.map{ String($0) }.joined(separator: " "))
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
//
// 처음 생각한 아이디어는 시간복잡도 최악의 경우..
// lowerBound는 target 이상이 처음 등장하는 위치
// upperBound는 target 초과가 처음 등장하는 위치
// 두 위치값을 빼면 x의 개수를 구한다.


