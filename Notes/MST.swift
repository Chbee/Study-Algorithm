import Foundation

// MARK: - MST
// Minimum Spanning Tree
//
// Spanning Tree: 모든 노드(Vertex)가 연결된 트리
// MST: 최소의 비용으로 모든 노드가 연결된 트리
//
// MSTExample.png 파일을 기준으로
// 1, 2, 3, 5 Edge만으로 연결을 시키면 최소로 연결을 할 수 있음
//
// 푸는 방법 : Kruskal / Prim
// Kruskal: 전체 간선 중 작은것 부터 연결
//      간선 비용 중 작은 것 부터 연결
//      1 -> (1, 5) 연결 -> 2 -> (1, 2) 연결 -> 3 -> (1, 3) 연결 -> 5 -> (2, 4) 연결
// Prim: 현재 연결된 트리에 이어진 간선 중 가장 작은것을 추가
//      (1)에 연결된 것 중 1이 가장 작으므로 1 연결
//      -> (5) 연결
//      -> (5)에 연결된 간선은 2, 3. 그 중 2가 가장 작음
//      -> (2) 연결
//      -> (2)에 연결된 간선은 3, 4, 5. 그 중 3이 가장 작음
//      -> (3) 연결
//      -> (3)에 연결된 간선은 5, 6. 그 중 5가 가장 작음
//      -> (4) 연결
//
// MARK: Heap
//
// 가장 작은 비용의 간선을 비교할때 사용
// 최소 / 최대 값을 빠르게 찾기 위해 사용
// 이진 트리 구조
// 처음에 저장할때부터 최대값 or 최소값 삽입
// MinHeap: 마지막 자식 노드에 새로운 값을 저장한 다음 부모 노드와 비교하면서 부모 노드가 자식 노드보다 작거나 같아지는 힙 속성을 만족할 때까지 위로 이동한다.
// MaxHeap: 마지막 자식 노드에 새로운 값을 저장한 다음 부모 노드와 비교하면서 부모 노드가 자식 노드보다 크거나 같아지는 힙 속성을 만족할 때까지 위로 이동한다.
// 시간 복잡도:
//      - 최소/최대 조회 O(1)
//      - 삽입 O(log N)
//      - 삭제 O(log N)
//
// MARK: Heap 핵심코드
// Prim/Dijkstra에 바로 쓰는 최소 기능 MinHeap

/// 그래프(인접 리스트)에 저장되는 "간선" 타입
/// - w: 간선 비용(가중치)
/// - to: 도착 정점
typealias AdjEdge = (w: Int, to: Int)

/// 우선순위 큐(힙)에 들어가는 "후보" 타입
/// - w: 현재 후보의 우선순위(Prim에서는 간선 비용)
/// - node: 다음으로 방문(또는 확정)할 정점
typealias HeapNode = (w: Int, node: Int)

/// MinHeap(우선순위 큐)
/// - 핵심 규칙: "부모의 w <= 자식의 w"가 항상 성립하도록 유지한다.
/// - 배열로 완전 이진 트리를 표현한다.
///   - parentIndex = (childIndex - 1) / 2
///   - leftChildIndex = parentIndex * 2 + 1
///   - rightChildIndex = leftChildIndex + 1
struct MinHeap {
    /// 힙을 저장하는 내부 배열 (완전 이진 트리 형태)
    private var a: [HeapNode] = []

    /// 힙이 비어있는지 확인 (while 루프 조건 등에 사용)
    var isEmpty: Bool { a.isEmpty }

    /// 힙에 원소를 추가한다.
    /// 1) 완전 이진 트리를 유지하기 위해 배열의 "맨 끝"에 먼저 append
    /// 2) 힙 속성이 깨졌다면(small이 아래에 있으면) 위로 끌어올리기(siftUp)
    mutating func push(_ x: HeapNode) {
        a.append(x)                      // 1) 마지막 위치(가장 아래, 오른쪽)에 삽입
        siftUp(from: a.count - 1)        // 2) 부모와 비교하며 위로 올라가 힙 규칙 복구
    }

    /// 힙에서 최소 w 값을 가진 원소(루트)를 꺼낸다.
    /// 1) 루트(0번 인덱스)가 항상 최소값
    /// 2) 루트를 꺼내면 트리가 깨지므로 마지막 원소를 루트로 올린 뒤
    /// 3) 아래로 내려가며(siftDown) 힙 속성을 복구한다.
    mutating func pop() -> HeapNode? {
        guard !a.isEmpty else { return nil } // 비어있으면 꺼낼 값 없음
        if a.count == 1 { return a.removeLast() } // 원소 1개면 그냥 제거 후 반환

        a.swapAt(0, a.count - 1)         // 루트 <-> 마지막 원소 교환 (루트를 끝으로 보냄)
        let minVal = a.removeLast()      // 끝(원래 루트였던 값)을 제거하여 반환값으로 저장
        siftDown(from: 0)                // 새 루트가 된 값이 제자리를 찾도록 아래로 내려보냄
        return minVal
    }

