//
//  XCZUserInfoModel.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/13.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

class XCZUserInfoModel: MTLModel, MTLJSONSerializing {

    /*
    * 用户的银行余额
    */
    var bankAmount: NSNumber?
    
    /*
    * 用户的钱包余额
    */
    var cashAmount: NSNumber?
    
    /*
    * 用户的ID
    */
    var userId: NSNumber?
    
    /*
    * 用户的昵称
    */
    var name: String?
    
    /*
    * 用户父母的Id
    */
    var parentId: NSNumber?
    
    /*
    * 当前用户的汇率
    */
    var bankRate: NSNumber?
    
    /*
    * 用户的token，第一次取到以后直接存本地，以后每次请求都得带上
    */
    var userToken: String?
    
    /*
    * 数据更新的时间
    */
    var updateTimeStr: String?
    
    /*
    * 本月消费的额度
    */
    var monthLimited: NSNumber?
    
    class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["bankAmount": "bank_amount",
                "cashAmount": "cash",
                "userId": "id",
                "monthLimited": "limit_month",
                "name": "name",
                "parentId": "parentid",
                "userToken": "remember_token",
                "updateTimeStr": "uptime",
                "bankRate": "rate"]
    }
}
