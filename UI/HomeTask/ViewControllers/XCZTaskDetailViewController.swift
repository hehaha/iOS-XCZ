//
//  XCZTaskDetailViewController.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/8.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

private let unfinishedCellHeight: CGFloat = 170
private let finishedCellHeight: CGFloat = 160
private let finishedCellIdentifier = "finishedCell"
private let unfinishedCellIdentifier = "unfinishedCell"

class XCZTaskDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "查看"
        navigationController?.navigationBar.titleTextAttributes = XCZConstant.NavigtionBarTitleAttributeDict
        view.backgroundColor = UIColor.XCZColor(0xecf0f1)
        
        p_setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Private method
    private func p_setUpView(){
        let segmentView = UISegmentedControl(items: ["未完成","已完成"])
        segmentView.backgroundColor = UIColor.whiteColor()
        segmentView.tintColor = UIColor.XCZColor(0xe84c3d)
        segmentView.selectedSegmentIndex = 0
        segmentView.setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(14)], forState: .Normal)
        view.addSubview(segmentView)
        segmentView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(self.view).with().offset()(XCZConstant.navigationBarHeight + 10)
            make.centerX.equalTo()(self.view)
        }
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.rowHeight = unfinishedCellHeight
        tableView.backgroundColor = UIColor.XCZColor(0xecf0f1)
        tableView.registerClass(XCZTaskDetailFinishedCell.self, forCellReuseIdentifier: finishedCellIdentifier)
        tableView.registerClass(XCZTaskDetailUnfinishedCell.self, forCellReuseIdentifier: unfinishedCellIdentifier)
        view.addSubview(tableView)
        tableView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(segmentView.mas_bottom).with().offset()(5)
            make.right.equalTo()(self.view)
            make.left.equalTo()(self.view)
            make.bottom.equalTo()(self.view).with().offset()(-XCZConstant.tabBarHeight)
        }
    }
    
    //MARK: - UITableViewDelegate & UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(unfinishedCellIdentifier, forIndexPath: indexPath) as! XCZTaskDetailUnfinishedCell
        return cell
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
}
