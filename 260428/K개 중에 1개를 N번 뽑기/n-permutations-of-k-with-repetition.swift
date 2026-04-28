import Foundation

let inputLine = readLine()!.split(separator: " ").map { Int(String($0))! }
let k = inputLine[0]
var n = inputLine[1]

var rs = [[Int]]()

func selectNum(select: [Int]) {
    if select.count == n {
        rs.append(select)
        return
    }

    for i in 1...k {
        selectNum(select: select + [i])
    }
}

selectNum(select: [])

for c in rs {
    print(c.map { String($0) }.joined(separator: " "))
}