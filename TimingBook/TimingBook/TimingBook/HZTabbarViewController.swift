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
    
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let tb:HZTabbarViewController = app.tbController!
        
        tb.TohiddenTabbar()
        
    }
    
    func showTabbar(){
    
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let tb:HZTabbarViewController = app.tbController!
        
        tb.ToshowTabbar()
        
    }
    
}


class HZTabbarViewController: UITabBarController {

    var isShowIngTabbar:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black
        
        initViewController()
        addGestuer()
        configTabbarColor()
        
        let item1:HZTabbarItem = HZTabbarItem(frame: CGRect(x: 0, y: 0 , width: 140, height: 49))
        item1.button?.setTitle("日记", for: UIControlState())
        item1.button?.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: UIControlState())
        item1 .addItemTarget(self, action: Selector(""), forControlEvents: UIControlEvents.touchUpInside)
        self.view.addSubview(item1)
        // Do any additional setup after loading the view.
    }
    
    func initViewController()
    {
        let diary:HZDiaryViewController  = HZDiaryViewController(coder: <#NSCoder#>)!
        let photo:HZPhotoViewController  = HZPhotoViewController(coder: <#NSCoder#>)!
        let center:HZCenterViewController = HZCenterViewController(coder: <#NSCoder#>)!
    
        diary.tabBarItem = UITabBarItem(title: "日记", image: nil, selectedImage: nil)
        photo.tabBarItem = UITabBarItem(title: "相册", image: nil, selectedImage: nil)
        center.tabBarItem = UITabBarItem(title: "个人", image: nil, selectedImage: nil)
        
        self.viewControllers = [diary,photo,center];
    }
    
    func addGestuer()
    {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(HZTabbarViewController.hidOrShowTabbr))
        tap.numberOfTapsRequired = 2
        tap.isEnabled = true
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
        
        UIView.animate(withDuration: 0.3, animations:
            {
                self.tabBar.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWith, height: 49)
                self.tabBar.alpha = 0.0
            },
            completion:
            {finished in
                
            })
        isShowIngTabbar = false
    }
    
    func ToshowTabbar()
    {
    
        UIView.animate(withDuration: 0.3, animations:
            {
                self.tabBar.frame = CGRect(x: 0, y: ScreenHeight-49, width: ScreenWith, height: 49)
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

