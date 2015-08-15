//
//  XCZApplyCashView.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/12.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

private let textFieldTopMargin: CGFloat = 21
private let textFieldHorizontalMargin: CGFloat = 18
private let textFieldHeight: CGFloat = 40
//两个textField中间的间距
private let textFieldMidMargin: CGFloat = 15
private let buttonTopMargin: CGFloat = 20
private let buttonBottomMargin: CGFloat = 20
private let textFont = UIFont.systemFontOfSize(15)
private let textColor = UIColor.XCZColor(0x626262)

class XCZApplyCashView: UIView {
    
    var applyAction: (() -> Void)?
    
    private let _useTextField: UITextField = {
        let text = UITextField()
        text.tintColor = UIColor.XCZColor(0xe64d43)
        text.font = textFont
        text.textColor = textColor
        return text
    }()
    
    private let _applyTextField: UITextField = {
        let text = UITextField()
        text.tintColor = UIColor.XCZColor(0xe64d43)
        text.font = textFont
        text.textColor = textColor
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        p_setUpView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        p_setUpView()
    }
    
    //MARK: - Event
    func applyButtonClicked() {
        var errorStr: String?
        let cashStr = _applyTextField.text.stringByReplacingOccurrencesOfString(" ", withString: "")
        let useStr = _useTextField.text.stringByReplacingOccurrencesOfString(" ", withString: "")
        if cashStr.isEmpty {
            errorStr = "申请的金额不能为空！"
        }
        else if useStr.isEmpty {
            errorStr = "现金用途不能为空！"
        }
        else if cashStr.XCZtoNumber() == nil {
            errorStr = "请填写正确的金额！"
        }
        
        if errorStr != nil {
            let alertView = UIAlertView(title: errorStr, message: nil, delegate: nil, cancelButtonTitle: "确定")
            alertView.show()
        }
        else {
           applyAction?()
        }
    }
    
    override func resignFirstResponder() -> Bool {
        _useTextField.resignFirstResponder()
        _applyTextField.resignFirstResponder()
        return super.resignFirstResponder()
    }
    
    //MARK: - Private method
    private func p_setUpView() {
        XCZaddTopAndBottomSeparator()
        
        let applyView = UIView()
        applyView.backgroundColor = UIColor.XCZColor(0xfbe4e2)
        applyView.layer.borderWidth = 1
        applyView.layer.borderColor = UIColor.XCZColor(0xe64d43).CGColor
        addSubview(applyView)
        applyView.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self).with().offset()(textFieldHorizontalMargin)
            make.height.equalTo()(textFieldHeight)
            make.top.equalTo()(self).with().offset()(textFieldTopMargin)
            make.right.equalTo()(self).with().offset()(-textFieldHorizontalMargin)
        }
        
        let applyLabel = UILabel()
        applyLabel.font = textFont
        applyLabel.textColor = textColor
        applyLabel.text = "提取现金"
        applyLabel.setContentHuggingPriority(UILayoutPriority(500), forAxis: .Horizontal)
        applyView.addSubview(applyLabel)
        applyLabel.mas_makeConstraints { (make) -> Void in
            make.centerY.equalTo()(applyView)
            make.left.equalTo()(applyView).with().offset()(8)
        }

        let applySeparator = UIView()
        applySeparator.backgroundColor = UIColor.XCZColor(0xe64d43)
        applyView.addSubview(applySeparator)
        applySeparator.mas_makeConstraints { (make) -> Void in
            make.width.equalTo()(1)
            make.height.equalTo()(textFieldHeight - 10)
            make.centerY.equalTo()(applyView)
            make.left.equalTo()(applyLabel.mas_right).with().offset()(8)
        }
        
        applyView.addSubview(_applyTextField)
        _applyTextField.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(applyView)
            make.right.equalTo()(applyView)
            make.left.equalTo()(applySeparator).with().offset()(8)
            make.bottom.equalTo()(applyView)
        }
        
        let useView = UIView()
        useView.backgroundColor = UIColor.XCZColor(0xfbe4e2)
        useView.layer.borderColor = UIColor.XCZColor(0xe64d43).CGColor
        useView.layer.borderWidth = 1
        addSubview(useView)
        useView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(applyView.mas_bottom).with().offset()(textFieldMidMargin)
            make.right.equalTo()(applyView)
            make.left.equalTo()(applyView)
            make.height.equalTo()(textFieldHeight)
        }
        
        let useLabel = UILabel()
        useLabel.font = textFont
        useLabel.textColor = textColor
        useLabel.text = "现金用途"
        useLabel.setContentHuggingPriority(UILayoutPriority(500), forAxis: .Horizontal)
        useView.addSubview(useLabel)
        useLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(useView).with().offset()(8)
            make.centerY.equalTo()(useView)
        }
        
        let useSeparator = UIView()
        useSeparator.backgroundColor = UIColor.XCZColor(0xe64d43)
        useView.addSubview(useSeparator)
        useSeparator.mas_makeConstraints { (make) -> Void in
            make.width.equalTo()(1)
            make.height.equalTo()(textFieldHeight - 10)
            make.centerY.equalTo()(useLabel)
            make.left.equalTo()(useLabel.mas_right).with().offset()(8)
        }
        
        useView.addSubview(_useTextField)
        _useTextField.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(useView)
            make.right.equalTo()(useView)
            make.left.equalTo()(useSeparator).with().offset()(8)
            make.bottom.equalTo()(useView)
        }
        
        let applyButton = UIButton()
        applyButton.setImage(UIImage(named: "cash_button"), forState: .Normal)
        applyButton.addTarget(self, action: "applyButtonClicked", forControlEvents: .TouchUpInside)
        addSubview(applyButton)
        applyButton.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(useView.mas_bottom).with().offset()(buttonTopMargin)
            make.centerX.equalTo()(self)
            make.bottom.equalTo()(self).with().offset()(-buttonBottomMargin)
        }
    }
}
