
import Foundation

// MARK: - Dikstra
// 한 노드에서 다른 모든 노드까지 가는데 최소비용 (방향그래프)
//
// MSTExample.png 기준으로
// (1) -> (2) 으로 이동하는데 발생되는 비용: 2
// (1) -> (3) 으로 이동하는데 발생되는 비용: 3
// (1) -> (4) 으로 이동하는데 발생되는 비용: 7
// (1) -> (5) 으로 이동 불가
//
// 간선(edge): 인접 배열/리스트, 리스트가 편함, [INF, INF, INF]
// 거리 배열: 초기값 무한대로 설정
// 힙 시작점 추가
// 힙 시작점에서 출발하는 비용까지 추가 필요 (w: 0, n: 1) | 간선 [0, INF, INF]
//      1. 힙에서 현재 노드를 빼면서, 간선을 통해서 이동할 수 있는 노드들 중 비용이 더 작게 들면 거리 갱신 및 힙에 추가 | 간선 [0, 2, INF] -> 간선 [0, 2, 3]
//      2. 모든 노드들에 대해 힙 추가가 완료 되었다면 가장 비용이 작은 노드에 대해 다시 1번 진행. 단, 이미 있는 간선의 값을 업데이트 하는것. (변경X, 추가X)

// MARK: - MinHeap
// 시간 복잡도: 조회 O(1), 삽입 O(log N), 삭제 O(log N)

typealias AdjEdge = (w: Int, to: Int)
typealias HeapNode = (w: Int, node: Int)

struct MinHeap {
    private var a: [HeapNode] = []
    
    var isEmpty: Bool { a.isEmpty }

    mutating func push(_ x: HeapNode) {
        a.append(x)
        siftUp(from: a.count - 1)
    }

    mutating func pop() -> HeapNode? {
        guard !a.isEmpty else { return nil }
        if a.count == 1 { return a.removeLast() }

        a.swapAt(0, a.count - 1)
        let minVal = a.removeLast()
        siftDown(from: 0)
        return minVal
    }

    private mutating func siftUp(from index: Int) {
        var child = index
        while child > 0 {
            let parent = (child - 1) / 2
            if a[child].w < a[parent].w {
                a.swapAt(child, parent)
                child = parent
            } else {
                break
            }
        }
    }

    private mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = parent * 2 + 1
            let right = left + 1
            var candidate = parent

            if left < a.count && a[left].w < a[candidate].w {
                candidate = left
            }
            if right < a.count && a[right].w < a[candidate].w {
                candidate = right
            }

            if candidate == parent { break }

            a.swapAt(parent, candidate)
            parent = candidate
        }
    }
}

//
// https://www.acmicpc.net/problem/1753
//

/*
 1. 아이디어
    - 한점에서 다른 모든점의 최단경로 > 다익스트라
    - 모든 점 거리의 초기값을 무한대로 설정
    - 시작점 거리 0 설정, 힙에 추가
    - 힙에서 하나씩 빼면서 수행할것
        - 최신값인지 먼저 확인
        - 간선을 타고 간 비용이 더 작으면 갱신
 2. 시간복잡도
    - heap: 삽입 & 삭제 -> O(ElogV) (노드에 대한 삭제/삽입 이벤트가 간선갯수만큼 발생)
    - 간선 개수는 V(V - 1) /2 ~= V^2/2
    - ~= O(ElogV^2/2) ~= O(ElogV^2) ~= O(2ElogV) = O(ElogV)
 
    - 간선(E)의 최대 갯수는 300,000
    - 정점(V)의 최대 갯수는 20,000
    - E: 3*10^5
    - V: 2*10^4
    - logE = log(300_000) ~= log(2^20) ~= 20
    -> E x logE = 300_000 x 20 = 6_000_000 ~= 6*10^6 ~= 6e6
 3. 자료구조
    - 다익스트라를 사용하는 힙: [(비용: Int, 노드: Int)]
        비용 최댓값: 비용은 최대 10만큼 발생할 수 있으며, 모든 노드수에 대해 발생할 수 있음 = 10 * 2e4 = 2e5
        다음 노드 최댓값: 2e4
    - 거리배열: [Int]
        거리 최대값: 모든 정점을 거치는 경로의 최대 비용 = 2e5
    - 간선, 인접 리스트: [(비용: Int, 노드: Int)]
 */

// AdjEdge
func solution() {
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    let V = input[0]
    let E = input[1]
    
    let K = Int(readLine()!)!
    
    var edge = Array(repeating: [AdjEdge](), count: V+1)
    var dist = Array(repeating: Int.max, count: V+1)
    
    for _ in 0..<E {
        let input = readLine()!.split(separator: " ").compactMap { Int($0) }
        let u = input[0]
        let v = input[1]
        let w = input[2]
        
        edge[u].append(AdjEdge(w: w, to: v))
    }
    
    // 시작점 초기화
    dist[K] = 0
    var heap = MinHeap()
    heap.push(HeapNode(w: 0, node: K))
    
    while let (ew, ev) = heap.pop() {
        // 현재 노드의 비용이 기록된 비용과 동일하지않으면 넘어갈것
        if dist[ev] != ew { continue }
        
        // 인접리스트 확인
        for next_edge in edge[ev] {
            // 인접한 노드와 노드 간선의 비용
            let nw = next_edge.w
            let nv = next_edge.to
            
            // ew: 시작점에서 ev(현재노드)까지의 비용
            // nw: ev에서 nv(다음노드)까지 가는 비용
            // 기존에 기록된 다음 노드까지의 비용보다 (현재 비용 + 간선 비용)이 작으면 갱신
            if dist[nv] > ew + nw {
                dist[nv] = ew + nw
                heap.push(HeapNode(w: ew + nw, node: nv))
            }
        }
    }
    
    for i in 1..<V+1 {
        if dist[i] == .max { print("INF") }
        else { print(dist[i]) }
    }
}

solution()

// MARK: - Tips
// 한점에서 다른점으로 가는 최소비용
// 만약 모든점에서 모든점?
//      ElogV * V = VElogV 이걸 V^3로 풀수 있음.