    /// 삽입 후 위로 끌어올리는 과정(sift up / heapify up)
    /// - child가 parent보다 w가 작으면 규칙 위반이므로 swap하고 계속 위로 이동
    private mutating func siftUp(from index: Int) {
        var child = index                        // 방금 삽입된 위치(자식)부터 시작
        while child > 0 {                        // 루트(0)까지 갈 수 있으니 0보다 큰 동안 반복
            let parent = (child - 1) / 2         // 완전 이진 트리에서 부모 인덱스 계산

            // MinHeap 규칙: parent.w <= child.w
            // child가 더 작다면 규칙 위반이므로 부모와 자리 교체
            if a[child].w < a[parent].w {
                a.swapAt(child, parent)          // child를 위로 올려(더 작은 값이 위로)
                child = parent                   // 이제 비교 대상(child)가 한 단계 위로 이동
            } else {
                break                            // 규칙을 만족하면 더 이상 위로 갈 필요 없음
            }
        }
    }

    /// 삭제(pop) 후 아래로 내려보내는 과정(sift down / heapify down)
    /// - parent가 자식들보다 w가 크면 규칙 위반이므로
    ///   더 작은 자식(candidate)과 swap하며 내려간다.
    private mutating func siftDown(from index: Int) {
        var parent = index                       // 루트(또는 내려보낼 시작 위치)
        while true {
            let left = parent * 2 + 1            // 왼쪽 자식 인덱스
            let right = left + 1                 // 오른쪽 자식 인덱스
            var candidate = parent               // 현재 parent가 적절한 위치인지 후보를 잡아둠

            // 왼쪽 자식이 존재하고, 왼쪽이 더 작으면 candidate를 왼쪽으로
            if left < a.count && a[left].w < a[candidate].w {
                candidate = left
            }
            // 오른쪽 자식이 존재하고, 오른쪽이 더 작으면 candidate를 오른쪽으로
            if right < a.count && a[right].w < a[candidate].w {
                candidate = right
            }

            // candidate가 parent 그대로라면 부모가 두 자식보다 작거나 같다는 뜻 → 규칙 만족
            if candidate == parent { break }

            a.swapAt(parent, candidate)          // 더 작은 자식을 위로 올려 규칙을 복구
            parent = candidate                   // 내려간 위치에서 다시 자식들과 비교 반복
        }
    }
}

func primMSTCost(start: Int, graph: [[AdjEdge]]) -> Int {
    var chk = Array(repeating: false, count: graph.count)
    var heap = MinHeap()
    var rs = 0
    
    heap.push(HeapNode(w: 0, node: start))
    
    while let (w, nextNode) = heap.pop() {
        // 방문했던거면 더이상 진행 안함
        if chk[nextNode] { continue }
        
        chk[nextNode] = true
        
        // 비용 더해줌
        rs += w
        
        for e in graph[nextNode] {
            // e.to(도착 정점)이 아직 MST에 포함되지 않았다면 후보로 추가
            if !chk[e.to] {
                heap.push(HeapNode(w: e.w, node: e.to))
            }
        }
    }
    
    return rs
}

//
// https://www.acmicpc.net/problem/1197
//
/*
 1. 아이디어
    - A정점과 B정점이 C의 비용으로 연결되어있음
    - 간선을 인접 리스트 형태로 저장 (어디에서 어디까지에 대한 비용정보) 예. 1번 간선[(w: 비용, note: 인접한 노드)]
    - 시작점부터 힙에 넣기
    - 힙이 빌때까지,
        해당 노드 방문 안한곳일 경우
        방문 체크, 비용 추가, 연결된 간선 새롭게 추가
 2. 시간복잡도
    MST: O(ElogE)
    Edge 리스트에 저장: O(E)
    Heap 내부 모든 Edge에 연결도니 간선 확인 O(E + E) ~= O(E)
    모든 간선 힙에 삽입: O(ElogE)
    = O(E + 2E + ElogE) = O(3E + ElogE) = O(E(3+logE)) ~= O(ElogE)
 3. 자료구조
    - Edge 저장 리스트 = [(Int, Int)] = [(비용, 다음 노드)]
        무게 최대: -1_000_000 ~ 1_000_000
        정점 번호 최대: 10_000
    - 정점 방문: [Bool]
    - MST 비용: int (-2,147,483,648 ~ 2,147,483,647)
    - 힙: [(Int, Int)]
 */
// ====================
//

func solution() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let V = input[0]
    let E = input[1]
    
    var edge = Array(repeating: [AdjEdge](), count: V+1)
    var chk = Array(repeating: false, count: V+1)
    var rs: Int = 0
    
    for _ in 0..<E {
        let input = readLine()!.split(separator: " ").compactMap { Int($0) }
        let a = input[0]
        let b = input[1]
        let c = input[2]
        
        edge[a].append(AdjEdge(w: c, to: b))
        edge[b].append(AdjEdge(w: c, to: a))
    }
    
    var heap = MinHeap()
    heap.push(HeapNode(w: 0, node: 1))
    
    while let (w, each_node) = heap.pop() {
        if chk[each_node] { continue }
        
        chk[each_node] = true
        
        rs += w
        
        for next_edge in edge[each_node] {
            if chk[next_edge.to] == false {
                heap.push(HeapNode(w: next_edge.w, node: next_edge.to))
            }
        }
    }
        
    print(rs)
}

solution()

// MARK: - TIPs
// 모든 노드가 연결되도록 한다거나
// 이미 연결된 노드를 최소 비용으로 줄이기
