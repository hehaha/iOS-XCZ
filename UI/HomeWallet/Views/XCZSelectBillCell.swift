
//
//  XCZSelectBillCell.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/15.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

class XCZSelectBillCell: UITableViewCell {

    var iconType: BillIconType = .Default {
        didSet {
            if oldValue != iconType {
                _iconImageView.image = UIImage(named: iconType.rawValue)
                _titleLabel.text = iconType.description()
            }
        }
    }
    
    private let _titleLabel = UILabel()
    private let _iconImageView = UIImageView()
        
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        p_setUpView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func p_setUpView() {
        _iconImageView.image = UIImage(named: iconType.rawValue)
        contentView.addSubview(_iconImageView)
        _iconImageView.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(27)
            make.centerY.equalTo()
        }
        
        _titleLabel.font = UIFont.systemFontOfSize(17)
        _titleLabel.text = iconType.description()
        _titleLabel.textColor = UIColor.blackColor()
        contentView.addSubview(_titleLabel)
        _titleLabel.mas_makeConstraints { (make) -> Void in
            make.centerY.equalTo()
            make.left.equalTo()(self._iconImageView.mas_right).with().offset()(16)
        }
        
        let arrowImageView = UIImageView(image: UIImage(named: "cash_in_button"))
        contentView.addSubview(arrowImageView)
        arrowImageView.mas_makeConstraints { (make) -> Void in
            make.centerY.equalTo()
            make.right.equalTo()(-15)
        }
    }
}
