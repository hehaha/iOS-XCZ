//
//  XCZHomeWalletViewController.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/5.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

private let viewBottomMargin: CGFloat = 10

class XCZHomeWalletViewController: UIViewController, UIScrollViewDelegate {
    private let _bottomView = XCZApplyCashView()
    private let _scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "钱包"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "账单", style: UIBarButtonItemStyle.Plain, target: self, action: "recordItemClicked")
        view.backgroundColor = UIColor.XCZColor(0xecf0f1)
        
        p_setUpView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - Event
    func recordItemClicked() {
        let billVC = XCZBillDetailViewController()
        navigationController?.pushViewController(billVC, animated: true)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        if let height = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue().height {
            _scrollView.contentInset = UIEdgeInsets(top: -height + 64, left: 0, bottom: 0, right: 0)

        }
    }
    
    func keyboardWillHide() {
        _scrollView.contentInset = UIEdgeInsetsZero
    }

    func tapToHideKeyboard() {
        _bottomView.resignFirstResponder()
    }
    
    //MARK: - Private method
    private func p_setUpView() {
        _scrollView.delegate = self
        view.addSubview(_scrollView)
        _scrollView.mas_makeConstraints { (make) -> Void in
            make.edges.equalTo()(self.view)
        }
        
        let contentView = UIView()
        let tap = UITapGestureRecognizer(target: self, action: "tapToHideKeyboard")
        contentView.addGestureRecognizer(tap)
        _scrollView.addSubview(contentView)
        contentView.mas_makeConstraints { (make) -> Void in
            make.edges.equalTo()(self._scrollView)
            make.width.equalTo()(UIScreen.mainScreen().bounds.width)
        }
        
        let accountImageView = UIImageView(image: UIImage(named: "bank_account_red"))
        contentView.addSubview(accountImageView)
        accountImageView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(contentView).with().offset()(viewBottomMargin + XCZConstant.navigationBarHeight)
            make.right.equalTo()(contentView)
            make.left.equalTo()(contentView)
        }
        
        let graphView = XCZExpenseGraphView(profit: 0, expend: 0)
        graphView.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(graphView)
        graphView.mas_updateConstraints { (make) -> Void in
            make.top.equalTo()(accountImageView.mas_bottom).with().offset()(viewBottomMargin)
            make.right.equalTo()(contentView)
            make.left.equalTo()(contentView)
        }

        _bottomView.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(_bottomView)
        _bottomView.mas_makeConstraints { (make) -> Void in
            make.bottom.equalTo()(contentView).with().offset()(-XCZConstant.tabBarHeight - 30)
            make.right.equalTo()(contentView)
            make.left.equalTo()(contentView)
            make.top.equalTo()(graphView.mas_bottom).with().offset()(viewBottomMargin)
        }
        
    }
}
