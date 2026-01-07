
import Foundation

// MARK: - Simulation
//
// 각 조건에 맞는 상황을 구현하는 문제
// 지도상에서 이동하면서 탐험 혹은 배열 안에서 이동하면서 탐험
// 구현력이 중요! (복잡도를 낮추는 방향으로 설계할것)
//
// https://www.acmicpc.net/problem/14503
//
// 왼쪽부터 탐색. 청소 안되어있으면 회전하고 전진.
// 왼쪽에 벽이거나 청소가 되어있으면 왼쪽으로 회전한 후 다시 왼쪽을 탐색
// 어느곳으로도 이동이 할 수 없으면 원래 방향에서 뒤로 한칸 후진 그다음 왼쪽부터 탐색
// 후진이 할 수 없으면 작동을 멈춤
//    =>  while문으로 계속 작동하게 하고, 특정 조건에 만족햇을 때 종료함
//
// 1. 아이디어
// - 특정 조건 만족하는한 계속 이동: while
// - 4방향 탐색 먼저 수행: 빈칸이 있을 경우 이동
// - 4방향 탐색 불가한 경우: 뒤로 한칸가서 탐색 반복 수행
// - 후진이 불가능한 경우: 작동 종료
// 2. 시간복잡도
// - while문 최대: N X M
// - 각 칸에서 4방향 연산 수행
// ~= O(NM) ~= 50^2 = 2500
// 3. 자료구조
// 전체지도: [[Int]]
// 내위치, 방향: (int, int), int
// 시간 복잡도를 낮추는 전략으로 2를 청소한곳으로 표기
// 전체 cnt(청소를 한 갯수): int
//
// -----
//

func solution() {
    var n, m: Int
    
    let input = readLine()!.split(separator: " ").compactMap { Int($0) }
    n = input[0]; m = input[1]
    
    var y, x, d: Int
    
    let direction = readLine()!.split(separator: " ").compactMap { Int($0) }
    y = direction[0]; x = direction[1]; d = direction[2]
    
    var map = [[Int]]()
    var cnt = 0
    
    for _ in 0..<n {
        let roomData = readLine()!.split(separator: " ").compactMap { Int($0) }
        if roomData.count == m {
            map.append(roomData)
        }
    }
    
    let dy = [-1,0,1,0]
    let dx = [0,1,0,-1]
    
    // 계속 청소시킴
    while true {
        if (map[y])[x] == 0 {
            (map[y])[x] = 2
            cnt += 1
        }
        var sw = false
        
        // 방향
        // 0: 북, 1: 동, 2: 남, 3: 서
        // (-1,0), (0,1), (1,0), (0,-1)
        // 왼쪽을 바라본다는 의미는 index값을 1개씩 줄여서 dy 혹은 dx에서 방향을 검색하는것과 동일
        for i in 1..<5 {
            // 다음 위치는 내가 바라보고 있는 곳에서 i 만큼 빼준 인덱스값을 바라보는것
            let nd = (d - i + 4) % 4
            let ny = y + dy[nd]
            let nx = x + dx[nd]
            
            if (ny >= 0 && ny < n) && (nx >= 0 && nx < m) {
                // 로봇청소기의 방향을 이동시킴
                if (map[ny])[nx] == 0 {
                    // 그 방향으로 회전한 다음 한 칸을 전진하고 1번부터 진행
                    d = nd
                    y = ny
                    x = nx
                    sw = true
                    break // 탐색 정지시키고 이동하고 완료.
                }
            }
        }
        
        // 네 방향 모두 이동이 불가능한 경우
        if sw == false {
            // 바라보는 방향을 유지하고 한칸 후진함
            // 후진 방향이 막혀있으면 작동을 멈춤
            let ny = y - dy[d]
            let nx = x - dx[d]
            
            if (ny >= 0 && ny < n) && (nx >= 0 && nx < m) {
                // 후진했을 때 벽이면
                if (map[ny])[nx] == 1 { break }
                else {
                    // 여기서 청소를 하는게 아니라 이동할 곳을 다시 탐색해야함
                    y = ny
                    x = nx
                }
            } else {
                // 맵 밖으로 이동이 불가하므로 청소 종료
                break
            }
        }
    }
    
    print(cnt)
}

solution()
