//
//  XCZSelectBillTypeViewController.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/15.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

private let dataSource = [BillIconType.Default, BillIconType.Food, BillIconType.Dress, BillIconType.Stationary, BillIconType.Book, BillIconType.Toy]
private let cellReuseIdentifier = "cell"

class XCZSelectBillTypeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "记账"
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 64
        tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        tableView.backgroundColor = UIColor.XCZColor(0xecf0f1)
        tableView.registerClass(XCZSelectBillCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.mas_makeConstraints { (make) -> Void in
            make.edges.equalTo()(self.view).insets()(UIEdgeInsetsMake(XCZConstant.navigationBarHeight, 0, XCZConstant.tabBarHeight, 0))
        }
    }
    
    //MARK: - UITableViewDelegate & UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! XCZSelectBillCell
        cell.iconType = dataSource[indexPath.row]
        cell.backgroundColor = UIColor.XCZColor(0xecf0f1)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count(dataSource)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let recordVC = XCZRecordBillViewController()
        recordVC.billType = dataSource[indexPath.row]
        navigationController?.pushViewController(recordVC, animated: true)
    }
}
