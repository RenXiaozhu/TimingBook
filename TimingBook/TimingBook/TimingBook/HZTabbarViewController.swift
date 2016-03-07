//
//  HZTabbarViewController.swift
//  TimingBook
//
//  Created by Hexun pro on 15/8/20.
//  Copyright (c) 2015年 Horizon. All rights reserved.
//

import UIKit


extension NSObject {
    
    
    func hiddenTabbar(){
    
        let app:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let tb:HZTabbarViewController = app.tbController!
        
        tb.TohiddenTabbar()
        
    }
    
    func showTabbar(){
    
        let app:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let tb:HZTabbarViewController = app.tbController!
        
        tb.ToshowTabbar()
        
    }
    
}


class HZTabbarViewController: UITabBarController {

    var isShowIngTabbar:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blackColor()
        
        initViewController()
        addGestuer()
        configTabbarColor()
        
        let item1:HZTabbarItem = HZTabbarItem(frame: CGRectMake(0, 0 , 140, 49))
        item1.button?.setTitle("日记", forState: UIControlState.Normal)
        item1.button?.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), forState: UIControlState.Normal)
        item1 .addItemTarget(self, action: Selector(""), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(item1)
        // Do any additional setup after loading the view.
    }
    
    func initViewController()
    {
        let diary:HZDiaryViewController  = HZDiaryViewController()
        let photo:HZPhotoViewController  = HZPhotoViewController()
        let center:HZCenterViewController = HZCenterViewController()
    
        diary.tabBarItem = UITabBarItem(title: "日记", image: nil, selectedImage: nil)
        photo.tabBarItem = UITabBarItem(title: "相册", image: nil, selectedImage: nil)
        center.tabBarItem = UITabBarItem(title: "个人", image: nil, selectedImage: nil)
        
        self.viewControllers = [diary,photo,center];
    }
    
    func addGestuer()
    {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: Selector("hidOrShowTabbr"))
        tap.numberOfTapsRequired = 2
        tap.enabled = true
        self.view.addGestureRecognizer(tap)
        
        isShowIngTabbar = true
    }
    
    func configTabbarColor()
    {
        
        self.tabBar.backgroundColor = UIColor.ColorWith(ColorString: "#ee82ee")
        self.tabBar.barTintColor = UIColor.ColorWith(ColorString: "#ee82ee")
    
    }
    
    /**
        显示或隐藏tabbar
    */

    func hidOrShowTabbr()
    {
        if isShowIngTabbar == true
        {
            TohiddenTabbar()
        }
        else
        {
            ToshowTabbar()
        }
    }
    
    func TohiddenTabbar()
    {
        
        UIView.animateWithDuration(0.3, animations:
            {
                self.tabBar.frame = CGRectMake(0, ScreenHeight, ScreenWith, 49)
                self.tabBar.alpha = 0.0
            },
            completion:
            {finished in
                
            })
        isShowIngTabbar = false
    }
    
    func ToshowTabbar()
    {
    
        UIView.animateWithDuration(0.3, animations:
            {
                self.tabBar.frame = CGRectMake(0, ScreenHeight-49, ScreenWith, 49)
                self.tabBar.alpha = 1.0
            },
            completion:
            {finished in
                
        })
        isShowIngTabbar = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

