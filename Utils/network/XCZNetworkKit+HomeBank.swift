//
//  XCZNetworkKit+HomeBank.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/12.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import Foundation

extension XCZNetworkKit {
    /*
    用户请求的接口
    :param: email 用户注册邮箱
    :param: password 用户登录密码
    :param: success 成功回调
    :param: fail 失败回调
    */
    func userLogin(email e: String, password: String, success: ((userInfo: XCZUserInfoModel) -> Void)?, fail: ((error: NSError) -> Void)?) {
        var params = ["email": e, "password": password]
        XCZNetworkKit.sharedManager.sendPostWithRelativeUrl("/qishi/public/api/postLogin", params: params, success: { (responseObject) -> Void in
            if let resultArr = responseObject["result"] as? [[String: AnyObject]] {
                var error: NSError?
                if let resultDict = resultArr.first {
                    if let resultObject = MTLJSONAdapter.modelOfClass(XCZUserInfoModel.self, fromJSONDictionary: resultDict, error: &error) as? XCZUserInfoModel {
                        success?(userInfo: resultObject)
                        return
                    }
                }
            }
            fail?(error: self.createServerDataFormatError())
            }) { (error) -> Void in
                fail?(error: error)
        }
    }
}