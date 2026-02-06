import Foundation

//: ## 유니온 파인드 (Disjoint Set Union, DSU)
/*:
 ---
 * 1. 개념 정리
 ---
 */
/// - 원소들이 여러 "그룹(집합)"으로 나뉘어 있을 때, 다음 두 가지를 빠르게 처리하는 자료 구조
///     - find(x): x가 속한 그룹의 "대표(루트)"를 찾는 것
///     - union(a, b): a가 속한 그룹과 b가 속한 그룹을 "합치는 것"
/// - 대표(루트)란?
///     : 각 그룹은 트리로 표현, 트리의 루트 노드가 그 그룹의 대표 역할을 함
///        > 같은 그룹이면 find 결과(루트)가 동일
///        > 다른 그룹이면 find 결과가 다름
/*:
 ---
 * 2. 기본 구현 뼈대 (parent 배열)
 ---
 */
/// 각 원소 i의 "부모"를 parent[i]에 저장
/// 처음에는 모두 자기 자신이 대표: parent[i] = i
/// find(i)는 부모를 타고 올라가 루트(대표)를 찾음
/*:
 ---
 * 3. 경로 압축 (Path Compression)
 ---
 */
/// - find(x)를 할 때, 루트를 찾으려고 위로 올라감.
/// - 그 다음부터는 더 빨리 찾도록 올라가는 경로에 있는 노드들이 바로 루트를 가리키게 바꿔버리는 기법
/// 효과:
///     - 반복적으로 find를 많이 하면 할수록 트리가 납작해짐
///     - 실전에서는 거의 상수 시간처럼 빨라짐

/*:
 ---
 * 4. union by rank / union by size
 ---
 */
/// 1. union by rank
///     - rank는 "대략적인 높이"에 대한 힌트 값
///     - 낮은 rank 트리를 높은 rank 트리에 붙임
///     - rank가 같을 때만 새 루트의 rank를 +1
/// 2. union by size
///     - size는 "트리에 포함된 원소 수"
///     - 작은 size 트리를 큰 size 트리에 붙임
///     - 합친 뒤 size 갱신
/*:
 ---
 * 5. 구현 스켈레톤
 ---
 */
// MARK: - Union Find
struct UnionFind {
    private var parent: [Int]
    private var size: [Int]
    
    init(_ n: Int) {
        parent = Array(0..<n)
        size = Array(repeating: 1, count: n)
    }
    
    mutating func find(_ x: Int) -> Int {
        if parent[x] == x { return x }
        parent[x] = find(parent[x])
        return parent[x]
    }
    
    mutating func union(_ a: Int, _ b: Int) -> Bool {
        var ra = find(a)
        var rb = find(b)
        if ra == rb { return false }
        
        if size[ra] < size[rb] {
            swap(&ra, &rb)
        }
        
        parent[rb] = ra
        size[ra] += size[rb]
        
        return true
    }
    
    mutating func isSameSet(_ a: Int, _ b: Int) -> Bool {
        return find(a) == find(b)
    }
    
    mutating func setSize(of x: Int) -> Int {
        return size[find(x)]
    }
}

// 사용 예시
var uf = UnionFind(10)
uf.union(1, 2)
uf.union(2, 3)

print(uf.isSameSet(1, 3)) // true
print(uf.isSameSet(1, 4)) // false
print(uf.setSize(of: 2)) // 3


// MARK: - Path Compression + Union by rank
struct UnionFindRank {
    private var parent: [Int]
    private var rank: [Int]
    
    init(_ n: Int) {
        parent = Array(0..<n)
        rank = Array(repeating: 0, count: n)
    }
    
    mutating func find(_ x: Int) -> Int {
        if parent[x] == x { return x }
        parent[x] = find(parent[x])
        return parent[x]
    }
    
    mutating func union(_ a: Int, _ b: Int) -> Bool {
        var ra = find(a)
        var rb = find(b)
        
        if ra == rb { return false }
        
        if rank[ra] < rank[rb] {
            swap(&ra, &rb)
        }
        parent[rb] = ra
        
        if rank[ra] == rank[rb] {
            rank[ra] += 1
        }
        
        return true
    }
}

// MARK: - 1-based 래퍼
struct UnionFind1Based {
    private var uf: UnionFind

    /// n개의 노드를 1...n으로 사용
    init(_ n: Int) {
        uf = UnionFind(n + 1) // 0은 더미
    }

    mutating func find(_ x: Int) -> Int {
        return uf.find(x)
    }

    mutating func union(_ a: Int, _ b: Int) -> Bool {
        return uf.union(a, b)
    }

    mutating func isSameSet(_ a: Int, _ b: Int) -> Bool {
        return uf.isSameSet(a, b)
    }

    mutating func setSize(of x: Int) -> Int {
        return uf.setSize(of: x)
    }
}
/*:
 ---
 * 6. 시간복잡도
 ---
 */
/// 경로 압축 + union by rank/size
/// m번의 연산 : O(m a(n)) ~= O(M)
///     a(n)?
///       - "아커만 역함수"
///         우주에 있는 모든 컴퓨터로 처리 가능한 n에 대해 5를 넘지 않는 함수
///         👉 사실상 O(1)

/*:
 ---
 * 7. union예시
 ---
 */
/// 예시 상황 (BOJ-1043 스타일)
/// 사람 1~6, 진실을 아는 사람: [1]
/// 파티:
///   - P1: [1, 2]
///   - P2: [3, 4]
///   - P3: [2, 3]
///
/// 파티 내부 union:
///   P1 -> union(1, 2)
///   P2 -> union(3, 4)
///   P3 -> union(2, 3)  // 이 순간 1-2-3-4가 모두 연결됨
///
/// 따라서 truthRoot == find(1)와 같은 집합인 파티는 거짓말 불가

var ufExample = UnionFind(7) // 0은 사용 안 함

// 파티 union
ufExample.union(1, 2)
ufExample.union(3, 4)
ufExample.union(2, 3)

let truthRoot = ufExample.find(1)

// 각 파티 대표만 비교해도 됨 (이미 같은 파티 사람들은 연결됨)
let partyReps = [1, 3, 2] // P1의 대표, P2의 대표, P3의 대표 (아무나 한 명)

for rep in partyReps {
    let canLie = ufExample.find(rep) != truthRoot
    print("party rep \(rep): canLie = \(canLie)")
}
