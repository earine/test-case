//: Playground - noun: a place where people can play

import UIKit


func getMin(x: Int, y: Int, z: Int) -> Int {
    return min(min(x, y), z)
}

func calculate(str1: String, str2: String) {
    let str1Len = str1.count
    let str2Len = str2.count
    
    var items = [[Int]](repeating: [Int](repeating: 0, count: str2Len + 1), count: str1Len + 1)
    
    for i in 0...str1Len {
        for j in 0...str2Len {
            // первая строка —пустая
            if (i==0) {
                items[i][j] = j
            } else if (j==0) {
                items[i][j] = i
            }
            else if (String(Array(str1)[i-1]) == String(Array(str2)[j-1])) {
                items[i][j] = items[i-1][j-1]
            }
            else {
                items[i][j] = 1 + getMin(x: items[i][j-1], y: items[i-1][j], z: items[i-1][j-1])
            }
        }
    }
    print(printOperations(str1: str1, str2: str2, items: items))
}


func printOperations(str1: String, str2: String, items: [[Int]]) -> String {
    var i = items.count - 1
    var j = items[0].count - 1
    
    var answer = ""
    while(true) {
        if (i == 0 || j == 0) {
            break;
        }
        if (String(Array(str1)[i-1]) == String(Array(str2)[j-1])) {
            i = i-1;
            j = j-1;
        } else if (items[i][j] == items[i-1][j-1] + 1){
            answer += "s"
            i = i-1
            j = j-1
        } else if (items[i][j] == items[i-1][j] + 1) {
            answer += "d"
            i = i-1
        } else if (items[i][j] == items[i][j-1] + 1){
            answer += "i"
            j = j-1
        }
    }
    
    return String(answer.reversed())
    
}


calculate(str1: "sitting", str2: "kitten")
