
//
//  XCZBankCountView.swift
//  iOS-XCZ
//
//  Created by 何鑫 on 15/8/7.
//  Copyright (c) 2015年 小财主. All rights reserved.
//

import UIKit

private let graphLeftMargin: CGFloat = 15
private let graphRightMargin: CGFloat = 15
private let barLeftMargin: CGFloat = 42
private let barRightMargin: CGFloat = 48
private let barWidth: CGFloat = 25
private let moneyLabelBottomMargin: CGFloat = 5

class XCZBankCountView: UIView {
    
    var bankAmountModel: XCZBankAccountModel? {
        didSet {
            if let model = bankAmountModel {
                _yesterdayProfit = model.dayIncome?.doubleValue ?? 0
                _weekProfit = model.weekIncome?.doubleValue ?? 0
                _monthProfit = model.monthIncome?.doubleValue ?? 0
                _totalProfit = model.totalIncome?.doubleValue ?? 0
                p_updateUI()
            }
        }
    }
    
    private var _yesterdayProfit = 0.0
    private let _yesterdayTopLabel = UILabel()
    private let _yesterdayBarView = UIView()
    
    private var _weekProfit = 0.0
    private let _weekBarView = UIView()
    private let _weekTopLabel = UILabel()
    
    private var _monthProfit = 0.0
    private let _monthTopLabel = UILabel()
    private let _monthBarView = UIView()
    
    private var _totalProfit = 0.0
    private let _totalBarView = UIView()
    private let _totalTopLabel = UILabel()
    
    private let _leftGraLine = UIView()
    private let _bottomGraLine = UIView()
    
    init(bankModel: XCZBankAccountModel? = nil) {
        super.init(frame: CGRectZero)
        if let model = bankModel {
            _yesterdayProfit = model.dayIncome?.doubleValue ?? 0
            _weekProfit = model.weekIncome?.doubleValue ?? 0
            _monthProfit = model.monthIncome?.doubleValue ?? 0
            _totalProfit = model.totalIncome?.doubleValue ?? 0
        }
        
        p_initView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        p_initView()
    }
    
