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
    
    private var _yesterdayProfit = 0.0
    private var _weekProfit = 0.0
    private var _monthProfit = 0.0
    private var _totalProfit = 0.0
    
    init(profitArr: [Double]) {
        super.init(frame: CGRectZero)
        if profitArr.count >= 4 {
            _yesterdayProfit = profitArr[0]
            _weekProfit = profitArr[1]
            _monthProfit = profitArr[2]
            _totalProfit = profitArr[3]
        }
        
        p_initView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        p_initView()
    }
    
    private func p_initView() {
        XCZaddTopAndBottomSeparator()
        
        let leftGraLine = UIView()
        leftGraLine.backgroundColor = UIColor.XCZColor(0xbdc3c7)
        addSubview(leftGraLine)
        leftGraLine.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self).with().offset()(graphLeftMargin)
            make.width.equalTo()(1)
            make.top.equalTo()(self).with().offset()(25)
            make.bottom.equalTo()(self).with().offset()(-42)
        }
        
        let bottomGraLine = UIView()
        bottomGraLine.backgroundColor = UIColor.XCZColor(0xbdc3c7)
        addSubview(bottomGraLine)
        bottomGraLine.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(self).with().offset()(graphLeftMargin)
            make.top.equalTo()(leftGraLine.mas_bottom)
            make.height.equalTo()(1)
            make.right.equalTo()(self).with().offset()(-graphRightMargin)
        }
        
        let totalBarView = UIView()
        totalBarView.backgroundColor = UIColor.XCZColor(0xf6a564)
        addSubview(totalBarView)
        
        let yesterdayBarView = UIView()
        yesterdayBarView.backgroundColor = UIColor.XCZColor(0x18c2a5)
        addSubview(yesterdayBarView)
        yesterdayBarView.mas_makeConstraints { (make) -> Void in
            make.bottom.equalTo()(bottomGraLine)
            make.left.equalTo()(leftGraLine.mas_right).with().offset()(barLeftMargin)
            make.width.equalTo()(barWidth)
            if self._totalProfit == 0 {
                make.height.equalTo()(totalBarView)
            }
            else {
                make.height.equalTo()(totalBarView).with().multipliedBy()(CGFloat(self._yesterdayProfit / self._totalProfit))
            }
        }
        
        let yesterdayBottomLabel = UILabel()
        yesterdayBottomLabel.font = UIFont.systemFontOfSize(12)
        yesterdayBottomLabel.text = "昨日收益"
        yesterdayBottomLabel.textColor = UIColor.XCZColor(0x626262)
        addSubview(yesterdayBottomLabel)
        yesterdayBottomLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(yesterdayBarView)
            make.top.equalTo()(bottomGraLine.mas_bottom).with().offset()(5)
        }
        
        let yesterdayTopLabel = UILabel()
        yesterdayTopLabel.textColor = UIColor.XCZColor(0x000000)
        yesterdayTopLabel.font = UIFont.systemFontOfSize(11)
        yesterdayTopLabel.text = "¥ " + XCZconvertToCashString(_yesterdayProfit)
        addSubview(yesterdayTopLabel)
        yesterdayTopLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(yesterdayBarView)
            make.bottom.equalTo()(yesterdayBarView.mas_top).with().offset()(-moneyLabelBottomMargin)
        }
        
        totalBarView.mas_makeConstraints { (make) -> Void in
            make.right.equalTo()(bottomGraLine).with().offset()(-barRightMargin)
            make.width.equalTo()(barWidth)
            make.bottom.equalTo()(bottomGraLine)
            if self._totalProfit == 0 {
                make.top.equalTo()(bottomGraLine).with().offset()(-5)
            }
            else {
                make.top.equalTo()(leftGraLine).with().offset()(15)
            }
        }
        
        let totalBottomLabel = UILabel()
        totalBottomLabel.font = UIFont.systemFontOfSize(12)
        totalBottomLabel.textColor = UIColor.XCZColor(0x626262)
        totalBottomLabel.text = "累计收益"
        addSubview(totalBottomLabel)
        totalBottomLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(totalBarView)
            make.top.equalTo()(yesterdayBottomLabel)
        }
        
        let totalTopLabel = UILabel()
        totalTopLabel.textColor = UIColor.XCZColor(0x000000)
        totalTopLabel.text = "¥ " + XCZconvertToCashString(_totalProfit)
        totalTopLabel.font = UIFont.systemFontOfSize(11)
        addSubview(totalTopLabel)
        totalTopLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(totalBarView)
            make.bottom.equalTo()(totalBarView.mas_top).with().offset()(-moneyLabelBottomMargin)
        }
        
        let firstHelpView = UIView()
        addSubview(firstHelpView)
        firstHelpView.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(yesterdayBarView.mas_right)
            make.bottom.equalTo()(bottomGraLine)
            make.top.equalTo()(leftGraLine).with().offset()(15)
        }
        
        let weekBarView = UIView()
        weekBarView.backgroundColor = UIColor.XCZColor(0xf95f50)
        addSubview(weekBarView)
        weekBarView.mas_makeConstraints { (make) -> Void in
            make.bottom.equalTo()(bottomGraLine)
            make.left.equalTo()(firstHelpView.mas_right)
            make.width.equalTo()(barWidth)
            if self._totalProfit == 0 {
                make.height.equalTo()(totalBarView)
            }
            else {
                make.height.equalTo()(totalBarView).with().multipliedBy()(CGFloat(self._weekProfit / self._totalProfit))
            }
        }
        
        let weekTopLabel = UILabel()
        weekTopLabel.textColor = UIColor.XCZColor(0x000000)
        weekTopLabel.font = UIFont.systemFontOfSize(11)
        weekTopLabel.text = "¥ " + XCZconvertToCashString(_weekProfit)
        addSubview(weekTopLabel)
        weekTopLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(weekBarView)
            make.bottom.equalTo()(weekBarView.mas_top).with().offset()(-moneyLabelBottomMargin)
        }
        
        let weekBottomLabel = UILabel()
        weekBottomLabel.font = UIFont.systemFontOfSize(12)
        weekBottomLabel.textColor = UIColor.XCZColor(0x626262)
        weekBottomLabel.text = "本周收益"
        addSubview(weekBottomLabel)
        weekBottomLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(weekBarView)
            make.top.equalTo()(yesterdayBottomLabel)
        }
        
        let secondHelpView = UIView()
        addSubview(secondHelpView)
        secondHelpView.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(weekBarView.mas_right)
            make.bottom.equalTo()(bottomGraLine)
            make.top.equalTo()(leftGraLine).with().offset()(15)
            make.width.equalTo()(firstHelpView)
        }
        
        let monthBarView = UIView()
        monthBarView.backgroundColor = UIColor.XCZColor(0x2cbbe7)
        addSubview(monthBarView)
        monthBarView.mas_makeConstraints { (make) -> Void in
            make.bottom.equalTo()(bottomGraLine)
            make.left.equalTo()(secondHelpView.mas_right)
            make.width.equalTo()(barWidth)
            if self._totalProfit == 0 {
                make.height.equalTo()(totalBarView)
            }
            else {
                make.height.equalTo()(totalBarView).with().multipliedBy()(CGFloat(self._monthProfit / self._totalProfit))
            }
        }
        
        let monthTopLabel = UILabel()
        monthTopLabel.text = "¥ " + XCZconvertToCashString(_monthProfit)
        monthTopLabel.textColor = UIColor.XCZColor(0x000000)
        monthTopLabel.font = UIFont.systemFontOfSize(11)
        addSubview(monthTopLabel)
        monthTopLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(monthBarView)
            make.bottom.equalTo()(monthBarView.mas_top).with().offset()(-moneyLabelBottomMargin)
        }
        
        let monthBottomLabel = UILabel()
        monthBottomLabel.font = UIFont.systemFontOfSize(12)
        monthBottomLabel.text = "本月收益"
        monthBottomLabel.textColor = UIColor.XCZColor(0x626262)
        addSubview(monthBottomLabel)
        monthBottomLabel.mas_makeConstraints { (make) -> Void in
            make.centerX.equalTo()(monthBarView)
            make.top.equalTo()(yesterdayBottomLabel)
        }
        
        let thirdHelpView = UIView()
        addSubview(thirdHelpView)
        thirdHelpView.mas_makeConstraints { (make) -> Void in
            make.left.equalTo()(monthBarView.mas_right)
            make.right.equalTo()(totalBarView.mas_left)
            make.bottom.equalTo()(bottomGraLine)
            make.top.equalTo()(leftGraLine).with().offset()(15)
            make.width.equalTo()(firstHelpView)
        }
    }
}
