//
//  XCZConstant.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/4.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import Foundation

struct XCZConstant {
    
    static let statusBarHeight: CGFloat = 20
    static let navigationBarHeight: CGFloat = 64
    static let tabBarHeight: CGFloat = 44
    
    static let XCZDomain = "182.92.154.247"
    static let NetworkErrorKey = "ErrorInfo"
    static let HttpHostBaseURL = "http://\(XCZDomain)"
    
    static let HasShowSplashKey = "HasShowSplash"
    
    static let NavigtionBarTitleAttributeDict = [NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont.boldSystemFontOfSize(18)]
}
