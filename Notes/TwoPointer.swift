
import Foundation

// MARK: - TowPointer
//
// 각 원소마다 모든값을 순회해야할때 O(N^2)
// 연속하는 특성을 이용해서 처리 O(N)
//
// 예를들어,
// 1, 2, 3, 4, 5 라는 숫자가 있을 때, 연속한 3개의 값중 가장 큰 값을 구하는 로직에 사용
//
// N개의 숫자를 K개 만큼 연속하는 수
//
// https://www.acmicpc.net/problem/2559
//
// 1. 가장 쉬운 방법 부터 접근
//  - for 문으로 각 숫자의 위치에서 이후 K개의 수를 더함 -> 최대값 갱신
// 2. 처음 시간 복잡도
// - O(NK) ~= O(100_000^2) ~= O(1e^10) : 2억을 초과함
// 3. 다른 방법으로의 접근
//  - 처음에 K개의 값을 구함
//  - for문을 통해 다음 인덱스의 값을 더하고, 앞의 값을 뺌
//  - 이때 최대값 갱신
// 4. 시간복잡도
//  - 숫자 개수만큼 for: O(N)
//  - 두번씩 연산: x 2
//  - = O(2 * N) ~= O(N)
// 5. 자료구조
//  - 전체 정수 배열: [Int]
//      - 숫자들 최대 100 -> Int가능
//  - K개의 값을 저장하는 변수 : Int
//      -> K는 1 과 N사이 (10만)
//  - 최대값: Int
//
// -------------
//

func solution() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    var n, k: Int
    
    n = input[0]; k = input[1]
    
    let numbers = readLine()!.split(separator: " ").compactMap { Int($0) }
    
    var each = 0
    
    // K개 더해주기
    // 10 2
    // 3 -2 -4 -9 0 3 7 13 8 -3
    // 위와 같은 입력값일 때 먼저 비교를 위한 (3 + (-2)) 진행하고 최대값 취급
    for i in 0..<k {
        each += numbers[i]
    }
    
    var maxv = each
    
    // 다음 인덱스 더해주고 이전 인덱스 빼주기
    for i in k..<n {
        each += numbers[i]
        each -= numbers[i - k]
        maxv = max(each, maxv)
    }
    
    print(maxv)
}

solution()


// =================== TIP!
// 처음 생각한 아이디어가 O(N^2) 시간복잡도를 초과한다면, 연속하다는 특징을 활용할 수 잇는지 확인
// for 내부 투포인터 계산하는 값의 최대값 확인 필수
// 투포인터 문제 종류
//  두개 다 왼쪽에서 / 각각 왼쪽, 오른쪽 / 다른 배열
//  일반 O(N) / 정렬 후 투포인터: O(NlogN)
