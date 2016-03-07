//
//  HZTabbarItem.swift
//  TimingBook
//
//  Created by Hexun pro on 15/8/20.
//  Copyright (c) 2015年 Horizon. All rights reserved.
//

import UIKit

class HZTabbarItem: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var button:UIButton?
    var tTarget:AnyObject?
    var tSelect:Selector?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        
    }
    
    private func initUI(){
        self.backgroundColor = UIColor.blackColor()
        button = UIButton(frame: self.bounds)
        self.addSubview(button!)
    }
    
    func addItemTarget(target: AnyObject?, action: Selector, forControlEvents controlEvents: UIControlEvents){
        
        tSelect = action
        tTarget = target
        button?.addTarget( self, action: Selector("doAction:"), forControlEvents: controlEvents)
        
        
    }
    
   func doAction(btn:UIButton){
    
        
        if (tTarget?.isEmpty == false)
        {
            if tTarget!.respondsToSelector(tSelect!) == true
            {
                
            }
        }
        twinkle()
    }
    
}
