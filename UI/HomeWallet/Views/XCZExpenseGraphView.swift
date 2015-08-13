//
//  XCZExpenseGraphView.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/13.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

private let viewHeight = 185
private let textLabelFont = UIFont.systemFontOfSize(15)
private let textLabelColor = UIColor.XCZColor(0x626262)
private let leftMargin: CGFloat = 18
private let labelTopMargin: CGFloat = 12
private let barTopMargin: CGFloat = 10
private let barHeight: CGFloat = 15
private let countLabelFont = UIFont.systemFontOfSize(20)
private let countLabelColor = UIColor.XCZColor(0x000000)
//private let barMaxWidth = UIScreen.mainScreen().bounds.width - 

class XCZExpenseGraphView: UIView {
    
    private var _monthProfit: CGFloat = 0.0
    private var _monthExpend: CGFloat = 0.0
    private var _monthBalance: CGFloat {
        return abs(_monthProfit - _monthExpend)
    }
    //收入和支出中较大的一项
    private var _maxCount: CGFloat {
        return _monthExpend > _monthProfit ? _monthExpend : _monthProfit
    }
    private var _layoutHeight = false
    
    init(profit: CGFloat, expend: CGFloat) {
        super.init(frame: CGRectZero)
        _monthProfit = profit
        _monthExpend = profit
        XCZaddTopAndBottomSeparator()
        
        p_setUpView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        p_setUpView()
    }
    
    override func willMoveToWindow(newWindow: UIWindow?) {
        super.willMoveToWindow(newWindow)
        if !_layoutHeight {
            _layoutHeight = true
            mas_updateConstraints { (make) -> Void in
                make.height.equalTo()(viewHeight)
            }
        }
    }
    
    //MARK: Private method
    private func p_setUpView() {
        let profitLabel = UILabel()
        profitLabel.text = "本月收入"
        profitLabel.textColor = textLabelColor
        profitLabel.font = textLabelFont
        addSubview(profitLabel)
        profitLabel.mas_updateConstraints { (make) -> Void in
            make.left.equalTo()(self).with().offset()(leftMargin)
            make.top.equalTo()(self).with().offset()(12)
        }
        
        let profitView = UIView()
        profitView.backgroundColor = UIColor.XCZColor(0x18c2a5)
        addSubview(profitView)
        profitView.mas_updateConstraints { (make) -> Void in
            make.height.equalTo()(barHeight)
            make.left.equalTo()(profitLabel)
            make.top.equalTo()(profitLabel.mas_bottom).with().offset()(barTopMargin)
            make.width.equalTo()(self._maxCount == 0 ? 5 : (self._monthProfit / self._maxCount))
        }
        
        let profitCountLabel = UILabel()
        profitCountLabel.font = countLabelFont
        profitCountLabel.textColor = countLabelColor
        profitCountLabel.text = XCZconvertToCashString(Double(_monthProfit))
        addSubview(profitCountLabel)
        profitCountLabel.mas_makeConstraints { (make) -> Void in
            make.centerY.equalTo()(profitView)
            make.left.equalTo()(profitView.mas_right).with().offset()(10)
        }
        
        let expendLabel = UILabel()
        expendLabel.text = "本月支出"
        expendLabel.textColor = textLabelColor
        expendLabel.font = textLabelFont
        addSubview(expendLabel)
        expendLabel.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(profitView.mas_bottom).with().offset()(labelTopMargin)
            make.left.equalTo()(profitView)
        }
        
        let expendView = UIView()
        expendView.backgroundColor = UIColor.XCZColor(0x2cbbe7)
        addSubview(expendView)
        expendView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(expendLabel.mas_bottom).with().offset()(barTopMargin)
            make.left.equalTo()(expendLabel)
            make.height.equalTo()(barHeight)
            make.width.equalTo()(self._maxCount == 0 ? 5 : (self._monthProfit / self._maxCount))
        }
        
        let expendCountLabel = UILabel()
        expendCountLabel.font = countLabelFont
        expendCountLabel.textColor = countLabelColor
        expendCountLabel.text = XCZconvertToCashString(Double(_monthExpend))
        addSubview(expendCountLabel)
        expendCountLabel.mas_makeConstraints { (make) -> Void in
            make.centerY.equalTo()(expendView)
            make.left.equalTo()(expendView.mas_right).with().offset()(10)
        }
        
        let balanceLabel = UILabel()
        balanceLabel.text = "本月差额"
        balanceLabel.textColor = textLabelColor
        balanceLabel.font = textLabelFont
        addSubview(balanceLabel)
        balanceLabel.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(expendView.mas_bottom).with().offset()(labelTopMargin)
            make.left.equalTo()(expendLabel)
        }
        
        let balanceView = UIView()
        balanceView.backgroundColor = UIColor.XCZColor(0xf6a564)
        addSubview(balanceView)
        balanceView.mas_makeConstraints { (make) -> Void in
            make.top.equalTo()(balanceLabel.mas_bottom).with().offset()(barTopMargin)
            make.height.equalTo()(barHeight)
            make.right.equalTo()(expendView)
            make.left.equalTo()(self._maxCount == 0 ? profitView : profitView.mas_right)
        }

        let balanceCountLabel = UILabel()
        balanceCountLabel.font = countLabelFont
        balanceCountLabel.textColor = countLabelColor
        balanceCountLabel.text = XCZconvertToCashString(Double(_monthBalance))
        addSubview(balanceCountLabel)
        balanceCountLabel.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(balanceView.mas_right).with().offset()(10)
            make.centerY.equalTo()(balanceView)
        }
    }
}
