//
//  XCZHomeTaskViewController.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/5.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "cell"
private let cellHeight: CGFloat = 125

class XCZHomeTaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "任务"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "查看", style: UIBarButtonItemStyle.Plain, target: self, action: "checkInItemClicked")
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.rowHeight = cellHeight
        tableView.backgroundColor = UIColor.XCZColor(0xecf0f1)
        tableView.registerClass(XCZHomeTaskCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        view.addSubview(tableView)
        tableView.mas_makeConstraints { (make) -> Void in
            make.edges.equalTo()(self.view)
        }
    }
    
    //MARK: - Event
    func checkInItemClicked() {
        let detailVC = XCZTaskDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK: - UITableViewDelegate & UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! XCZHomeTaskCell
        switch indexPath.row % 4 {
        case 0: cell.decorationImageName = "task_blue_button"
        case 1: cell.decorationImageName = "task_green_button"
        case 2: cell.decorationImageName = "task_yellow_button"
        default: cell.decorationImageName = "task_red_button"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
