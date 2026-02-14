import Foundation

//: ## Day 17 - 위상정렬 + 투포인터
/*:
 ---
 * 1. 위상정렬 (Topological Sort)
 ---
 */
/// 핵심질문: 선행 조건이 있는 작업들을, 규칙을 어기지 않고 나열할 수 있는가?
/// 정점 (Vertex): 작업/건물/과목/문제
/// 간선(A -> B): A를 먼저 해야 B 가능
/// 이 그래프는 반드시 사이클 없는 방향 그래프(DAG)여야 함.
/*:
 ---
 * 2. 위상정렬이 성립하는 조건
 ---
 */
/// 조건 1.
///     진입차수 0: 지금 당장 시작 가능한 작업
/// 조건 2.
///     모든 노드 처리: 전체 순서 존재
/// 조건 3.
///     일부만 처리됨: 사이클이 존재
/*:
 ---
 * 3. 구현패턴 A - 진입차수 (Kahn 알고리즘)
 ---
 */
/// BFS 기반, DP와 결합하기 편함
/// 시간복잡도: O(V + E)
/// 공간복잡도: O(V + E)
/// 1. 필요한 자료구조
///     - ads   : [[Int]] -> 인접 리스트
///     - indeg : [Int]   -> 진입차수
///     - queue : [Int]   -> indeg == 0 노드
///     - order : [Int]   -> 위상정렬 결과
/// 2. 알고리즘 절차
///     - 그래프 입력 -> indeg 계산
///     - indeg == 0 인 노드를 큐에 삽입
///     - 큐에서 하나 꺼내 결과에 추가
///     - 해당 노드가 가르키는 노드들의 indeg 감소
///     - 새로운 indeg == 0 된 노드를 큐에 삽입
///     - 결과 개수 < N -> 사이클

func Kahn(_ N: Int) {
    
    var adj = Array(repeating: [Int](), count: N + 1)
    var indeg = Array(repeating: 0, count: N + 1)
    
    var edges = [(Int, Int)]()
    
    for (u, v) in edges {
        adj[u].append(v)
        indeg[v] += 1
    }
    
    var queue = [Int]()
    queue.reserveCapacity(N)
    for i in 1...N where indeg[i] == 0 {
        queue.append(i)
    }
    
    var head = 0
    var order = [Int]()
    
    while head < queue.count {
        let cur = queue[head]
        head += 1
        order.append(cur)
        
        for nxt in adj[cur] {
            indeg[nxt] -= 1
            if indeg[nxt] == 0 {
                queue.append(nxt)
            }
        }
    }
    
    // order.count == N 이면 성공
}

/*:
 ---
 * 4. 구현패턴 B - 위상정렬 + DP
 ---
 */
/// "선행 조건을 만족하면서 최소/최대 시간, 비용, 점수를 구하라"
/// - 위상정렬 순서 = DP가 안전한 계산 순서
/// - 모든 선행 노드가 처리된 시점에만 값이 확정됨
/// - dp[i] = i번 노드까지 왔을 때의 최대값
/// - dp[next] = max(dp[next], dp[cur] + cost[next])
/// 시간복잡도: O(V + E)
/// 공간복잡도: O(V + E)
/// 기본 구조
/// N: 작업 수 (1...N)
/// edges: (u -> v)  // u를 끝내야 v를 시작 가능
/// time[i]: i 작업에 걸리는 시간 (1-indexed)
///
/// 반환: 각 작업의 earliest finish time (dp), 그리고 전체 완료 시간(최댓값)
func topoDP(N: Int, edges: [(Int, Int)], time: [Int]) -> (dp: [Int], total: Int) {
    var adj = Array(repeating: [Int](), count: N + 1)
    var indeg = Array(repeating: 0, count: N + 1)
    
    for (u, v) in edges {
        adj[u].append(v)
        indeg[v] += 1
    }
    
    // dp[i] = i 작업의 "최소 완료 시간""/
    var dp = Array(repeating: 0, count: N + 1)
    
    // indeg==0 인 작업은 바로 시작 가능 -> 완료시간은 time[i]
    var q = [Int]()
    q.reserveCapacity(N)
    for i in 1...N where indeg[i] == 0 {
        q.append(i)
        dp[i] = time[i]
    }
    
    var head = 0
    var processed = 0
    
    while head < q.count {
        let cur = q[head]; head += 1
        processed += 1
        
        for nxt in adj[cur] {
            // cur을 끝내고 nxt로 넘어갈 수 있으므로
            // nxt의 완료 시간 후보 = dp[cur] + time[nxt]
            dp[nxt] = max(dp[nxt], dp[cur] + time[nxt])
            
            indeg[nxt] -= 1
            if indeg[nxt] == 0 {
                q.append(nxt)
            }
        }
    }
    // 사이클 체크(원하면 여기서 예외처리/불가능 처리)
    // processed != N 이면 모든 작업을 완료할 수 없는 구조

    let total = dp.max() ?? 0
    return (dp, total)
}
/*:
 ---
 * 5. Two Pointers
 ---
 */
