//
//  StringExtension.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/14.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import Foundation

extension String {
    func XCZtoNumber() -> NSNumber? {
        if toInt() != nil {
            return toInt()
        }
        else {
            let resultArr = self.componentsSeparatedByString(".")
            if count(resultArr) != 2 {
                return nil
            }
            else if let intPart = resultArr.first?.toInt(), let doublePart = resultArr.last?.toInt() {
                let intValue = intPart
                let doubleValue = Double(doublePart) / pow(10.0, Double(count(resultArr.last!)))
                return Double(intValue) + doubleValue
            }
            else {
                return nil
            }
        }
    }
}