import Foundation

// ========================================
// Swift 입출력 템플릿
// ========================================

// 1. 한 줄 입력
let n = Int(readLine()!)!

// 2. 공백으로 구분된 숫자들
let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])

// 3. 여러 줄 입력
var arr = [[Int]]()
for _ in 0..<n {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    arr.append(line)
}

// 4. 문자열 배열로 입력
var grid = [[Character]]()
for _ in 0..<n {
    let line = Array(readLine()!)
    grid.append(line)
}

// 5. 빠른 출력 (여러 개)
var result = [String]()
result.append("answer")
print(result.joined(separator: "\n"))

// 6. FileIO (백준 빠른 입출력)
final class FileIO {
    private var buffer:[UInt8]
    private var index: Int
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)]
        index = 0
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        return buffer.withUnsafeBufferPointer { $0[index] }
    }
    
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        
        while now == 10 || now == 32 { now = read() }
        if now == 45{ isPositive.toggle(); now = read() }
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        
        return sum * (isPositive ? 1:-1)
    }
}

let fIO = FileIO()
let n = fIO.readInt()
