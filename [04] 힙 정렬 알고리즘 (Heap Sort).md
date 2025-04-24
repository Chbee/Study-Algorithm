최초 작성 날짜 : 2025/04/24  
업데이트 날짜 : 2025/04/24  
공부 범위 : 05장      

---

## 힙 정렬
힙 정렬은 힙(Heap) 자료구조를 활용해 데이터를 정렬하는 알고리즘이다.  
힙은 완전 이진 트리의 일종이며, 최대 힙(MaxHeap) 또는 최소 힙(MinHeap)으로 구성할 수 있다.  
이 글에서는 내림차순 정렬을 위해 MaxHeap을 사용한다.

### 힙 정렬의 핵심 동작

1. 입력 배열을 MaxHeap으로 구성한다.
2. 가장 큰 값(루트)을 꺼내 정렬 배열에 넣는다.
3. 남은 값들로 다시 힙을 재구성한다.
4. 위 과정을 반복하면 정렬이 완료된다.

### 시간 복잡도
| 단계 | 복잡도 |
|------|--------|
| 힙 구성 | O(n) |
| 정렬 (n번 removeMax) | O(n log n) |
| 전체 | **O(n log n)** |

### Swift로 구현한 힙 정렬 (Heap Sort)

#### insert(_:)  
값을 힙의 말단에 추가한 뒤, 부모 노드와 비교하면서 위로 올라가 MaxHeap 조건을 만족시킨다.
```swift
mutating func insert(_ value: Int) {
    heap.append(value)
    siftUp(heap.count - 1)
}
```
#### removeMax()
루트 노드(가장 큰 값)를 꺼내고, 마지막 노드를 루트로 옮긴 뒤 힙을 재구성한다.
```swift
mutating func removeMax() -> Int? {
    guard !heap.isEmpty else { return nil }
    if heap.count == 1 {
        return heap.removeFirst()
    }

    let max = heap[0]
    heap[0] = heap.removeLast()
    siftDown(0)
    return max
}
```
#### siftUp(:)과 siftDown(:)
삽입 시 위로 정렬(sift up), 삭제 후 아래로 정렬(sift down) 역할을 한다.
```swift
private mutating func siftUp(_ index: Int) {
    var child = index
    var parent = (child - 1) / 2

    while child > 0 && heap[child] > heap[parent] {
        heap.swapAt(child, parent)
        child = parent
        parent = (child - 1) / 2
    }
}

private mutating func siftDown(_ index: Int) {
    var parent = index
    while true {
        let left = 2 * parent + 1
        let right = 2 * parent + 2
        var maxIndex = parent

        if left < heap.count && heap[left] > heap[maxIndex] {
            maxIndex = left
        }
        if right < heap.count && heap[right] > heap[maxIndex] {
            maxIndex = right
        }
        if maxIndex == parent { break }
        heap.swapAt(parent, maxIndex)
        parent = maxIndex
    }
}
```
#### heapSort(_:) - 힙 정렬 실행 함수
입력 배열을 MaxHeap으로 구성하고, 가장 큰 값을 하나씩 꺼내며 정렬한다.
```swift
func heapSort(_ array: [Int]) -> [Int] {
    var maxHeap = MaxHeap()
    array.forEach { maxHeap.insert($0) }

    var sorted: [Int] = []
    while let max = maxHeap.removeMax() {
        sorted.insert(max, at: 0) // 앞에 삽입해 오름차순 정렬
    }
    return sorted
}
```

```swift
let result = heapSort([3, 1, 6, 5, 2, 4])
```
위 코드에 대해 MaxHeap 정렬을 수행해보자  

아래 표는 입력값 `[3, 1, 6, 5, 2, 4]`를 MaxHeap에 삽입해가는 과정이다.  
MaxHeap은 **루트가 가장 큰 값을 가지는 트리 구조**를 유지하며, 내부 배열은 정렬 상태가 아님에 주의해야 한다.  

| 단계 | 설명                | 힙 상태             |
|------|---------------------|---------------------|
| 1    | 3 삽입              | [3]                |
| 2    | 1 삽입              | [3, 1]             |
| 3    | 6 삽입 → siftUp     | [6, 1, 3]          |
| 4    | 5 삽입 → siftUp     | [6, 5, 3, 1]       |
| 5    | 2 삽입              | [6, 5, 3, 1, 2]    |
| 6    | 4 삽입 → siftUp     | [6, 5, 4, 1, 2, 3] |

> MaxHeap의 배열 `[6, 5, 4, 1, 2, 3]`은 정렬된 결과가 아닌, **힙 구조의 상태**를 나타낸다.  
> 실제 정렬은 가장 큰 값을 꺼내는 `removeMax()`를 반복하면서 이루어진다.

---

### 힙 정렬 결과 (heapSort)

```swift
let result = heapSort([3, 1, 6, 5, 2, 4])
print("정렬 결과: \(result)")
// 출력: [1, 2, 3, 4, 5, 6]

