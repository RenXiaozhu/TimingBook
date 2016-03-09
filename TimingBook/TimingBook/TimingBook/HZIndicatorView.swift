//
//  HZIndicatorView.swift
//  TimingBook
//
//  Created by Hexun pro on 15/8/11.
//  Copyright (c) 2015年 Horizon. All rights reserved.
//

import UIKit

class HZIndicatorView: UIView {

    /*
    * @description 指示器
    */
    var indicator:UIActivityIndicatorView?
    /*
    * @description 文字提示
    */
    var textIndicat:UILabel?
    
    /*
    * @description 初始化
    */
    
    init(baseframe:CGRect)
    {
       let rect = UIScreen.mainScreen().bounds
       
       super.init(frame: CGRectMake(rect.width/2-50, rect.height/2-50, 100, 100))
       self.initUI()
    }
    
    
    func initUI(){
        
        self.backgroundColor = UIColor()
    }
    

    func loadData(){
    
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
