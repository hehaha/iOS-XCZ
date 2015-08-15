//
//  XCZBankAccountModel.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/14.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

class XCZBankAccountModel: MTLModel, MTLJSONSerializing {
    /*
    * 银行存款
    */
    var bankAmount: NSNumber?
    
    /*
    * 今日的收益
    */
    var dayIncome: NSNumber?
    
    /*
    * 本周收益
    */
    var weekIncome: NSNumber?
    
    /*
    * 本月收益
    */
    var monthIncome: NSNumber?
    
    /*
    * 总共的收益
    */
    var totalIncome: NSNumber?
    
    class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [
            "bankAmount": "bank_amount",
            "dayIncome": "income_day",
            "weekIncome": "income_week",
            "monthIncome": "income_month",
            "totalIncome": "income_all",
        ]
    }
}
