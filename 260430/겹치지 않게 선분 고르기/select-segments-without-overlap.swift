let n = Int(readLine()!)!
var segments: [(Int, Int)] = []
for _ in 0..<n {
    let parts = readLine()!.split(separator: " ").map { Int($0)! }
    segments.append((parts[0], parts[1]))
}

var temp = [Int]()
var rs = [[Int]]()

func select(start: Int) {
    if Set(temp).count == 4 { rs.append(temp); return }
    for i in start..<n {
        let (a, b) = segments[i]
        temp.append(a)
        temp.append(b)
        select(start: i + 1)
        temp.removeLast()
        temp.removeLast()
    }
}

for i in 0..<n {
    select(start: i)
}

print(Set(rs).count)