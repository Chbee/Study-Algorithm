
/*
 # 완전 탐색 개념 확인
 */

// MARK: 📋 선형 탐색 (Linear Search)
// 목표: 배열에서 특정 값 찾기

// 문제 1
// [3, 7, 2, 9, 1]에서 9가 있는지 찾기
var arr = [3, 7, 2, 9, 1]

func linearSearch(find target: Int, in arr: [Int]) -> Int? {
    // O(n)
    var targetIdx: Int?
    
    for (idx, item) in arr.enumerated() {
        if item == target { targetIdx = idx }
    }
    
    return targetIdx
}

// 테스트 1
print(linearSearch(find: 9, in: arr)) // 3
print(linearSearch(find: 5, in: arr)) // nil

// - MARK: 📋 두 수의 합 찾기 (Two Sum)
// 목표: 배열에서 합이 target인 두 수 인덱스 찾기

// 문제 1
// [2, 7, 11, 15]에서 합이 target인 두 수의 인덱스 찾기
var arr1 = [2, 7, 11, 15]

func twoSum(find target: Int, in arr: [Int]) -> (Int, Int)? {
    var numberIndexes: (Int, Int)? = nil
    for (i, num1) in arr.enumerated() {
        for (j, num2) in arr.enumerated() where j > i {
            if num1 + num2 == target { numberIndexes = (i, j); break }
        }
    }
    return numberIndexes
}

// 테스트1
if let test1 = twoSum(find: 9, in: arr1) {
    print("findNumber: \(arr[test1.0]), \(arr[test1.1])")
}

if let test2 = twoSum(find: 26, in: arr1) {
    print("findNumber: \(arr[test2.0]), \(arr[test2.1])")
}

// - MARK: 📋 세 수의 합 찾기 (Three Sum)
// 목표: BOJ-2798처럼 세 수의 합 찾기

// 문제1
// [5, 6, 7, 8, 9]에서 합이 21에 가장 가까운 세 수 찾기
var cards = [5, 6, 7, 8, 9]

func threeSum(find: Int, in arr: [Int]) -> Int? {
    var maxSum = -1
    
    for (i, num1) in arr.enumerated() {
        for (j, num2) in arr.enumerated() where j > i {
            for (k, num3) in arr.enumerated() where k > j {
                let sum = num1 + num2 + num3
                if sum == find { maxSum = sum; break }
                else if sum < find {
                    maxSum = max(sum, maxSum)
                }
            }
        }
    }
    
    return maxSum
}

// 테스트
print(threeSum(find: 21, in: cards))  // 21
print(threeSum(find: 20, in: cards))  // 20

// MARK: 📋 조합 기초 (반복문)
// 목표: N개 중 2개를 선택하는 모든 조합 출력

// 문제 1
// [1, 2, 3, 4]에서 2개를 선택하는 모든 조합 출력
// 조합의 개수: C(4, 2) = 4 × 3 / 2 = 6가지
var arr2 = [1, 2, 3, 4]

func combinationTwo(from arr: [Int]) -> [[Int]] {
    var startIdx = 0
    
    var result: [[Int]] = []
    for i in startIdx..<arr.count {
        for j in i+1..<arr.count {
            result.append([arr[i], arr[j]])
        }
        startIdx += 1
        if startIdx == arr.count { break }
    }
    
    return result
}

// 테스트 1
print("=== 조합 기초 (반복문) ===")
let combinations = combinationTwo(from: arr2)
print("조합 개수: \(combinations.count)개")  // Expected: 6개
print(combinations)  // Expected: [[1,2], [1,3], [1,4], [2,3], [2,4], [3,4]]


// MARK: 📋 조합 심화 (재귀)
// 목표: N개 중 R개를 선택하는 범용 조합 함수 구현

// 문제 1
// [1, 2, 3, 4, 5]에서 3개를 선택하는 모든 조합 출력
// 조합의 개수: C(5, 3) = 5 × 4 × 3 / (3 × 2 × 1) = 10가지
var arr3 = [1, 2, 3, 4, 5]

