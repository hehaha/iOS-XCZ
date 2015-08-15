//
//  XCZRecordBillViewController.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/15.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

class XCZRecordBillViewController: UIViewController {

    var billType: BillIconType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "记账"
        view.backgroundColor = UIColor.XCZColor(0xecf0f1)
        
        p_setUpView()
    }
    
    private func p_setUpView() {
    
    }
}
