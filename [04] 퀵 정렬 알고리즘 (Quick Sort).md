최초 작성 날짜 : 2025/04/21  
업데이트 날짜 : 2025/04/23  
공부 범위 : 05장      

---

## 퀵 정렬 (Quick Sort)
퀵 정렬은 **분할 정복(Divide and Conquer)** 방식의 정렬 알고리즘이다.  
배열에서 하나의 값을 **피벗(Pivot)** 으로 선택하고,  
이 값을 기준으로 **작은 값은 왼쪽**, **큰 값은 오른쪽**으로 나눈 다음  
각각을 다시 정렬하는 방식으로 작동한다.

### 동작 방식

1. 배열에서 임의의 피벗을 선택한다.
2. 피벗보다 작은 값은 왼쪽, 큰 값은 오른쪽으로 분할한다.
3. 분할된 각 부분 배열에 대해 같은 방식으로 퀵 정렬을 재귀적으로 적용한다.
4. 더 이상 분할이 불가능할 때까지 반복하면 전체 배열이 정렬된다.

### 시간 복잡도
- 평균: O(n log n)  
- 최악: O(n²) (이미 정렬된 경우 등)

---  

### Swift로 구현한 퀵 정렬 (Quick Sort)
```swift
func quickSort(_ arr: [Int]) {
    let resultArray = _quickSort(arr)
    print("resultArray : \(resultArray)")
}

private func _quickSort(_ arr: [Int]) -> [Int] {
    guard arr.count > 1 else {
        print("resultArray : \(arr)")
        return arr
    }
    
//    배열의 가운데 인덱스를 피벗으로 선택
//    pivot은 인덱스이고, 실제 값은 arr[pivot]
    let pivotValue = arr[arr.count / 2]
    
//    lesserArray: 피벗보다 작은 값들
//    greaterArray: 피벗보다 큰 값들
//    same: 피벗과 같은 값의 개수
    var lesserArray = [Int]()
    var greaterArray = [Int]()
    var equalCount: Int = 0
    
//    배열을 순회하며 값을 분리:
//    피벗보다 큰 값은 greaterArray에 추가
//    피벗보다 작은 값은 lesserArray에 추가
//    피벗과 같은 값은 same을 1씩 증가시킵니다
//    👉 피벗값이 여러 번 등장할 경우를 고려한 방식
    for number in arr {
        if pivotValue < number {
            greaterArray.append(number)
        } else if pivotValue > number {
            lesserArray.append(number)
        } else {
            equalCount += 1
        }
    }
//    피벗보다 작은 값들을 다시 _quickSort로 재귀 호출하여 정렬
    lesserArray = _quickSort(lesserArray)
    
//    피벗보다 큰 값들도 다시 재귀적으로 정렬
    greaterArray = _quickSort(greaterArray)
    
//    정렬된 lesserArray, 피벗값들, greaterArray를 순서대로 합쳐 최종 결과 생성
    return lesserArray + Array(repeating: pivotValue, count: equalCount) + greaterArray
}
```
```swift
let rawData = [30, 50, 7, 40, 88, 15, 44, 55, 22, 33, 77, 99, 11, 66, 1, 85]
```
이 데이터를 정렬해보자.

### 첫 번째 분할 (pivot: 33)
중앙값 33을 피벗(pivot) 으로 선택한다.
배열을 세 그룹으로 나눈다:
```markdown
less: [30, 7, 15, 22, 11, 1]
equal: [33]
greater: [50, 40, 88, 44, 55, 77, 99, 66, 85]
```
```swift
[30, 7, 15, 22, 11, 1] + [33] + [50, 40, 88, 44, 55, 77, 99, 66, 85]
```

이제 왼쪽부터 찬찬히 정렬해보자.
#### 첫번째. 왼쪽 그룹 정렬 (pivot: 15)
```markdown
배열: [30, 7, 15, 22, 11, 1]
피벗: 15

less: [7, 11, 1]
equal: [15]
greater: [30, 22]
```
```swift
[7, 11, 1] + [15] + [30, 22]
```

#### 두번째. 왼쪽의 왼쪽 (pivot: 11)
```markdown
배열: [7, 11, 1]
피벗: 11

less: [7, 1]
equal: [11]
greater: []
```
```swift
[7, 1] + [11]
```

#### `[7, 1]` 정렬 (pivot: 1)
```markdown
less: []
equal: [1]
greater: [7]
```
```swift
[1] + [7]
```

#### 오른쪽 `[30, 22]` 정렬 (pivot: 22)
```markdown
less: []
equal: [22]
greater: [30]
```
```swift
➡️ 결과: [22, 30]
```

#### 왼쪽 정렬 완료
```swift
[1, 7, 11, 15, 22, 30]
```

이제 나머지, 오른쪽을 정렬해보자.
#### 첫번째. `[50, 40, 88, 44, 55, 77, 99, 66, 85]` 정렬 (pivot: 55)
```markdown
less: [50, 40, 44]
equal: [55]
greater: [88, 77, 99, 66, 85]
```
```swift
[50, 40, 44] + [55] + [88, 77, 99, 66, 85]
```

#### 두번째. `[50, 40, 44]` 정렬 (pivot: 40)
```markdown
less: []
equal: [40]
greater: [50, 44]
```

#### 세번째. `[50, 44]` 정렬 (pivot: 44)
```markdown
less: []
equal: [44]
greater: [50]
```
```swift
결과: [40, 44, 50]
```

#### 마지막. `[88, 77, 99, 66, 85]` 정렬 (pivot: 99)
```markdown
less: [88, 77, 66, 85]
equal: [99]
greater: []
```

##### `[88, 77, 66, 85]` 정렬 (pivot: 77)
```markdown
less: [66]
equal: [77]
greater: [88, 85]
```

##### `[88, 85]` (pivot: 85)
```markdown
less: []
equal: [85]
greater: [88]
```
```swift
결과: [66, 77, 85, 88]
```

#### 오른쪽 정렬 완료
```swift
[40, 44, 50] + [55] + [66, 77, 85, 88, 99]
```

### 최종 정렬된 배열
```swift
[1, 7, 11, 15, 22, 30] + [33] + [40, 44, 50, 55, 66, 77, 85, 88, 99]
-> [1, 7, 11, 15, 22, 30, 33, 40, 44, 50, 55, 66, 77, 85, 88, 99]
```
