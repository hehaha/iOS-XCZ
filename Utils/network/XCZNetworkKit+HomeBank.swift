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
    用户登陆的接口
    :param: email 用户注册邮箱
    :param: password 用户登录密码
    :param: success 成功回调
    :param: fail 失败回调
    */
    func userLogin(email e: String, password: String, success: ((userInfo: XCZUserInfoModel) -> Void)?, fail: ((error: NSError) -> Void)?) {
        let params = ["email": e, "password": password]
        self.sendPostWithRelativeUrl("/qishi/public/api/postLogin", params: params, success: { (responseObject) -> Void in
            if let resultArr = responseObject["result"] as? [[String: AnyObject]] {
                var error: NSError?
                if let resultDict = resultArr.first {
                    if let resultObject = MTLJSONAdapter.modelOfClass(XCZUserInfoModel.self, fromJSONDictionary: resultDict, error: &error) as? XCZUserInfoModel {
                        if error == nil {
                            success?(userInfo: resultObject)
                            return
                        }
                    }
                }
            }
            fail?(error: self.createServerDataFormatError())
            }) { (error) -> Void in
                fail?(error: error)
        }
    }
    
    /*
    获取用户银行信息
    :param: success 成功回调
    :param: fail 失败回调
    */
    func fetchBankAccount(success: ((bankModel: XCZBankAccountModel) -> Void)?, fail: ((error: NSError) -> Void)?) {
        var token = "369d974ba060dc601c5a7374730dec38"
        let params = ["token": token]
        self.sendPostWithRelativeUrl("/qishi/public/api/showBankAccount", params: params, success: { (responseObject) -> Void in
            if let resultArr = responseObject["result"] as? [[String: AnyObject]] {
                var error: NSError?
                if let resultDict = resultArr.first {
                    if let resultObject = MTLJSONAdapter.modelOfClass(XCZBankAccountModel.self, fromJSONDictionary: resultDict, error: &error) as? XCZBankAccountModel {
                        if error == nil {
                            success?(bankModel: resultObject)
                            return
                        }
                    }
                }
            }
            fail?(error: self.createServerDataFormatError())
        }) { (error) -> Void in
            fail?(error: error)
        }
    }
}