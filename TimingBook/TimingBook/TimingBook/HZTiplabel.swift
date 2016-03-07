//
//  HZTiplabel.swift
//  TimingBook
//
//  Created by Hexun pro on 15/8/10.
//  Copyright (c) 2015年 Horizon. All rights reserved.
//

import UIKit

class HZTiplabel: UILabel {

    /*
    *  @description 初始化函数
    */
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.font            = UIFont.systemFontOfSize(12)
        self.textAlignment   = NSTextAlignment.Center
        self.textColor       = UIColor.lightGrayColor()
        
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    *  @description 展示动画
    */
    func showSelfWithMessage(message:String)
    {
        var superView:UIView? = self.superview
        
        superview?.bringSubviewToFront(self)
        self.text = message as String
        
        UIView.animateWithDuration( 1.0,
            delay: 2.0,
            options: .CurveEaseInOut,
            animations: {
                
                let rect:CGRect = self.frame
                self.frame = CGRectMake( rect.origin.x+rect.size.width,
                                         rect.origin.y,
                                         rect.size.width,
                                         rect.size.height)
                self.alpha = 1.0
            },
            completion: {finished in
                let rect:CGRect = self.frame
                self.frame = CGRectMake( rect.origin.x-rect.size.width,
                                         rect.origin.y,
                                         rect.size.width,
                                         rect.size.height)
                self.alpha = 0.0
        })
        
    }
}
