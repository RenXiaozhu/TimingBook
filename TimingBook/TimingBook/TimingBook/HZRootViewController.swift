//
//  HZRootViewController.swift
//  TimingBook
//
//  Created by Hexun pro on 15/8/10.
//  Copyright (c) 2015年 Horizon. All rights reserved.
//

import UIKit

class HZRootViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?){
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
         self.initUI()
       
    }

   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
   lazy var tipLabel:HZTiplabel = {
        
       if self.view.viewWithTag(1111) == nil
       {
        var tipLabel:HZTiplabel  = HZTiplabel(frame: CGRectMake(-150, 400, 150, 30))
        tipLabel.numberOfLines   = 1;
        tipLabel.backgroundColor = UIColor.clearColor()
        tipLabel.font            = UIFont.systemFontOfSize(14)
        tipLabel.tag             = 1111
        return tipLabel
    }
        return self.view.viewWithTag(1111) as!HZTiplabel
    }()
    
    var Indicator:UIActivityIndicatorView?
    
    var refreshView:HZRefreshView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    refreshView = HZRefreshView(frame: CGRectMake(0, -736, 414, 736))
    refreshView!.DataDelegate = self
    refreshView!.tableViewDelegate = UITableView()
        // Do any additional setup after loading the view.
    }

    
    /*
    * @description 初始化UI控件
    */
    func initUI()
    {
        
        self.view.addSubview(self.tipLabel)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}