/// "두 포인터가 뒤로 가지 않아도 되는가?"
///   YES: O(N)
///   NO : 투포인터 아님
/*:
 ---
 * 6. 구현패턴 A - 슬라이딩 윈도우 (같은 방향)
 ---
 */
/// 적용 조건
///     - 배열 원소가 모두 양수일것
///     - right 증가 -> 상태 단조 증가
///     - left 증가 -> 상태 단조 감소
/// 시간복잡도: O(N)
/// 공간복잡도: O(1)
/// 기본 구조
func SlidingWindow(_ target: Int) {
    var left = 0
    var current = 0
    var answer = Int.max
    
    var arr = [Int]()
    
    for right in 0..<arr.count {
        current += arr[right]
        
        while current >= target {
            answer = min(answer, right - left + 1)
            current -= arr[left]
            left += 1
        }
    }
}
/*:
 ---
 * 7. 구현패턴 B - 양 끝 포인터 (정렬 필요)
 ---
 */
/// 적용 조건
///     - 정렬된 배결
///     - 합 / 차이 / 거리 최소화
/// 시간복잡도: O(N) (정렬 제외)
/// 공간복잡도: O(1)
/// 기본 구조
func DoubleEndPointer(_ arr: [Int], _ target: Int) {
    let a = arr.sorted()
    var l = 0; var r = a.count - 1
    
    while l < r {
        let sum = a[l] + a[r]
        if sum == target {
            break
        } else if sum < target {
            l += 1
        } else {
            r -= 1
        }
    }
}
/*:
 ---
 * 8. 투포인터 사용 불가 판별
 ---
 */
/// 음수 포함: 슬라이딩 윈도우는 안됨
/// 포인터가 뒤로 가야 함: 사용 불가
/// 단조성 없음: 사용 불가
/*:
 ---
 * 9. 에라토스테네스의 체
 ---
 */
/// 소수 판별의 기본 개념.
/// 1부터 N까지 중에서 소수만 빠르게 알고 싶을 때 사용.
/// 숫자 하나하나에 대해 2부터 자기 자신-1 까지 나눠보기.
///
/// 시간복잡도:
/// - 하나 판별: O(N)
/// - 전체: O(N^2) -> N이 커지면 바로 시간 초과
///
/// 핵심 아이디어:
/// 소수가 아닌 수는, 이미 더 작은 소수의 배수다.
///
/// k가 합성수라면 k = p x m의 형태. 여기서 p는 k보다 작은 소수
/// => 소수를 찾는것 보다 합성수를 먼저 지우는것에 집중
///
/// 사고 과정:
/// 1. 2부터 N까지 모두 "소수 후보"로 둔다.
/// 2. 가장 작은 소수 2를 선택
/// 3. 2의 배수(4, 6, 8, ...)는 전부 합성수 -> 제거
/// 4. 다음으로 남아 있는 수 중 가장 작은 수 (3)
/// 5. 3의 배수(6, 9, 12, ...) 제거
/// 6. 이 과정을 반복
///
/// 유희사항:
/// 1. 이미 지워진 수는 다시 볼 필요 없음
/// 2. 남아 있는 수만이 소수
///
/// 왜 √N까지만 보면 될까?
/// 어떤 합성수 : k = a x b
/// 둘 중 하나는 반드시 √k 이하
/// 따라서 -> √N 보다 큰 수에서 새롭게 지울 배수는 이미 이전 단계에서 지워짐
/// 그래서 -> 반복은 i x i <= N까지만 하면 충분
///
/// 시간복잡도:
/// 단순 소수 판별: O(N^2)
/// 에라토스테네스의 체: O(N log log N)
///
/// 기본 구현 예제
func sieve(_ n: Int) -> [Bool] {
    if n < 1 { return [] }
    
    var isPrime = Array(repeating: true, count: n + 1)
    if n >= 0 { isPrime[0] = false }
    if n >= 1 { isPrime[1] = false }
    
    let limit = Int(Double(n).squareRoot())
    
    for i in 2...limit {
        if isPrime[i] {
            var j = i * i
            while j <= n {
                isPrime[j] = false
                j += i
            }
        }
    }
    
    return isPrime
}
