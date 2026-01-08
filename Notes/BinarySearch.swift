
import Foundation

// MARK: - Binary Search
//
// 어떤 값을 찾을때 정렬의 특징을 이용해 빨리 찾는것
// 정렬이 되어 있을 경우, 어떤 값을 찾을 때: O(N) -> O(logN)
//
// 데이터가 연속되어 있을 때, 중위값과 비교해서 탐색 범위를 줄여나가는 알고리즘
//
// 예시
// 1~4 숫자 중 특정 숫자를 찾아야할때
// [1, 2, 3, 4] -> [1, 2] & [3, 4]로 나눔
// [2]의 값이 3과 비교햇을 때 작기 때문에 우측으로 탐색 시작
// 바로 [3]을 찾음
//      => 2회만에 찾음
//
// MARK: - 핵심 코드
let nums = [Int]()

/// 이진 탐색 핵심코드 (Swift)
/// - Parameters:
///   - st: StartIndex
///   - en: EndIndex
///   - target: 찾으려는 값
func search(st: Int, en: Int, target: Int) {
    if st == en {
        // ~~
        return
    }
    
    let mid = (st + en) / 2
    
    if nums[mid] < target {
        search(st: mid + 1, en: en, target: target)
    } else {
        search(st: st, en: mid, target: target)
    }
}

//
// https://www.acmicpc.net/problem/1920
//
// M의 배열의 값이 N에 존재하는지 찾는 알고리즘
//
// 1. 처음 아이디어
//  M개의 수마다 각각 어디에 있는지 찾기
//  for: M개의 수
//  for: N개의 수안에 있는지 확인
// 2. 처음 시간복잡도
//  O(M) x O(N) ~= O(100_000^2) -> 초과
// 3. 새로운 아이디어
//  연속하는 특징도 없음. 정렬해서 찾아내는것? 이진 탐색을 의심할것.
// 4. 새로운 시간복잡도
//  N개의 수 정렬: O(N * logN) -> 1개의 인자로 쪼개서 합치는 작업을 진행하기 때문에
//  M개의 수 이진탐색: O(M * logN)
//      ~= O((N+M)logN) ~= 2e5 * 20 = 4e6
// 5. 자료구조
//  - 탐색 대상의 수: [Int]
//  - 탐색 하려는 수: [Int]
// - Int 사용 가능한 범위인지 항상 확인할것
//
// -----------------
//

func solution() {
    guard let n = Int(readLine()!) else { return }
    
    var nums = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    guard let m = Int(readLine()!) else { return }
    
    let targetList = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    guard nums.count == n && targetList.count == m else { return }
    
    // 먼저 정렬 시작
    nums.sort()
    
    for each_target in targetList {
        search(st: 0, en: n - 1, target: each_target)
    }
    
    func search(st: Int, en: Int, target: Int) {
        // 모두 탐색할때 종료
        if st == en {
            // 마지막에 찾은 값이 target이 아닐 수도 있음
            if nums[st] == target { print(1) }
            else { print(0) }
            return
        }
        
        let mid = (st + en) / 2
        if nums[mid] < target {
            search(st: mid + 1, en: en, target: target)
        } else {
            search(st: st, en: mid, target: target)
        }
    }
}

solution()
