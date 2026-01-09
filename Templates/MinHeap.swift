import Foundation

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
