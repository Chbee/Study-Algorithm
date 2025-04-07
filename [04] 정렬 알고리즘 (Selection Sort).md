최초 작성 날짜 : 2025/04/07  
업데이트 날짜 : 2025/04/07  
공부 범위 : 05장      

---

## 선택 정렬
정렬되지 않은 배열에서 가장 작은(또는 큰) 값을 찾아서 맨 앞의 요소와 교환하는 방식으로 동작  
총 n-1번 반복하면서 매번 가장 작은 값을 선택해서 정렬 영역으로 이동한다.  

### 시간 복잡도
O(n^2)  
: 두 개의 중첩문을 사용하고, n-1번의 루프 x n-i 번의 내부 비교가 발생한다.

### Swift로 구현한 선택 정렬 (Selection Sort)
```swift
func selectionSort(_ arr: [Int]) {
    if arr.isEmpty { print("Arr Is Empty"); return }
    
    var copyArray = arr
    var min = 0
    for i in 0..<copyArray.count-1 {
        min = i
        for j in i+1..<copyArray.count {
            if copyArray[j] < copyArray[min] {
                min = j
            }
        }
        copyArray.swapAt(i, min)
    }
    print("resultArray ", copyArray)
}
```

```swift
let rawData = [5, 2, 8, 6, 1, 9, 3, 7]
```
이 데이터를 정렬해보자.  

### i = 0
`copyArray[0]`은 5이다.
`j`는 1부터 시작하고, 마지막 인덱스까지 탐색을 진행한다.
##### 첫번째 교환 발생
`j`가 1일 때, `arr[1]`값은 2이므로 우선 교환할 index값을 변경해준다.
##### 두번째 교환 발생
`j`가 4일때, `arr[4]`값은 1이므로 교환할 index값을 4로 변경해준다.
##### 교환 실행
1이 가장 작은 수 이므로, `copyArray[0]`와 위치 교환해준다.
`[1, 2, 8, 6, 5, 9, 3, 7]`

### i = 1
`copyArray[1]`은 2이다.
`j`는 2부터 시작하고, 마지막 인덱스까지 탐색을 진행한다.
##### 교환 실행
2가 이후 인덱스들과 비교했지만 더 작은 값이 없었기 때문에, 선택된 인덱스(min)는 그대로이고 교환은 일어나지 않는다.
`[1, 2, 8, 6, 5, 9, 3, 7]`

### i = 2
`copyArray[2]`는 8이다.
`j`는 3부터 시작하고, 마지막 인덱스까지 탐색을 진행한다.
##### 첫번째 교환 발생
`j`가 3일 때, `arr[3]`값은 6이므로 우선 교환할 index값을 변경해준다.
##### 두번째 교환 발생
`j`가 4일때, `arr[4]`값은 5이므로 교환할 index값을 4로 변경해준다.
##### 세번째 교환 발생
`j`가 6일때, `arr[6]`값은 3이므로 교환할 index값을 6으로 변경해준다.
##### 교환 실행
3이 가장 작은 수 이므로, `copyArray[2]`와 위치 교환해준다.
`[1, 2, 3, 6, 5, 9, 8, 7]`

### i = 3
`copyArray[3]`는 6이다.
`j`는 4부터 시작하고, 마지막 인덱스까지 탐색을 진행한다.
##### 첫번째 교환 발생
`j`가 4일 때, `arr[4]`값은 5이므로 우선 교환할 index값을 변경해준다.
##### 교환 실행
5가 가장 작은 수 이므로, `copyArray[3]`과 위치 교환해준다.
`[1, 2, 3, 5, 6, 9, 8, 7]`

### i = 4
`copyArray[4]`는 6이다.
`j`는 5부터 시작하고, 마지막 인덱스까지 탐색을 진행한다.
##### 교환 실행
현재 값이 가장 작은값이므로 비교는 실행되지 않는다.
다만, 현재 로직 기준으로 교체 인덱스가 동일할때에도 교환을 진행되지만 실제로 값이 변경되지는 않는다.
`[1, 2, 3, 5, 6, 9, 8, 7]`

### i = 5
`copyArray[5]`는 9이다.
`j`는 6부터 시작하고, 마지막 인덱스까지 탐색을 진행한다.
##### 첫번째 교환 발생
`j`가 6일 때, `arr[6]`값은 8이므로 우선 교환할 index값을 변경해준다.
##### 두번째 교환 발생
`j`가 7일때, `arr[7]`값은 7이므로 교환할 index값을 7로 변경해준다.
##### 교환 실행
7이 가장 작은 수 이므로, `copyArray[5]`과 위치 교환해준다.
`[1, 2, 3, 5, 6, 7, 8, 9]`

### i = 6 과 i = 7
이후 인덱스를 검색해도 현재 값이 가장 작은 값이므로 교환이 일어나지 않고 그대로 스킵된다.

결과값 : [1, 2, 3, 5, 6, 7, 8, 9]

### Swift로 구현한 선택 정렬 (Selection Sort) - 불필요 연산 제거
```swift
func selectionSort(_ arr: [Int]) {
    if arr.isEmpty { print("Arr Is Empty"); return }
    
    var copyArray = arr
    var min = 0
    for i in 0..<copyArray.count-1 {
        min = i
        for j in i+1..<copyArray.count {
            if copyArray[j] < copyArray[min] {
                min = j
            }
        }
        // 실제 index값이 변경되었을 때에만 동작되도록
        if min != i {
            copyArray.swapAt(i, min)
        }
    }
    print("resultArray ", copyArray)
}
```
