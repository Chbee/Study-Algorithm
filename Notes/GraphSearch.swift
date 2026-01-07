
import Foundation


/*
 BFS, DFS: 그래프 탐색의 종류.
 Breadth-first search, 너비 우선 탐색, 자기 자식 우선 탐색
 Depth-first search, DFS: 자식의 자식 우선 탐색
 
 GraphExample.png에서
 1. BFS 진행되는 방향
    1 -> 2 -> 5 -> 3 -> 4 -> 6
 2. DFS 진행되는 방향
    1 -> 2 -> 3 -> 4 -> 6 -> 5
 */


// MARK: 1. BFS
//
// - 접근 아이디어
// 시작점에 연결된 `Vertex` 찾기
// 찾은 Vertext를 Queue에 저장
// Queue의 가장 먼저 것 뽑아서 반복
//
// - 왜 BFS에서 Queue 사용해야하는가?
// 확인한 데이터(먼저 Input된 데이터)는 제거(Out) 되면서 다음으로 확인해야하는 자식이 Input되게 됨. = FirstInput FirstOut
//
// - 시간복잡도
// O(V + E)
//
// - 자료구조
// 검색할 그래프, 방문여부 확인, Queue
//
// https://www.acmicpc.net/problem/1926
//
// 1이 연속될 때 연속되는 1의 갯수(총합)을 구하는 문제
// 1. 아이디어
//  - 1이 나왔을 때 주변의 1을 검색 : BFS
//  - 2중 for문으로 1이 나올때 마다 방문이 되지 않았고, 값이 1이면 BFS 처리
//  - 1을 방문하면 그림갯수 +1, 최댓값 갱신
// 2. 시간복잡도
//  - V: nxm, E: Vx4
//  - O(V+E) = O(V+4V) = O(5V) = O(5mn) = 최댓값으로 O(5x500x500) = O(1_000_000)
// 3. 자료구조
//  - 그래프 전체 지도 : [[Int]]
//  - 방문 여부 : [[Bool]]
//  - Queue(BFS)
//
// --------------

func bfs_solution() {
    let inputSize = readLine()!

    var n, m: Int
    let input = inputSize.split(separator: " ").compactMap({ Int($0) })
    n = input[0]; m = input[1]

    var map = [[Int]]()
    for _ in 0..<n {
        map.append(readLine()!.split(separator: " ").compactMap { Int($0) })
    }

    let _chk = Array(repeating: false, count: m)
    var chk = Array(repeating: _chk, count: n)

    var cnt = 0
    var maxv = 0

    // 우, 하, 좌, 상
    let dy = [0,1,0,-1]
    let dx = [1,0,-1,0]

    func bfs(y: Int, x: Int) -> Int {
        var result = 1
        var head = 0
        var queue = [(Int, Int)]()
        queue.append((y, x))
        
        while head < queue.count {
            let value = queue[head]
            head += 1
            
            // 찾을 좌표를 기준으로 4방향에서 확인 시작
            for k in 0..<4 {
                let ny = value.0 + dy[k]
                let nx = value.1 + dx[k]
                // 전체 그래프 크기 넘어가는지 확인
                if (ny >= 0 && ny < n),
                   (nx >= 0 && nx < m) {
                    if (map[ny])[nx] == 1, (chk[ny])[nx] == false {
                        (chk[ny])[nx] = true
                        result += 1
                        queue.append((ny, nx))
                    }
                }
            }
        }
        return result
    }

    // y먼저 탐색
    for j in 0..<n {
        // 그다음 x 탐색
        for i in 0..<m {
            if (map[j])[i] == 1 && (chk[j])[i] == false {
                (chk[j])[i] = true
                // 전체 그림갯수 +1
                cnt += 1
                // BFS로 그림의 크기를 구하고
                maxv = max(maxv, bfs(y: j, x: i))
                // 최댓값 갱신
            }
        }
    }

    print(cnt)
    print(maxv)
}

//bfs_solution()

// MARK: 2. DFS
//
// - 접근 아이디어
// 재귀 함수(DFS 혹은 백트래킹), stack으로 가능
// 현재는 재귀로 구현
// 시작점에 연결된 Vertex 찾기
// 끝날 때 까지 연결된 Vertex를 계속해서 찾음
// 더이상 연결된 Vertex 없을 경우 다음 Vertext 찾음
//
// - 시간복잡도
// O(V + E)
//
// - 자료구조
// 검색할 그래프(2차원 배열), 방문여부 확인(2차원 배열, 재방문 금지)
//
// https://www.acmicpc.net/problem/2667
//
// 1이 연속될 때 연속되는 1의 갯수와 가지고 있는 갯수를 오름차순하여 출력
// 1. 아이디어
//  - 2중 for 문 중에, 값이 1이고 방문하지 않았으면 DFS
//  - DFS를 통해 찾은 값을 저장 후 정렬해서 출력
// 2. 시간복잡도
//  - V: n^2, E: 4N^2
//  - O(V+E) = O(n^2 + 4N^2) ~= O(N^2) ~= O(25^2) = 최댓값으로 O(625)
// 3. 자료구조
//  - 그래프 전체 지도 : [[Int]]
//  - 방문 여부 : [[Bool]]
//  - 결과값 : [Int]
//
// --------------

func solution_dfs() {
    let inputValue = readLine()!
    guard let input = Int(inputValue) else { return }
    
    let dy = [0,1,0,-1]
    let dx = [1,0,-1,0]
    
    var result = [Int]()
    var each = 0
    
    var map = [[Int]]()
    for _ in 0..<input {
        map.append(readLine()!.compactMap { Int(String($0)) })
    }
    
    let _chk = Array(repeating: false, count: input)
    var chk = Array(repeating: _chk, count: input)
    
    for j in 0..<input {
        for i in 0..<input {
            if (map[j])[i] == 1 && (chk[j])[i] == false {
                // 방문 체크 표시
                (chk[j])[i] = true
                each = 0 // 연산 시작할 때 마다 값 초기화
                // dfs 값 구하기
                dfs(y: j, x: i)
                // 크기를 결과 배열에 추가
                result.append(each)
            }
        }
    }
    
    func dfs(y: Int, x: Int) {
        each += 1
        // 먼저 각 노드에서 4방향으로 확인해야함.
        for k in 0..<4 {
            // 다음에 찾을것
            let ny = y + dy[k]
            let nx = x + dx[k]
            
            if (ny >= 0 && ny < input) && (nx >= 0 && nx < input) {
                if (map[ny])[nx] == 1 && (chk[ny])[nx] == false {
                    (chk[ny])[nx] = true
                    dfs(y: ny, x: nx) // 자식의 4방향 노드를 확인하러 가는것.
                }
            }
        }
    }
    
    result.sort()
    print(result.count)
    for value in result {
        print(value)
    }
}

solution_dfs()
