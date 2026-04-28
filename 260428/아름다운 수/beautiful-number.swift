import Foundation

let n = Int(readLine()!)!
var cnt = 0
func choose(num: Int) {
    if num == n + 1 {
        cnt += 1
        return
    }
    if num > n + 1 { return }
    for select in 1...4 {
        choose(num: num + select)
    }
}

choose(num: 1)

print(cnt)