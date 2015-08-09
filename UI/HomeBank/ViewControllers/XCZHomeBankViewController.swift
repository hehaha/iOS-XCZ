//
//  XCZHomeBankViewController.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/5.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

private let buttonContainerViewHeight: CGFloat = 60
private let buttonIconMargin: CGFloat = 40
private let viewBottomMargin: CGFloat = 10

class XCZHomeBankViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "家庭银行"
        navigationController?.navigationBar.titleTextAttributes = XCZConstant.NavigtionBarTitleAttributeDict
        view.backgroundColor = UIColor.XCZColor(0xecf0f1)
        
        p_initView()
    }
    
    //MARK: - Event
    func saveButtonClicked() {
        
    }
    
    func fetchButtonClicked() {
        
    }
    
    //MARK: - Private method
    private func p_initView() {
        let accountImageView = UIImageView(image: UIImage(named: "bank_account_red"))
        view.addSubview(accountImageView)
        accountImageView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(self.view).with().offset()(viewBottomMargin + XCZConstant.navigationBarHeight)
            make.right.equalTo()(self.view)
            make.left.equalTo()(self.view)
        }
        
        let buttonContainerView = UIView()
        buttonContainerView.backgroundColor = UIColor.whiteColor()
        view.addSubview(buttonContainerView)
        buttonContainerView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(accountImageView.mas_bottom).offset()(viewBottomMargin)
            make.right.equalTo()(self.view)
            make.left.equalTo()(self.view)
            make.height.equalTo()(buttonContainerViewHeight)
        }
        buttonContainerView.XCZaddTopAndBottomSeparator()
                
        //存入的button
        let saveButton = UIButton()
        saveButton.backgroundColor = UIColor.whiteColor()
        saveButton.addTarget(self, action: "saveButtonClicked", forControlEvents: .TouchUpInside)
        buttonContainerView.addSubview(saveButton)
        saveButton.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(buttonContainerView)
            make.right.equalTo()(buttonContainerView.mas_centerX)
            make.height.equalTo()(buttonContainerView)
            make.top.equalTo()(buttonContainerView)
        }
        
        let saveImageView = UIImageView(image: UIImage(named: "bank_button_in"))
        saveButton.addSubview(saveImageView)
        saveImageView.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(saveButton).with().offset()(buttonIconMargin)
            make.centerY.equalTo()(saveButton)
        }
        
        let saveLabel = UILabel()
        saveLabel.textColor = UIColor.XCZColor(0x626262)
        saveLabel.font = UIFont.systemFontOfSize(16)
        saveLabel.text = "存入"
        saveButton.addSubview(saveLabel)
        saveLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(saveImageView.mas_right).with().offset()(15)
            make.centerY.equalTo()(saveImageView)
        }
        
        //取出的button
        let fetchButton = UIButton()
        fetchButton.backgroundColor = UIColor.whiteColor()
        fetchButton.addTarget(self, action: "fetchButtonClicked", forControlEvents: .TouchUpInside)
        buttonContainerView.addSubview(fetchButton)
        fetchButton.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(saveButton)
            make.left.equalTo()(saveButton.mas_right)
            make.right.equalTo()(buttonContainerView)
            make.height.equalTo()(saveButton)
        }
        
        let fetchImageView = UIImageView(image: UIImage(named: "bank_button_out"))
        fetchButton.addSubview(fetchImageView)
        fetchImageView.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(fetchButton).with().offset()(buttonIconMargin)
            make.centerY.equalTo()(fetchButton)
        }

        let fetchLabel = UILabel()
        fetchLabel.textColor = UIColor.XCZColor(0x626262)
        fetchLabel.text = "取出"
        fetchLabel.font = UIFont.systemFontOfSize(16)
        fetchButton.addSubview(fetchLabel)
        fetchLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(fetchImageView.mas_right).with().offset()(15)
            make.centerY.equalTo()(fetchImageView)
        }
        
        //中间分隔线
        let separateLine = UIView()
        separateLine.backgroundColor = UIColor.XCZColor(0xbdc3c7)
        buttonContainerView.addSubview(separateLine)
        separateLine.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(buttonContainerView).with().offset()(10)
            make.bottom.equalTo()(buttonContainerView).with().offset()(-10)
            make.centerX.equalTo()(buttonContainerView)
            make.width.equalTo()(1)
        }
        buttonContainerView.XCZaddTopAndBottomSeparator()
        
        let countView = XCZBankCountView(profitArr: [1.0, 15.0, 50.0, 100.0])
        countView.backgroundColor = UIColor.whiteColor()
        view.addSubview(countView)
        countView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(buttonContainerView.mas_bottom).with().offset()(viewBottomMargin)
            make.right.equalTo()(self.view)
            make.left.equalTo()(self.view)
            make.bottom.equalTo()(self.view).with().offset()(-30 - XCZConstant.tabBarHeight)
        }
    }
}
