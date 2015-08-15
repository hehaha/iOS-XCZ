//
//  XCZBillDetailViewController.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/14.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

private let cellIdentifer = "cell"
class XCZBillDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "账单"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "记账", style: UIBarButtonItemStyle.Plain, target: self, action: "recordItemClicked")
        
        p_setUpView()
    }
    
    //MARK: - Event
    func recordItemClicked() {
        let selectVC = XCZSelectBillTypeViewController()
        navigationController?.pushViewController(selectVC, animated: true)
    }
    
    //MARK: - UITableViewDelegate & UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer, forIndexPath: indexPath) as! XCZBillCell
        cell.backgroundColor = UIColor.XCZColor(0xecf0f1)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 210
    }
    
    //MARK: - Private Method
    private func p_setUpView() {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.registerClass(XCZBillCell.self, forCellReuseIdentifier: cellIdentifer)
        tableView.backgroundColor = UIColor.XCZColor(0xecf0f1)
        view.addSubview(tableView)
        tableView.mas_makeConstraints { (make) -> Void in
            make.edges.equalTo()(self.view).insets()(UIEdgeInsetsMake(XCZConstant.navigationBarHeight, 0, XCZConstant.tabBarHeight, 0))
        }
    }
}
