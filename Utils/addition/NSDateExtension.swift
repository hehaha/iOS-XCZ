//
//  NSDateExtension.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/15.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import Foundation

extension NSDate {
    func XCZconvertToString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.stringFromDate(self)
    }
}