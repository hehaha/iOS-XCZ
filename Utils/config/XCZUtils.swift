//
//  XCZUtils.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/4.
//  Copyright (c) 2015年 小财主. All rights reserved.
//
import Foundation

//Global Methods
func Debug_log<T>(message: T, file: String = __FILE__, method: String = __FUNCTION__, line: Int = __LINE__) {
    #if DEBUG
        println("\(file.lastPathComponent)[\(line)], \(method):\n\(message)\n")
    #endif
}

func XCZconvertToCashString(count: Double) -> String {
    var returnStringValue = max(count, 0)
    let returnString = NSString(format: "%.2f", returnStringValue)
    if returnString.hasSuffix(".00") {
        return returnString.substringToIndex(returnString.length - 3)
    }
    
    return returnString as String
}