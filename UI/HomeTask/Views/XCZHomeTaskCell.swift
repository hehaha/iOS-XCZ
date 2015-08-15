//
//  XCZHomeTaskCell.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/7.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

private let cellTextFont = UIFont.systemFontOfSize(14)
private let cellContentColor = UIColor.XCZColor(0x000000)
private let cellTitleColor = UIColor.XCZColor(0x626262)

class XCZHomeTaskCell: UITableViewCell {
    
    var decorationImageName: String? {
        didSet {
            if let name = decorationImageName {
                _decorationImageView.image = UIImage(named: name)
            }
        }
    }
    
    private let _decorationImageView = UIImageView()
    private let _describeLabel = UILabel()
    private let _paymentLabel = UILabel()
    private let _deadlineLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        p_setUpView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        p_setUpView()
    }
    
    //MARK: - Private Method
    private func p_setUpView() {
        selectionStyle = .None
        contentView.backgroundColor = UIColor.XCZColor(0xecf0f1)
        
        let bubbleImageView = UIImageView(image: UIImage(named: "task_frame"))
        contentView.addSubview(bubbleImageView)
        bubbleImageView.mas_makeConstraints { (make) -> Void in
            make.edges.equalTo()(self.contentView).with().insets()(UIEdgeInsetsMake(5, 57, 5, 11))
        }
        
        let redLineImageView = UIImageView(image: UIImage(named: "task_line_red"))
        contentView.addSubview(redLineImageView)
        redLineImageView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(self.contentView)
            make.bottom.equalTo()(self.contentView)
            make.left.equalTo()(self.contentView).with().offset()(28)
        }
        
        contentView.addSubview(_decorationImageView)
        _decorationImageView.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(redLineImageView)
            make.centerY.equalTo()(self.contentView)
        }
        
        let describeTitleLabel = UILabel()
        describeTitleLabel.font = cellTextFont
        describeTitleLabel.text = "任务描述"
        describeTitleLabel.textColor = cellTitleColor
        bubbleImageView.addSubview(describeTitleLabel)
        describeTitleLabel.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(bubbleImageView).with().offset()(13)
            make.left.equalTo()(bubbleImageView).with().offset()(28)
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
    }

}
