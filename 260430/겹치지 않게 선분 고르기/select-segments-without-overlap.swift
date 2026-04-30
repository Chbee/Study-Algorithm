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

    dfs(start: 0)

    func dfs(start: Int) {
        if start >= n {
            if !hasOverlap(temp)
            {
                maxV = max(maxV, temp.count)
            }
            return
        }

        for i in start..<n {
            temp.append(segments[i])
            dfs(start: i + 1)
            temp.removeLast()
        }
    }

    print(maxV)
}

func hasOverlap(_ segs: [Segment]) -> Bool {
    for i in 0..<segs.count {
        for j in (i+1)..<segs.count {
            let r1 = segs[i].a...segs[i].b
            let r2 = segs[j].a...segs[j].b
            if r1.overlaps(r2) { return true }
        }
    }
    return false
}

solution()