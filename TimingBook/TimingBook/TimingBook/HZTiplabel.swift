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
        self.font            = UIFont.systemFont(ofSize: 12)
        self.textAlignment   = NSTextAlignment.center
        self.textColor       = UIColor.lightGray
        
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    *  @description 展示动画
    */
    func showSelfWithMessage(_ message:String)
    {
        var superView:UIView? = self.superview
        
        superview?.bringSubview(toFront: self)
        self.text = message as String
        
        UIView.animate( withDuration: 1.0,
            delay: 2.0,
            options: UIViewAnimationOptions(),
            animations: {
                
                let rect:CGRect = self.frame
                self.frame = CGRect( x: rect.origin.x+rect.size.width,
                                         y: rect.origin.y,
                                         width: rect.size.width,
                                         height: rect.size.height)
                self.alpha = 1.0
            },
            completion: {finished in
                let rect:CGRect = self.frame
                self.frame = CGRect( x: rect.origin.x-rect.size.width,
                                         y: rect.origin.y,
                                         width: rect.size.width,
                                         height: rect.size.height)
                self.alpha = 0.0
        })
        
    }
}
