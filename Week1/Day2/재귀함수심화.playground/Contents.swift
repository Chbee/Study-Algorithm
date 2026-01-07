import Foundation


// MARK: - 재귀의 이해
// 재귀 기본 패턴
func factorial(_ n: Int) -> Int {
    if n <= 1 { return 1 } // 기저 조건
    return n * factorial(n - 1) // 재귀 호출
}

// 재귀로 배열 순회
func printArray(_ arr: [Int], _ index: Int) {
    if index == arr.count { return }
    print(arr[index])
    printArray(arr, index + 1)
}

// 시간 복잡도가.. O(n)
// 공간 복잡도가..
//      getSum이 n번 중첩 호출 됨. -> O(n)
//      sum은 inout으로 같은 메모리 계속 사용 -> O(1)
//      index는 재귀로 getSum 내부에서 n번 중첩 호출 됨 -> O(n)
//  최종 공간 복잡도 : O(n)
func getSum(_ arr: [Int], _ index: Int, sum: inout Int) {
    if index == arr.count { return }
    sum += arr[index]
    getSum(arr, index + 1, sum: &sum)
}

// 시간 복잡도가 O(n), 공간 복잡도가 O(1)
func getSumRefactor(_ arr: [Int]) -> Int {
    var sum: Int = 0
    for value in arr {
        sum += value
    }
    return sum
}

var sum = 0
let sumArr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
getSum(sumArr, 0, sum: &sum)
print(sum)
print(getSumRefactor(sumArr))


// MARK: - 백트래킹 개념 이해
/*
 백트래킹 = 재귀 + 가지치기(pruning)
    -> 모든 경우를 탐색하되, 조건에 맞지 않으면 즉시 되돌아감
    -> 선택 > 탐색 > 복원 패턴
 */

struct Choice {}

typealias State = Int

var 목표달성: Bool = true
var 조건위반: Bool = false
func 결과저장() {}
func 선택하기() {}
func 선택취소() {}

// 기본 템플릿
@MainActor
func backtrack(_ 현재상태: State, _ 선택목록: [Choice]) {
    // 1. 종료 조건 (기저 조건)
    if 목표달성 == true {
        결과저장()
        return
    }
    
    // 2. 가지치기 (불필요한 탐색 제거)
    if 조건위반 {
        return
    }
    
    // 3. 선택지 재탐색
    for 선택 in 선택목록 {
        선택하기()
        backtrack(현재상태 + 1, 선택목록)
        선택취소()
    }
}

// MARK: - 순열과 조합

// MARK: 순열 (Permutation) - [1,2]와 [2,1]은 다름
func permutation(_ arr: [Int], _ n: Int) -> [[Int]] {
    var result: [[Int]] = []
    var visited = Array(repeating: false, count: arr.count)
    var current: [Int] = []
    
    func dfs() {
        if current.count == n {
            result.append(current)
            return
        }
        
        for i in 0..<arr.count {
            if visited[i] { continue }
            
            visited[i] = true
            current.append(arr[i])
            dfs()
            current.removeLast()
            visited[i] = false
        }
    }
    
    dfs()
    return result
}

// MARK: 조함 (Combination) = [1,2]와 [2,1]은 같음
func combination(_ arr: [Int], _ n: Int) -> [[Int]] {
    var result: [[Int]] = []
    var current: [Int] = []
    
    func dfs(_ start: Int) {
        if current.count == n {
            result.append(current)
            return
        }
        
        for i in start..<arr.count {
            current.append(arr[i])
            dfs(i + 1)
            current.removeLast()
        }
    }
    
    dfs(0)
    return result
}

// MARK: - 백트래킹 연습 (가이드 전용)
// 목표: 선택한 숫자들의 합 == target.
// 가지치기와 선택/탐색/복원 패턴을 직접 구현하세요.
func subsetSumGuide(_ nums: [Int], target: Int) -> [[Int]] {
    var result: [[Int]] = []
    var path: [Int] = []
    
    // TODO: 선택적 가지치기 헬퍼. 예:
    // - nums가 모두 양수일 때 currentSum > target이면 즉시 반환
    // - 남은 모든 수를 더해도 target에 도달할 수 없으면 즉시 반환

    func dfs(_ index: Int, _ currentSum: Int) {
        if index == nums.count {
            if currentSum == target { result.append(path) }
            return
        }
        
        // TODO: 가지치기 조건(들) 위치
        
        // 현재 원소 선택한경우
        path.append(nums[index])
        dfs(index + 1, currentSum + nums[index])
        path.removeLast()
        
        // 현재 원소 선택하지 않음
        if index + 1 < nums.count {
            dfs(index + 1, currentSum)
        }
    }

    dfs(0, 0)
    return result
}

// 테스트 예시 (구현 후 확인용)
// 1) nums = [1, 2, 3], target = 3 -> [[1, 2], [3]]
// 2) nums = [2, 4, 6], target = 6 -> [[2, 4], [6]]
// 3) nums = [1, 5, 7, 8], target = 13 -> [[5, 8]]
print(subsetSumGuide([1, 2, 3], target: 3))
