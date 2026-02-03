//
//  BOJ-10816
//  백준 10816번 - 숫자 카드 2
//
//  Created by 손지영 on 2026/02/03
//  난이도: 실버4 | 소요시간: 20분 | 상태: ✅
//  링크: https://www.acmicpc.net/problem/10816
//

// ============================================
// 💡 핵심 아이디어
// ============================================
/// 1. 핵심아이디어
///     - 정수 M을 포함하는 갯수 출력
///     - 들고있는 카드를 오름차순 정렬한다.
///     - cards: [-10, -10, 2, 3, 3, 6, 7, 10, 10, 10]
///     - 첫번째 찾을 카드가 x: 10
///     - left = 0, right = cards.count
///     - mid = (left + right) / 2
///     - cards[cards.count / 2]의 값(6)이 x보다 작으면, 오른쪽에서 찾아야하므로 왼쪽 index를 mid+1
///     - cards[cards.count / 2]의 값이 x보다 크면, 왼쪽에서 찾아야 하므로 오른쪽 index를 mid로
/// 2. 자료구조
///     - l, r, mid = Int
///     - cards [Int]
///     - findNum [Int]
///     - result [Int]
/// 3. 시간복잡도
///     - 정렬: NlogN
///     - 이진탐색: logN
///     - O(NlogN+MlogN), N = 500_000 = 5e5 ~= 10^2 = 2^10, 2^30 즈음
///       ~= 5e5 * 30 + 30 = 15e6 + 30
// ============================================
// 📌 주의사항
// ============================================
///
// ============================================
// 🔨 구현
// ============================================
func solution() {
    let n = Int(readLine()!)!
    let a = readLine()!.split(separator: " ").map({ Int($0)! }).sorted()
    
    let m = Int(readLine()!)!
    let b = readLine()!.split(separator: " ").map { Int($0)! }
    
    var result = [Int]()
    
    for num in b {
        result.append(foundLastIndex(num) - foundFirstIndex(num))
    }
    
    func foundFirstIndex(_ num: Int) -> Int {
        var l = 0
        var r = n
        
        while l < r {
            let mid = (r + l) / 2
            if a[mid] < num {
                l = mid + 1
            } else {
                r = mid
            }
        }
        
        return l
    }
    
    func foundLastIndex(_ num: Int) -> Int {
        var l = 0
        var r = n
        
        while l < r {
            let mid = (r + l) / 2
            if a[mid] <= num {
                l = mid + 1
            } else {
                r = mid
            }
        }
        
        return l
    }
    
    print(result.map { String($0) }.joined(separator: " "))
}

solution()

// ============================================
// ❌ 헷갈린점
// ============================================
///
