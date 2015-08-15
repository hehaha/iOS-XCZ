//
//  UIColor+String.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/5.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import Foundation

extension UIColor {    
    class func XCZColor(hexRGBInt: Int, alpha: CGFloat = 1) -> UIColor {
        var finalAlpha = alpha
        if alpha > 1 || alpha < 0 {
            finalAlpha = 1
        }
        let red = hexRGBInt>>16
        let green = hexRGBInt>>8 & 0x00ff
        let blue = hexRGBInt & 0x0000ff
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: finalAlpha)
    }
}
