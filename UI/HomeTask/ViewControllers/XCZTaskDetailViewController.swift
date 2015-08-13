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
    
    private let _segmentView = UISegmentedControl(items: ["未完成","已完成"])
    private let _tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "查看"
        navigationController?.navigationBar.titleTextAttributes = XCZConstant.NavigtionBarTitleAttributeDict
        view.backgroundColor = UIColor.XCZColor(0xecf0f1)
        
        p_setUpView()
    }
    
    //MARK: - Event
    func segmentChanged() {
        _tableView.setContentOffset(CGPointZero, animated: true)
        //未完成
        if _segmentView.selectedSegmentIndex == 0 {
            _tableView.rowHeight = unfinishedCellHeight
        }
        else {
            _tableView.rowHeight = finishedCellHeight
        }
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        _tableView.reloadData()
    }
    
    //MARK: - Private method
    private func p_setUpView(){
        _segmentView.backgroundColor = UIColor.whiteColor()
        _segmentView.tintColor = UIColor.XCZColor(0xe84c3d)
        _segmentView.selectedSegmentIndex = 0
        _segmentView.setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(14)], forState: .Normal)
        _segmentView.addTarget(self, action: "segmentChanged", forControlEvents: .ValueChanged)
        view.addSubview(_segmentView)
        _segmentView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(self.view).with().offset()(XCZConstant.navigationBarHeight + 10)
            make.centerX.equalTo()(self.view)
        }
        
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.separatorStyle = .None
        _tableView.rowHeight = unfinishedCellHeight
        _tableView.backgroundColor = UIColor.XCZColor(0xecf0f1)
        _tableView.registerClass(XCZTaskDetailFinishedCell.self, forCellReuseIdentifier: finishedCellIdentifier)
        _tableView.registerClass(XCZTaskDetailUnfinishedCell.self, forCellReuseIdentifier: unfinishedCellIdentifier)
        view.addSubview(_tableView)
        _tableView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(self._segmentView.mas_bottom).with().offset()(5)
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
        if _segmentView.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(unfinishedCellIdentifier, forIndexPath: indexPath) as! XCZTaskDetailUnfinishedCell
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier(finishedCellIdentifier, forIndexPath: indexPath) as! XCZTaskDetailFinishedCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
}
