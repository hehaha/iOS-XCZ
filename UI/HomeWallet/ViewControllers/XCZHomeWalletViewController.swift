//
//  XCZHomeWalletViewController.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/5.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

class XCZHomeWalletViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "钱包"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "记账", style: UIBarButtonItemStyle.Plain, target: self, action: "recordItemClicked")
        navigationController?.navigationBar.titleTextAttributes = XCZConstant.NavigtionBarTitleAttributeDict
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    //MARK: - Event
    func recordItemClicked() {
    }
}
