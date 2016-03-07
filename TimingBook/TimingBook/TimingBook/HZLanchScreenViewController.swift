//
//  HZLanchScreenViewController.swift
//  TimingBook
//
//  Created by Hexun pro on 15/8/24.
//  Copyright (c) 2015年 Horizon. All rights reserved.
//

import UIKit

class HZLanchScreenViewController: UIViewController {
    
    var LanchImg: UIImageView?
    var timer:    NSTimer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        let scale = UIScreen.mainScreen().scale
        var name:String = ""
        
        let img:UIImage = UIImage(named: "DefaultImg")!
        LanchImg = UIImageView(image: img)
        LanchImg!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(LanchImg!)
        
        let ImgWidth:NSLayoutConstraint = NSLayoutConstraint(item: LanchImg!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute:NSLayoutAttribute.NotAnAttribute , multiplier: 1.0, constant: img.size.width)
        LanchImg!.addConstraint(ImgWidth)
        
        let ImgHeight:NSLayoutConstraint = NSLayoutConstraint(item: LanchImg!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute:NSLayoutAttribute.NotAnAttribute , multiplier: 1.0, constant: img.size.height)
        LanchImg!.addConstraint(ImgHeight)
        
        let centerConX:NSLayoutConstraint = NSLayoutConstraint(item: LanchImg!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute:NSLayoutAttribute.CenterX , multiplier: 1.0, constant: 0)
        self.view.addConstraint(centerConX)
    
        let centerConY:NSLayoutConstraint = NSLayoutConstraint(item: LanchImg!, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute:NSLayoutAttribute.CenterY , multiplier: 1.0, constant: 0)
        self.view.addConstraint(centerConY)
        
        LanchImg!.image = img
        
        let date:NSDate = NSDate(timeIntervalSinceNow: 1.0+8*60*60)
        timer =  NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("clear"), userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSDefaultRunLoopMode)
    }

    func clear(){
        
        timer?.invalidate()
        let app:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        UIView.animateWithDuration(1.0, animations:
        {
            
            app.startWindow?.alpha = 0.0
        },
        completion:
        {finished in
            app.startWindow?.removeFromSuperview()
        })
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
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
