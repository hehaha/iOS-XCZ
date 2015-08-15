//
//  XCZTaskDetailUnfinishedCell.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/9.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

private let cellTextFont = UIFont.systemFontOfSize(14)
private let cellContentColor = UIColor.XCZColor(0x000000)
private let cellTitleColor = UIColor.XCZColor(0x626262)

class XCZTaskDetailUnfinishedCell: UITableViewCell {

    private let _describeLabel = UILabel()
    private let _paymentLabel = UILabel()
    private let _deadlineLabel = UILabel()
    private let _completeLabel = UILabel()
    
    var completeAction: (() -> Void)?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        p_setUpView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        p_setUpView()
    }
    
    //MARK: - Event
    func completeButtonClicked() {
        completeAction?()
    }
    
    //MARK: - Private Method
    private func p_setUpView() {
        selectionStyle = .None
        contentView.backgroundColor = UIColor.XCZColor(0xecf0f1)
        
        let bubbleImageView = UIImageView(image: UIImage(named: "task_unfinished_frame"))
        bubbleImageView.userInteractionEnabled = true
        contentView.addSubview(bubbleImageView)
        bubbleImageView.mas_makeConstraints { (make) -> Void in
            make.edges.equalTo()(self.contentView).with().insets()(UIEdgeInsetsMake(5, 11, 5, 11))
        }
        
        let describeTitleLabel = UILabel()
        describeTitleLabel.text = "任务描述"
        describeTitleLabel.font = cellTextFont
        describeTitleLabel.textColor = cellTitleColor
        bubbleImageView.addSubview(describeTitleLabel)
        describeTitleLabel.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(bubbleImageView).with().offset()(20)
            make.left.equalTo()(bubbleImageView).with().offset()(20)
        }
        
        _describeLabel.font = cellTextFont
        _describeLabel.textColor = cellContentColor
        bubbleImageView.addSubview(_describeLabel)
        _describeLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(describeTitleLabel.mas_right).with().offset()(10)
            make.centerY.equalTo()(describeTitleLabel)
        }
        
        let paymentTitleLabel = UILabel()
        paymentTitleLabel.font = cellTextFont
        paymentTitleLabel.text = "酬劳"
        paymentTitleLabel.textColor = cellTitleColor
        bubbleImageView.addSubview(paymentTitleLabel)
        paymentTitleLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(describeTitleLabel)
            make.top.equalTo()(describeTitleLabel.mas_bottom).with().offset()(18)
        }
        
        _paymentLabel.font = cellTextFont
        _paymentLabel.textColor = cellContentColor
        bubbleImageView.addSubview(_paymentLabel)
        _paymentLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(paymentTitleLabel.mas_right).with().offset()(10)
            make.centerY.equalTo()(paymentTitleLabel)
        }
        
        let deadlineTitleLabel = UILabel()
        deadlineTitleLabel.font = cellTextFont
        deadlineTitleLabel.text = "截止日期"
        deadlineTitleLabel.textColor = cellTitleColor
        bubbleImageView.addSubview(deadlineTitleLabel)
        deadlineTitleLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(describeTitleLabel)
            make.top.equalTo()(paymentTitleLabel.mas_bottom).with().offset()(18)
        }
        
        _deadlineLabel.font = cellTextFont
        _deadlineLabel.textColor = cellContentColor
        bubbleImageView.addSubview(_deadlineLabel)
        _deadlineLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(deadlineTitleLabel.mas_right).with().offset()(10)
            make.centerY.equalTo()(deadlineTitleLabel)
        }
        
        let completeButton = UIButton()
        completeButton.addTarget(self, action: "completeButtonClicked", forControlEvents: .TouchUpInside)
        completeButton.setImage(UIImage(named: "task_finish_button"), forState: .Normal)
        bubbleImageView.addSubview(completeButton)
        completeButton.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(deadlineTitleLabel.mas_bottom).with().offset()(18)
            make.centerX.equalTo()(self.contentView)
        }
    }
}
