최초 작성 날짜 : 2025/04/21  
업데이트 날짜 : 2025/04/21  
공부 범위 : 05장      

---

## 병합 정렬
데이터를 분할한 다음 각자 계산하고 나중에 합쳐서 정렬하는 알고리즘.  
"분할 → 정복 → 병합"의 구조를 가지고 있다.  

### 말로 써보는 병합 정렬 알고리즘
1. 작은 수에서 큰 수로 정렬한다고 가정
2. 정렬할 데이터를 더 이상 나눌 수 없을 때까지 2등분
3. 잘게 나뉜 조각들을 2개씩 병합하며 정렬
4. 모든 데이터가 하나로 병합될 때까지 반복

즉, **"작게 나눈 뒤, 정렬하며 다시 합친다"**는 구조  
말로만 적으면 무슨 말인지 이해가 잘 안간다.  
코드로 구현을 해보고 한줄한줄 보며 이해해보자.  

### 시간 복잡도
: O(nlogn)  
→ n개의 데이터를 log n 단계로 나눠서 병합하고, 각 단계에서 n번의 비교를 수행하므로 전체 시간 복잡도는 O(nlogn)이다.  
→ 최선, 평균, 최악의 경우 모두 O(nlogn)을 보장

### Swift로 구현한 병합 정렬 (Merge Sort)
```swift
func mergeSort(_ arr: [Int]) -> [Int] {
    // 배열의 크기가 1 이하이면 정렬된 상태
    guard arr.count > 1 else { return arr }
    
    let middleIndex = arr.count / 2
    let leftArray = mergeSort(Array(arr[0..<middleIndex]))
    let rightArray = mergeSort(Array(arr[middleIndex..<arr.count]))
    
    return merge(leftArray, rightArray)
}

// 병합 함수 정의
func merge(_ left: [Int], _ right: [Int]) -> [Int] {
    var merged: [Int] = []
    var leftIndex = 0
    var rightIndex = 0

    // 두 배열을 비교하면서 정렬된 형태로 병합
    while leftIndex < left.count && rightIndex < right.count {
        if left[leftIndex] < right[rightIndex] {
            merged.append(left[leftIndex])
            leftIndex += 1
        } else {
            merged.append(right[rightIndex])
            rightIndex += 1
        }
    }

    // 남은 요소들 추가
    while leftIndex < left.count {
        merged.append(left[leftIndex])
        leftIndex += 1
    }

    while rightIndex < right.count {
        merged.append(right[rightIndex])
        rightIndex += 1
    }

    return merged
}
```

먼저 `merge`함수 부터 살펴보자  

#### `func merge(_:_:)`
```swift
// 결과를 담을 배열
var merged: [Int] = []
// left 배열에서 비교할 요소
var leftIndex = 0
// right 배열에서 비교할 요소
var rightIndex = 0
```
→ merged는 결과를 담을 배열이고, 각 left와 right 배열의 값을 비교하기 위해 leftIndex, rightIndex를 사용한다.  

```swift
while leftIndex < left.count && rightIndex < right.count {
  if left[leftIndex] < right[rightIndex] {
    merged.append(left[leftIndex])
    leftIndex += 1
  } else {
    merged.append(right[rightIndex])
    rightIndex += 1
  }
}
```
→ 두 배열 모두 비교할 요소가 남아 있을 때까지 반복  
→ 더 작은 값을 merged 배열에 추가하고, 해당 배열의 인덱스를 하나 증가  

```swift
// 남은 요소들 추가
while leftIndex < left.count {
  merged.append(left[leftIndex])
  leftIndex += 1
}

while rightIndex < right.count {
  merged.append(right[rightIndex])
  rightIndex += 1
}
```
→ 한 쪽 배열의 모든 요소를 다 병합했더라도, 다른 쪽에 남은 요소가 있을 수 있으므로 남은 값들을 merged에 추가  

#### 직접 배열을 나누어 보아요
```swift
[38, 27, 43, 3, 9, 82, 10]
```

##### 📌 1단계: 배열 분할
```swift
[38, 27, 43, 3, 9, 82, 10]
→ [38, 27, 43] [3, 9, 82, 10]
→ [38] [27, 43] [3, 9] [82, 10]
→ [38] [27] [43] / [3] [9] [82] [10]
```

##### 📌 2단계: 병합하면서 정렬
**왼쪽 그룹부터 정렬하며 병합:**
```swift
[27] + [43] → [27, 43]
[38] + [27, 43] → [27, 38, 43]
```
**오른쪽 그룹도 같은 방식으로 정렬 병합:**
```swift
[3] + [9] → [3, 9]
[82] + [10] → [10, 82]
[3, 9] + [10, 82] → [3, 9, 10, 82]
```

##### 📌 3단계: 최종 병합
```swift
[27, 38, 43] + [3, 9, 10, 82]
→ 비교하면서 정렬된 형태로 병합
→ [3, 9, 10, 27, 38, 43, 82]
```
##### ✅ 최종 결과
`[3, 9, 10, 27, 38, 43, 82]`
