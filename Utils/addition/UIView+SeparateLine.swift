//
//  UIView+SeparateLine.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/7.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import Foundation

extension UIView {
    //为视图添加顶部和顶部的分隔线
    func XCZaddTopAndBottomSeparator(separatorColor: UIColor = UIColor.XCZColor(0xbdc3c7)) {
        let topLine = UIView()
        topLine.backgroundColor = separatorColor
        addSubview(topLine)
        topLine.mas_makeConstraints { (make) -> Void in
            make.top.mas_equalTo()(self)
            make.right.equalTo()(self)
            make.left.equalTo()(self)
            make.height.equalTo()(0.5)
        }
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = separatorColor
        addSubview(bottomLine)
        bottomLine.mas_makeConstraints { (make) -> Void in
            make.bottom.mas_equalTo()(self)
            make.right.equalTo()(self)
            make.left.equalTo()(self)
            make.height.equalTo()(0.5)
        }
    }
}