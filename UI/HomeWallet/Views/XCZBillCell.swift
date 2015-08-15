//
//  XCZBillCell.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/14.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

private let labelTopMargin: CGFloat = 15
private let typeIconOffset: CGFloat = 10
private let labelTextColor = UIColor.XCZColor(0x626262)
private let contentImageSize = 90

enum BillIconType: String {
    case Dress = "cash_dress"
    case Toy = "cash_toy"
    case Food = "cash_food"
    case Stationary = "cash_wenju"
    case Book = "cash_book"
    case Default = "cash_income_in"
    
    func description() -> String {
        switch self {
        case .Dress: return "服装"
        case .Toy: return "玩具"
        case .Food: return "食品"
        case .Book: return "书籍"
        case .Stationary: return "文具"
        case .Default: return "收入"
        }
    }
}

class XCZBillCell: UITableViewCell {
    
    private let _typeImageView = UIImageView(image: UIImage(named: BillIconType.Default.rawValue))
    private let _describeTitleLabel = UILabel()
    private let _describeLabel = UILabel()
    private let _dateLabel = UILabel()
    private let _profitLabel = UILabel()
    private let _contentImageView = UIImageView()
    private let _separator = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        p_setUpView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectionStyle = .None
        p_setUpView()
    }
    
    //MARK: - Private Method
    private func p_setUpView() {
        let bubbleImageView = UIImageView(image: UIImage(named: "task_unfinished_frame")?.resizableImageWithCapInsets(UIEdgeInsetsMake(5, 5, 5, 5)))
        contentView.addSubview(bubbleImageView)
        bubbleImageView.mas_makeConstraints { (make) -> Void in
            make.edges.equalTo()(self.contentView).with().insets()(UIEdgeInsetsMake(11, 21, 11, 11))
        }
        
        contentView.addSubview(_typeImageView)
        _typeImageView.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(bubbleImageView.mas_left).with().offset()(typeIconOffset)
            make.centerY.equalTo()(bubbleImageView.mas_top).with().offset()(typeIconOffset)
        }
        
        _describeTitleLabel.textColor = labelTextColor
        _describeTitleLabel.text = BillIconType.Default.description()
        _describeTitleLabel.font = UIFont.systemFontOfSize(17)
        bubbleImageView.addSubview(_describeTitleLabel)
        _describeTitleLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self._typeImageView.mas_right).with().offset()(7)
            make.top.equalTo()(bubbleImageView).with().offset()(labelTopMargin)
        }
        
        _describeLabel.textColor = labelTextColor
        //TODO:接口好后删掉
        _describeLabel.text = "打扫卧室"
        _describeLabel.font = UIFont.systemFontOfSize(15)
        bubbleImageView.addSubview(_describeLabel)
        _describeLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self._describeTitleLabel.mas_right).with().offset()(9)
            make.centerY.equalTo()(self._describeTitleLabel)
        }
        
        _dateLabel.font = UIFont.systemFontOfSize(15)
        _dateLabel.textColor = labelTextColor
        //TODO:接口好后删掉
        _dateLabel.text = NSDate().XCZconvertToString()
        bubbleImageView.addSubview(_dateLabel)
        _dateLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self._describeTitleLabel)
            make.top.equalTo()(self._describeTitleLabel.mas_bottom).with().offset()(10)
        }
        
        _profitLabel.font = UIFont.systemFontOfSize(15)
        //TODO:接口好后删掉
        _profitLabel.text = "¥ 12.0"
        _profitLabel.textColor = labelTextColor
        bubbleImageView.addSubview(_profitLabel)
        _profitLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self._dateLabel.mas_right).offset()(35)
            make.centerY.equalTo()(self._dateLabel)
        }
        
        _separator.backgroundColor = UIColor.XCZColor(0xbdc3c7)
        bubbleImageView.addSubview(_separator)
        _separator.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self._dateLabel)
            make.right.equalTo()(bubbleImageView).with().offset()(-11)
            make.top.equalTo()(self._dateLabel.mas_bottom).offset()(10)
            make.height.equalTo()(0.5)
        }
        
        //TODO:接口好后删掉
        _contentImageView.backgroundColor = UIColor.redColor()
        _contentImageView.contentMode = UIViewContentMode.ScaleAspectFill
        bubbleImageView.addSubview(_contentImageView)
        _contentImageView.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self._separator)
            make.height.equalTo()(contentImageSize)
            make.width.equalTo()(contentImageSize)
            make.top.equalTo()(self._separator).with().offset()(11)
        }
    }
}