//
//  HZDiaryViewController.swift
//  TimingBook
//
//  Created by Hexun pro on 15/8/20.
//  Copyright (c) 2015年 Horizon. All rights reserved.
//

import UIKit

class HZDiaryViewController: HZRootViewController {

    var tableViewx:UITableView?
    var bookFace:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var data:HZFMDatabase = HZFMDatabase()
        
        let im:UIImage = UIImage(named: "DefaultImg")!
        
        bookFace = UIImageView(image: im)
//        bookFace!.userInteractionEnabled = true
        bookFace!.frame = CGRect(x: 0, y: 0, width: im.size.width, height: im.size.height)
        self.view .addSubview(bookFace!)
        
        
        //        UIView.appearanceForTraitCollection(UITraitCollection(verticalSizeClass:.Compact)).tintColor = UIColor.redColor()
        //        UIView.appearanceForTraitCollection(UITraitCollection(verticalSizeClass:.Regular)).tintColor = UIColor.greenColor()
        
        // Do any additional setup after loading the view, typically from a nib.
    }


     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        
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