    private func p_initView() {
        XCZaddTopAndBottomSeparator()
        
        _leftGraLine.backgroundColor = UIColor.XCZColor(0xbdc3c7)
        addSubview(_leftGraLine)
        _leftGraLine.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self).with().offset()(graphLeftMargin)
            make.width.equalTo()(1)
            make.top.equalTo()(self).with().offset()(25)
            make.bottom.equalTo()(self).with().offset()(-42)
        }
        
        _bottomGraLine.backgroundColor = UIColor.XCZColor(0xbdc3c7)
        addSubview(_bottomGraLine)
        _bottomGraLine.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self).with().offset()(graphLeftMargin)
            make.top.equalTo()(self._leftGraLine.mas_bottom)
            make.height.equalTo()(1)
            make.right.equalTo()(self).with().offset()(-graphRightMargin)
        }
        
        _totalBarView.backgroundColor = UIColor.XCZColor(0xf6a564)
        addSubview(_totalBarView)
        
        _yesterdayBarView.backgroundColor = UIColor.XCZColor(0x18c2a5)
        addSubview(_yesterdayBarView)
        _yesterdayBarView.mas_makeConstraints { (make) -> Void in
            make.bottom.equalTo()(self._bottomGraLine)
            make.left.equalTo()(self._leftGraLine.mas_right).with().offset()(barLeftMargin)
            make.width.equalTo()(barWidth)
            if self._totalProfit == 0 {
                make.height.equalTo()(self._totalBarView)
            }
            else {
                make.height.equalTo()(self._totalBarView).with().multipliedBy()(CGFloat(self._yesterdayProfit / self._totalProfit))
            }
        }
        
        let yesterdayBottomLabel = UILabel()
        yesterdayBottomLabel.font = UIFont.systemFontOfSize(12)
        yesterdayBottomLabel.text = "昨日收益"
        yesterdayBottomLabel.textColor = UIColor.XCZColor(0x626262)
        addSubview(yesterdayBottomLabel)
        yesterdayBottomLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(self._yesterdayBarView)
            make.top.equalTo()(self._bottomGraLine.mas_bottom).with().offset()(5)
        }
        
        _yesterdayTopLabel.textColor = UIColor.XCZColor(0x000000)
        _yesterdayTopLabel.font = UIFont.systemFontOfSize(11)
        _yesterdayTopLabel.text = "¥ " + XCZconvertToCashString(_yesterdayProfit)
        addSubview(_yesterdayTopLabel)
        _yesterdayTopLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(self._yesterdayBarView)
            make.bottom.equalTo()(self._yesterdayBarView.mas_top).with().offset()(-moneyLabelBottomMargin)
        }
        
        _totalBarView.mas_makeConstraints { (make) -> Void in
            make.right.equalTo()(self._bottomGraLine).with().offset()(-barRightMargin)
            make.width.equalTo()(barWidth)
            make.bottom.equalTo()(self._bottomGraLine)
            if self._totalProfit == 0 {
                make.top.equalTo()(self._bottomGraLine).with().offset()(-5)
            }
            else {
                make.top.equalTo()(self._leftGraLine).with().offset()(15)
            }
        }
        
        let totalBottomLabel = UILabel()
        totalBottomLabel.font = UIFont.systemFontOfSize(12)
        totalBottomLabel.textColor = UIColor.XCZColor(0x626262)
        totalBottomLabel.text = "累计收益"
        addSubview(totalBottomLabel)
        totalBottomLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(self._totalBarView)
            make.top.equalTo()(yesterdayBottomLabel)
        }
        
        _totalTopLabel.textColor = UIColor.XCZColor(0x000000)
        _totalTopLabel.text = "¥ " + XCZconvertToCashString(_totalProfit)
        _totalTopLabel.font = UIFont.systemFontOfSize(11)
        addSubview(_totalTopLabel)
        _totalTopLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(self._totalBarView)
            make.bottom.equalTo()(self._totalBarView.mas_top).with().offset()(-moneyLabelBottomMargin)
        }
        
        let firstHelpView = UIView()
        addSubview(firstHelpView)
        firstHelpView.mas_makeConstraints {(make) -> Void in
            make.left.equalTo()(self._yesterdayBarView.mas_right)
            make.bottom.equalTo()(self._bottomGraLine)
            make.top.equalTo()(self._leftGraLine).with().offset()(15)
        }
        
        _weekBarView.backgroundColor = UIColor.XCZColor(0xf95f50)
        addSubview(_weekBarView)
        _weekBarView.mas_makeConstraints { (make) -> Void in
            make.bottom.equalTo()(self._bottomGraLine)
            make.left.equalTo()(firstHelpView.mas_right)
            make.width.equalTo()(barWidth)
            if self._totalProfit == 0 {
                make.height.equalTo()(self._totalBarView)
            }
            else {
                make.height.equalTo()(self._totalBarView).with().multipliedBy()(CGFloat(self._weekProfit / self._totalProfit))
            }
        }
        
        _weekTopLabel.textColor = UIColor.XCZColor(0x000000)
        _weekTopLabel.font = UIFont.systemFontOfSize(11)
        _weekTopLabel.text = "¥ " + XCZconvertToCashString(_weekProfit)
        addSubview(_weekTopLabel)
        _weekTopLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(self._weekBarView)
            make.bottom.equalTo()(self._weekBarView.mas_top).with().offset()(-moneyLabelBottomMargin)
        }
        
        let weekBottomLabel = UILabel()
        weekBottomLabel.font = UIFont.systemFontOfSize(12)
        weekBottomLabel.textColor = UIColor.XCZColor(0x626262)
        weekBottomLabel.text = "本周收益"
        addSubview(weekBottomLabel)
        weekBottomLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(self._weekBarView)
            make.top.equalTo()(yesterdayBottomLabel)
        }
        
        let secondHelpView = UIView()
        addSubview(secondHelpView)
        secondHelpView.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self._weekBarView.mas_right)
            make.bottom.equalTo()(self._bottomGraLine)
            make.top.equalTo()(self._leftGraLine).with().offset()(15)
            make.width.equalTo()(firstHelpView)
        }

        _monthBarView.backgroundColor = UIColor.XCZColor(0x2cbbe7)
        addSubview(_monthBarView)
        _monthBarView.mas_makeConstraints { (make) -> Void in
            make.bottom.equalTo()(self._bottomGraLine)
            make.left.equalTo()(secondHelpView.mas_right)
            make.width.equalTo()(barWidth)
            if self._totalProfit == 0 {
                make.height.equalTo()(self._totalBarView)
            }
            else {
                make.height.equalTo()(self._totalBarView).with().multipliedBy()(CGFloat(self._monthProfit / self._totalProfit))
            }
        }
        
        _monthTopLabel.text = "¥ " + XCZconvertToCashString(_monthProfit)
        _monthTopLabel.textColor = UIColor.XCZColor(0x000000)
        _monthTopLabel.font = UIFont.systemFontOfSize(11)
        addSubview(_monthTopLabel)
        _monthTopLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(self._monthBarView)
            make.bottom.equalTo()(self._monthBarView.mas_top).with().offset()(-moneyLabelBottomMargin)
        }
        
        let monthBottomLabel = UILabel()
        monthBottomLabel.font = UIFont.systemFontOfSize(12)
        monthBottomLabel.text = "本月收益"
        monthBottomLabel.textColor = UIColor.XCZColor(0x626262)
        addSubview(monthBottomLabel)
        monthBottomLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(self._monthBarView)
            make.top.equalTo()(yesterdayBottomLabel)
        }
        
        let thirdHelpView = UIView()
        addSubview(thirdHelpView)
        thirdHelpView.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self._monthBarView.mas_right)
            make.right.equalTo()(self._totalBarView.mas_left)
            make.bottom.equalTo()(self._bottomGraLine)
            make.top.equalTo()(self._leftGraLine).with().offset()(15)
            make.width.equalTo()(firstHelpView)
        }
    }
    
    private func p_updateUI() {
        _yesterdayTopLabel.text = "¥ " + XCZconvertToCashString(_yesterdayProfit)
        _weekTopLabel.text = "¥ " + XCZconvertToCashString(_weekProfit)
        _monthTopLabel.text = "¥ " + XCZconvertToCashString(_monthProfit)
        _totalTopLabel.text = "¥ " + XCZconvertToCashString(_totalProfit)
        
        for c in constraints() as! [NSLayoutConstraint] {
            //去除之前对各个视图height的约束
            if c.firstItem as? NSObject == _yesterdayBarView && c.firstAttribute == .Height {
                c.active = false
            }
            
            if c.firstItem as? NSObject == _weekBarView && c.firstAttribute == .Height {
                c.active = false
            }
            
            if c.firstItem as? NSObject == _monthBarView && c.firstAttribute == .Height {
                c.active = false
            }
            
            if c.firstItem as? NSObject == _totalBarView && c.firstAttribute == .Top {
                c.active = false
            }
        }

        _totalBarView.mas_makeConstraints { (make) -> Void in
            if self._totalProfit == 0 {
                make.top.equalTo()(self._bottomGraLine).with().offset()(-5)
            }
            else {
                make.top.equalTo()(self._leftGraLine).with().offset()(15)
            }
        }
        
        _yesterdayBarView.mas_makeConstraints { (make) -> Void in
            if self._totalProfit == 0 {
                make.height.equalTo()(self._totalBarView)
            }
            else {
                make.height.equalTo()(self._totalBarView).with().multipliedBy()(CGFloat(self._yesterdayProfit / self._totalProfit))
            }
        }

        _weekBarView.mas_makeConstraints { (make) -> Void in
            if self._totalProfit == 0 {
                make.height.equalTo()(self._totalBarView)
            }
            else {
                make.height.equalTo()(self._totalBarView).with().multipliedBy()(CGFloat(self._weekProfit / self._totalProfit))
            }
        }

        _monthBarView.mas_makeConstraints { (make) -> Void in
            if self._totalProfit == 0 {
                make.height.equalTo()(self._totalBarView)
            }
            else {
                make.height.equalTo()(self._totalBarView).with().multipliedBy()(CGFloat(self._monthProfit / self._totalProfit))
            }
        }

        setNeedsLayout()
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.layoutIfNeeded()
        })
    }
}
