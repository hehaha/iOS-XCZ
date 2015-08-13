//
//  XCZNetworkKit.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/4.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

enum HttpMethod {
    case Get;
    case Post;
}

enum XCZErrorCode: Int {
    case ServerDataFormatError         = 9000001    //服务器返回数据错误
    case NetworkUnavailable            = 9000002    //网络不可用
}

class XCZNetworkKit: NSObject {
    
    private let _errorCodeReason: [XCZErrorCode: String] = [
        .NetworkUnavailable: "网络更新失败，请稍候刷新重试",
        .ServerDataFormatError: "网络更新失败，请稍候刷新重试",
    ]
    
    class var sharedManager: XCZNetworkKit {
        struct Static {
            static let shareInstance = XCZNetworkKit()
        }
        return Static.shareInstance
    }
    
    private let _networkGroup = dispatch_group_create()
    private var _networkReachabilityManager: AFNetworkReachabilityManager {
        return _httpRequestManager.reachabilityManager
    }
    
    private let _httpRequestManager: AFHTTPRequestOperationManager = {
        let manager = AFHTTPRequestOperationManager()
        manager.reachabilityManager = AFNetworkReachabilityManager(forDomain: XCZConstant.XCZDomain)
        return manager
    }()
    
    /**
    发送 Get 接口请求
    
    :param: relativeUrl 接口相对URL
    :param: params      参数
    :param: success     成功回调
    :param: failure     失败回调
    */
    func sendGetWithRelativeUrl(relativeUrl: String, params:[String: AnyObject], success:((responseObject: AnyObject) -> Void)?, failure:((error: NSError) -> Void)?){
        p_httpRequest(p_constructWholeUrl(relativeUrl), params: params, method: .Get, success: success, fail: failure)
    }
    
    /**
    发送 Post 请求
    
    :param: relativeUrl 接口相对URL
    :param: params      参数
    :param: success     成功回调
    :param: failure     失败回调
    */
    func sendPostWithRelativeUrl(relativeUrl: String, params:[String: AnyObject], success:((responseObject: AnyObject) -> Void)?, failure:((error: NSError) -> Void)?){
        p_httpRequest(p_constructWholeUrl(relativeUrl), params: params, method: .Post, success: success, fail: failure)
    }
    
    //手动生成服务器数据错误的NSError
    func createServerDataFormatError() -> NSError {
        return p_createError(9000001)
    }

    //MARK: - private method
    private func p_httpRequest(url: String, params: [String: AnyObject], method: HttpMethod, success: ((responseObject: AnyObject) -> Void)?, fail: ((error: NSError) -> Void)?) {
        _networkReachabilityManager.startMonitoring()
        if _networkReachabilityManager.networkReachabilityStatus == .NotReachable {
            fail?(error: p_createError(XCZErrorCode.NetworkUnavailable.rawValue))
            return
        }
        
        let successAction = { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            dispatch_group_leave(self._networkGroup)
            if responseObject == nil {
                fail?(error: self.p_createError(XCZErrorCode.ServerDataFormatError.rawValue))
            }
            else {
                success?(responseObject: responseObject!)
            }
        }
        
        let failAction = { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            dispatch_group_leave(self._networkGroup)
            
            // 对 AFNetworking 返回的错误进行处理。纪录 log 方便查询
            Debug_log("[\(NSDate())]http error! \nError: \(error).\nResponse string: \(operation.responseString)")
            
            // 默认网络失败错误码是： 无法连接网络
            var handledError = self.p_createError(XCZErrorCode.NetworkUnavailable.rawValue)
            if let responseDic = operation.responseObject as? [String: AnyObject]{
                if let errorCode = responseDic["error_code"] as? NSNumber{
                    handledError = self.p_createError(errorCode.integerValue)
                }
            }
            fail?(error: handledError)
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        dispatch_group_enter(_networkGroup)
        
        let requestManager = _httpRequestManager
        if method == .Get {
            requestManager.GET(url, parameters: params, success: successAction, failure: failAction)
        }
        else {
            requestManager.POST(url, parameters: params, success: successAction, failure: failAction)
        }
        
        dispatch_group_notify(_networkGroup, dispatch_get_main_queue()) { () -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    private func p_createError(code: Int) -> NSError {
        var errorMessage = "未知错误"
        
        if let errorCode = XCZErrorCode(rawValue: code) {
            errorMessage = _errorCodeReason[errorCode]!
        }
        
        return NSError(domain: XCZConstant.HttpHostBaseURL, code: code, userInfo: [XCZConstant.NetworkErrorKey: errorMessage])
    }
    
    private func p_constructWholeUrl(relativeUrl: String) -> String{
        return "\(XCZConstant.HttpHostBaseURL)\(relativeUrl)"
    }
}
