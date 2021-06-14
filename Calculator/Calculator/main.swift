//
//  main.swift
//  Calculator
//
//  Created by bluemond on 2021/6/12.
//  swift代码练习，一个基于递归下降的支持带括号的四则运算的计算器


import Foundation

func expression(_ s: String, _ index: inout String.Index) -> Int {
    var t = 0
    t += term(s, &index)
    while (true) {
        if (s[index] == "+") {
            index = s.index(after: index)
            t += term(s, &index)
        } else if (s[index] == "-") {
            index = s.index(after: index)
            t -= term(s, &index)
        } else {
            break
        }
    }
    return t
}

func term(_ s: String, _ index: inout String.Index) -> Int {
    var t = 1
    while true {
        if s[index] == "+" {
            index = s.index(after: index)
        } else if s[index] == "-" {
            index = s.index(after: index)
            t *= -1
        } else {
            break
        }
    }
    t *= factor(s, &index)
    while true {
        if (s[index] == "*") {
            index = s.index(after: index)
            t *= term(s, &index)
        } else if (s[index] == "/") {
            index = s.index(after: index)
            t /= term(s, &index)
        } else {
            break
        }
    }
    
    return t
}

func factor(_ s: String, _ index: inout String.Index) -> Int {
    if s[index] == "(" {
        index = s.index(after: index)
        let t = expression(s, &index)
        if s[index] != ")" {
            fatalError("paratheses not matches")
        } else {
            index = s.index(after: index)
        }
        return t
    } else {
        return numeric(s, &index)
    }
}

func numeric(_ s: String, _ index: inout String.Index) -> Int {
    var t = 0
    var sign = 1
    while true {
        if s[index] == "+" {
            index = s.index(after: index)
        } else if s[index] == "-" {
            index = s.index(after: index)
            sign *= -1
        } else {
            break
        }
    }
    while s[index].isNumber {
        t = t * 10 + s[index].wholeNumberValue!
        index = s.index(after: index)
    }
    return sign * t
}



let sin: String! = readLine()
let s1 = sin.replacingOccurrences(of: #"\s"#, with: "", options: .regularExpression) + "#"
var index = s1.startIndex
print(expression(s1, &index))