func combination(from arr: [Int], select r: Int) -> [[Int]] {
    var result: [[Int]] = []
    
    combinationHelper(from: arr, select: r, start: 0, current: [], result: &result)
    
    return result
}

private func combinationHelper(from arr: [Int], select r: Int, start: Int, current: [Int], result: inout [[Int]]) {
    if current.count == r {
        result.append(current)
        return
    }
    
    for i in start..<arr.count {
        combinationHelper(from: arr, select: r, start: i+1, current: current + [arr[i]], result: &result)
    }
}

// 테스트 1
print("\n=== 조합 심화 (재귀) ===")
var result3: [[Int]] = combination(from: arr3, select: 3)
print("조합 개수: \(result3.count)개")  // Expected: 10개
print(result3)  // Expected: [[1,2,3], [1,2,4], [1,2,5], [1,3,4], [1,3,5], [1,4,5], [2,3,4], [2,3,5], [2,4,5], [3,4,5]]


// MARK: 📋 순열 (Permutation)
// 목표: N개를 나열하는 모든 순서 생성

// 문제 1
// [1, 2, 3]을 나열하는 모든 방법
// 순열의 개수: 3! = 6가지
var arr4 = [1, 2, 3]

func permutation(from target: [Int], select r: Int) -> [[Int]] {
    var result = [[Int]]()
    
    var visited = Array(repeating: false, count: target.count)
    
    func backtracking(in arr: [Int]) {
        if arr.count == r {
            result.append(arr)
            return
        }
        for i in 0..<target.count {
            if visited[i] == true { continue }
            else {
                visited[i] = true
                backtracking(in: arr + [target[i]])
                visited[i] = false
            }
        }
    }
    backtracking(in: [])
    return result
}

// 테스트 1
print("\n=== 순열 ===")
var result4: [[Int]] = permutation(from: arr4, select: 3)
print("순열 개수: \(result4.count)개")  // Expected: 6개
print(result4)  // Expected: [[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]]


// MARK: 📋 비트마스크 (Bitmask)
// 목표: 집합의 모든 부분집합 생성 (2^N)

// 비트(0과 1)를 사용해서 "선택/비선택"을 표현하는 방법
//
// 집합 {1, 2, 3}이 있을 때
// 각 원소를 선택(1) 또는 비선택(0)으로 표현:
// - 1을 선택? -> 1 또는 0
// - 2를 선택? -> 1 또는 0
// - 3을 선택? -> 1 또는 0
//
// 이진수로 표현하면
// 101: 1 선택, 2 미선택, 3선택 = { 1, 3 }

// 문제 1
// {1, 2, 3}의 모든 부분집합 출력
// 부분집합의 개수: 2^3 = 8가지
var arr5 = [1, 2, 3]

let mask = 5
print("mask = \(mask) (이진수: \(String(mask, radix: 2)))")

if mask & (1 << 0) != 0 {
    print("0번째 비트가 1 -> 1 선택")
}

if mask & (1 << 1) != 0 {
    print("1번째 비트가 1 -> 2 선택")
}

if mask & (1 << 2) != 0 {
    print("2번째 비트가 1 -> 3 선택")
}


func allSubsets(from arr: [Int]) -> [[Int]] {
    var result = [[Int]]()
    
    // 0부터 2^n - 1까지 모든 숫자 시도
    for mask in 0..<(1 << arr.count) {
        var subset: [Int] = []
        
        // mask의 각 비트 확인
        for i in 0..<arr.count {
            // i번째 비트가 1이면 arr[i] 선택
            if mask & (1 << i) != 0 {
                subset.append(arr[i])
            }
        }
        
        result.append(subset)
    }
    
    return result
}

// 테스트 1
print("\n=== 비트마스크 ===")
let subsets = allSubsets(from: arr5)
print("부분집합 개수: \(subsets.count)개")  // Expected: 8개
print(subsets)  // Expected: [[], [1], [2], [1,2], [3], [1,3], [2,3], [1,2,3]]
