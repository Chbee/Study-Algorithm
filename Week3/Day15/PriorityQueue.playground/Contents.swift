import Foundation

//: ## 우선순위 큐
/*:
 ---
 * 1. 우선순위 큐 개념
 ---
 */
/// 일반적인 Queue는 FIFO이지만, 우선순위 Queue는 우선순위가 높은 원소가 먼저 나간다.
///     - 숫자가 큰 게 우선순이면 Max-Heap
///     - 숫자가 작은 게 우선순이면 Min-Heap
///     - 여러 조건이면 "비교 함수(Comparator)"로 정함

/*:
 ---
 * 2. 힙으로 구현하는 이유
 ---
 */
/// 방법 A. 정렬된 배열로 유지
///     - 삽입: 들어갈 위치 찾아서 원소 넣기 -> 최악 O(N)
///     - 삭제: 최댓값/최솟값 꺼내기, 맨 앞/뒤 꺼내기 -> O(1)
/// 방법 B. 힙
///     - 삽입: 트리 아래에 넣고 "위로 올리기" -> O(logN)
///     - 삭제: 루트 꺼내고 마지막을 루트로 올린 뒤 "아래로 내리기" -> O(logN)
///
/// 즉, 삽입 과 삭제를 빠르게 하려고 사용

/*:
 ---
 * 3. 핵심 연산과 시간 복잡도
 ---
 */
/// 원소 개수를 N이라 하면:
///     - push (삽입): O(logN)
///     - pop (최우선 원소 제거/반환): O(logN)
///     - peak (최우선 원소 보기만): O(1)
///     - isEmpty, count: O(1)
/// 왜 logN이냐?
///     -> 힙은 완전 이진 트리 구조기 때문에 높이가 대략 log2(N)이고,
///         원소를 위/아래로 올리고 내리는 작업이 트리 높이만큼 일어나기 때문

/*:
 ---
 * 4. Swift 구현 포인트
 ---
 */
/// 내부 저장소: [T] 배열
/// 인덱스 계산(0-based)
///     - 부모: parent(i) = (i - 1) / 2
///     - 왼쪽 자식: left(i) = 2*i + 1
///     - 오른쪽 자식: right(i) = 2*i + 2
/// 비교 기준: 클로저 주입
///     - sort: (T, T) -> Bool
///     - 예. sort(a, b) == true면 "a가 b보다 우선순위가 높음"
/*:
 ---
 * 5. 구현 스켈레톤
 ---
 */

/// 제네릭 Heap 구현
/// - 내부는 배열로 저장 (완전 이진 트리)
/// - `우선순위(a, b) == true`이면 a가 b보다 "더 우선"
struct Heap<T> {
    private var 저장소: [T] = []
    private let 우선순위: (T, T) -> Bool
    
    init(우선순위: @escaping (T, T) -> Bool) {
        self.우선순위 = 우선순위
    }
    
    var isEmpty: Bool { 저장소.isEmpty }
    var count: Int { 저장소.count }
    
    /// 최상단(루트) 원소 확인 (제거x)
    func 최상단() -> T? {
        return 저장소.first
    }
    
    /// 삽입
    mutating func push(_ 값: T) {
        저장소.append(값)
        siftUp(시작인덱스: 저장소.count - 1)
    }
    
    /// 최상단(루트) 제거 + 반환
    mutating func pop() -> T? {
        guard !저장소.isEmpty else { return nil }
        
        if 저장소.count == 1 {
            return 저장소.removeLast()
        }
        
        /// 루트 값을 변환할 값으로 저장
        let 반환값 = 저장소[0]
        
        /// 마지막 원소를 루트로 올리고
        저장소[0] = 저장소.removeLast()
        
        /// 아래로 내리며 힙 조건 복구
        siftDown(시작인덱스: 0)
        
        return 반환값
    }
    
    // MARK: - 인덱스 유틸
    
    private func 부모(_ i: Int) -> Int { (i - 1) / 2 }
    private func 왼자식(_ i: Int) -> Int { 2 * i + 1 }
    private func 오른자식(_ i: Int) -> Int { 2 * i + 2 }
    
    // MARK: - siftUp
    
    private mutating func siftUp(시작인덱스: Int) {
        var 자식 = 시작인덱스
        
        while 자식 > 0 {
            let 부모 = 부모(자식)
            
            // 자식이 부모보다 우선이면 스왑 (Min이면 더 작을수록 우선, Max면 더 클수록 우선)
            if 우선순위(저장소[자식], 저장소[부모]) {
                저장소.swapAt(자식, 부모)
                자식 = 부모
            } else {
                break
            }
        }
    }
    
    // MARK: - siftDown
    
    private mutating func siftDown(시작인덱스: Int) {
        var 부모 = 시작인덱스
        
        while true {
            let 왼 = 왼자식(부모)
            let 오른 = 오른자식(부모)
            var 후보 = 부모
            
            // 왼쪽 자식이 더 우선이면 후보 교체
            if 왼 < 저장소.count && 우선순위(저장소[왼], 저장소[후보]) {
                후보 = 왼
            }
            
            // 오른쪽 자식이 더 우선이면 후보 교체
            if 오른 < 저장소.count && 우선순위(저장소[오른], 저장소[후보]) {
                후보 = 오른
            }
            
            // 부모가 이미 가장 우선이면 멈춤
            if 후보 == 부모 { break }
            
            저장소.swapAt(부모, 후보)
            부모 = 후보
        }
    }
}


// MARK: - Min-Heap / Max-Heap의 편의 래퍼
struct MinHeap<T: Comparable> {
    private var heap = Heap<T>(우선순위: <)
    
    var isEmpty: Bool { heap.isEmpty }
    var count: Int { heap.count }
    
    func 최솟값() -> T? { heap.최상단() }
    
    mutating func push(_ 값: T) { heap.push(값) }
    mutating func pop() -> T? { heap.pop() }
}

struct MaxHeap<T: Comparable> {
    private var heap = Heap<T>(우선순위: >)
    
    var isEmpty: Bool { heap.isEmpty }
    var count: Int { heap.count }
    
    func 최댓값() -> T? { heap.최상단() }
    
    mutating func push(_ 값: T) { heap.push(값) }
    mutating func pop() -> T? { heap.pop() }
}


// MARK: - 간단 테스트

func test() {
    var 최소 = MinHeap<Int>()
    [5, 1, 9, 3, 7].forEach { 최소.push($0) }
    print("최소힙 최솟값:", 최소.최솟값() ?? -1) // 1
    while let v = 최소.pop() {
        print(v, terminator: " ") // 1 3 5 7 9
    }
    print()

    var 최대 = MaxHeap<Int>()
    [5, 1, 9, 3, 7].forEach { 최대.push($0) }
    print("최대힙 최댓값:", 최대.최댓값() ?? -1) // 9
    while let v = 최대.pop() {
        print(v, terminator: " ") // 9 7 5 3 1
    }
    print()
}

test()
