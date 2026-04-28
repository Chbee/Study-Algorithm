import Foundation

let n = Int(readLine()!)!

var cnt = 0

func selectNum(rs: [Int]) {
    if rs.count == n {
        if rs.contains(1) && rs.filter({ $0 == 1 }).count != 1 { return }
        if rs.contains(2) && rs.filter({ $0 == 2 }).count != 2 { return }
        if rs.contains(3) && rs.filter({ $0 == 3 }).count != 3 { return }
        if rs.contains(4) && rs.filter({ $0 == 4 }).count != 4 { return }
        cnt += 1
        return
    }

    for i in 1...4 {
        selectNum(rs: rs + [i])
    }
}

selectNum(rs: [])

print(cnt)