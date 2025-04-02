최초 작성 날짜 : 2025/03/31  
업데이트 날짜 : 2025/03/31  
공부 범위 : 05장      

---

# 정렬 알고리즘
특정 사물이 가진 특성을 기준으로 사물을 순서에 따라 재배치 하는것.
오름차순과 내림차순이 있다.

## Bucket Sort(버킷 정렬) 알고리즘
1. 데이터를 여러 개의 “버킷(bucket)”에 나눠서 넣고,  
2. 각 버킷을 정렬한 다음,  
3. 순서대로 꺼내 합치는 정렬 알고리즘.

#### 시간 복잡도  
1. 값의 분포가 고를경우 : O(n)
2. 값의 분포가 한 버킷에 몰릴경우 : O(nlogn)

#### Swift Bucket Sort
```swift
func bucketSort(_ arr: [Int]) {
    let bucketSize = 10
    let maxValue = arr.max()!
    let bucketCount = maxValue / bucketSize + 1 // buffer 두기
    var buckets = Array(repeating: [Int](), count: bucketCount)
}
```
먼저, bucketSize를 10개로 정하고 배열을 생성한다.  
배열은 input된 배열의 가장 큰 값을 정해진 버킷의 사이즈로 나누고 그 몫에 1를 더하여 정한다. (Buffer를 고려하기 위함)  
```swift
for num in arr {
    let index = num / bucketSize
    buckets[index].append(num)
}
```
입력 받은 배열을 모두 검색하여 bucket에 담는다.  
이때, index값이 비슷한 값들을 모아둔다.  
```swift
var sortedArray = [Int]()
for bucket in buckets {
    let sortedBucket = bucket.sorted()
    sortedArray.append(contentsOf: sortedBucket)
}
```
값이 있는 버킷이라면 오름차순으로 정렬하고 결과 배열에 삽입한다.  
```swift
let rawData = [29, 25, 3, 49, 9, 37, 21, 43]
bucketSort(rawData)
// [3, 9, 21, 37, 43, 49, 25, 29]
```

#### 개선사항
Swift에서 `sorted()`는 Timesort로 구현되어 있다고 한다. 때문에 O(nlogn)의 시간복잡도룰 보장한다고한다.  
이를 방지하기 위해 `sorted()`대신 직접 구현할 수도 있다.  
```swift
func insertionSort(_ arr: [Int]) -> [Int] {
    var result = arr
    for i in 0..<result.count {
        var j = i
        while j > 0 && result[j] < result[j - 1] {
            result.swapAt(j, j - 1)
            j -= 1
        }
    }
    return result
}

// 정렬부분 코드 교체
for bucket in buckets {
    let sortedBucket = insertionSort(bucket)
    result.append(contentsOf: sortedBucket)
}
```

#### 전체코드  
```swift
func bucketSort(_ arr: [Int]) {
    // 입력된 배열이 빈값이면 하위 로직 실행x
    guard !arr.isEmpty else { return }

    // 버킷 사이즈를 조금 더 줄여 값의 분포가 균등하게 이루어지도록 함
    let bucketSize = 5
    let maxValue = arr.max()!
    let bucketCount = maxValue / bucketSize + 1 // buffer 두기
    var buckets = Array(repeating: [Int](), count: bucketCount)
    
    // 1. 각 숫자를 적절한 버킷에 넣기
    for num in arr {
        let index = num / bucketSize
        buckets[index].append(num)
    }
    
    // 2. 각 버킷 정렬 후 하나로 합치기
    var sortedArray = [Int]()
    for bucket in buckets {
        let sortedBucket = insertionSort(bucket)
        sortedArray.append(contentsOf: sortedBucket)
    }
    
    print(sortedArray)
}

func insertionSort(_ arr: [Int]) -> [Int] {
    var result = arr
    for i in 0..<result.count {
        var j = i
        while j > 0 && result[j] < result[j - 1] {
            // 두 번째 인덱스 부터 이전 값과 비교하여 오름차순 정렬
            result.swapAt(j, j - 1)
            j -= 1
        }
    }
    return result
}
```

