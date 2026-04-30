struct Segment: Hashable {
    let a: Int
    let b: Int
}

let n = Int(readLine()!)!
var segments: [Segment] = []
for _ in 0..<n {
    let parts = readLine()!.split(separator: " ").map { Int($0)! }
    segments.append(Segment(a: parts[0], b: parts[1]))
}

func solution() {
    if n == 1 { print(1); return }

    var temp: [Segment] = []
    var maxV = 0

    for i in 0..<n {
        let s = segments[i]
        temp.append(s)
        dfs(start: i)
        temp = []
    }

    func dfs(start: Int) {
        if start >= n {
            if Set(temp.flatMap { [$0.a, $0.b] }).count == (temp.count * 2)
            {
                maxV = max(maxV, temp.count)
            }
            return
        }

        for i in start..<n {
            var _temp = temp
            let current = segments[i]
            _temp.append(current)
            guard Set(_temp).count > 1 else { continue }
            temp.append(current)
            dfs(start: i + 1)
            temp.removeLast()
        }
    }

    print(maxV)
}

solution()