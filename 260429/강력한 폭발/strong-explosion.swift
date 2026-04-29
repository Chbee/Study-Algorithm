import Foundation

let n = Int(readLine()!)!
var grid = [[Int]]()

for _ in 0..<n {
    let row = readLine()!.split(separator: " ").map { Int($0)! }
    grid.append(row)
}

// 1일때는 x고정 모든 y
// 2일때는 상 하 좌 우
// 3일때는 상좌 상우 하좌 하우

// 1, 2, 3 중 적절히 선택해 최대 파괴 지역의 수 찾기

struct Point: Hashable {
    let x: Int
    let y: Int
}

var maxV = 0

let bombs = grid.enumerated().flatMap { y, row in
    row.enumerated().compactMap { x, v in v == 1 ? Point(x: x, y: y) : nil }
}

func find(_ idx: Int, _ rs: [Point]) {
    if idx == bombs.count { maxV = max(maxV, Set(rs).count); return }

    let p = bombs[idx]
    find(idx + 1, rs + bomb_line(p.y, p.x))
    find(idx + 1, rs + bomb_dir(p.y, p.x))
    find(idx + 1, rs + bomb_other(p.y, p.x))
}

func bomb_line(_ y: Int, _ x: Int) -> [Point] {
    var rs = [Point(x: x, y: y)]
    for d in [-2, -1, 1, 2] {
        let ny = y + d
        if ny >= 0 && ny < n {
            rs.append(Point(x: x, y: ny))
        }
    }
    return rs
}

func bomb_dir(_ y: Int, _ x: Int) -> [Point] {
    var rs = [Point(x: x, y: y)]
    let dy = [0, 1, 0, -1]
    let dx = [1, 0, -1, 0]

    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]

        if ny >= n || nx >= n || nx < 0 || ny < 0 { continue }
        rs.append(Point(x: nx, y: ny))
    }

    return rs
}

func bomb_other(_ y: Int, _ x: Int) -> [Point] {
    var rs = [Point(x: x, y: y)]
    let dy = [-1, 1, 1, -1]
    let dx = [1, 1, -1, -1]
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]

        if ny >= n || nx >= n || nx < 0 || ny < 0 { continue }
        rs.append(Point(x: nx, y: ny))
    }

    return rs
}

find(0, [])
print(maxV)