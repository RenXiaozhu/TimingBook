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
    var timer:    Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        let scale = UIScreen.main.scale
        var name:String = ""
        
        let img:UIImage = UIImage(named: "DefaultImg")!
        LanchImg = UIImageView(image: img)
        LanchImg!.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(LanchImg!)
        
        let ImgWidth:NSLayoutConstraint = NSLayoutConstraint(item: LanchImg!, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute:NSLayoutAttribute.notAnAttribute , multiplier: 1.0, constant: img.size.width)
        LanchImg!.addConstraint(ImgWidth)
        
        let ImgHeight:NSLayoutConstraint = NSLayoutConstraint(item: LanchImg!, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute:NSLayoutAttribute.notAnAttribute , multiplier: 1.0, constant: img.size.height)
        LanchImg!.addConstraint(ImgHeight)
        
        let centerConX:NSLayoutConstraint = NSLayoutConstraint(item: LanchImg!, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute:NSLayoutAttribute.centerX , multiplier: 1.0, constant: 0)
        self.view.addConstraint(centerConX)
    
        let centerConY:NSLayoutConstraint = NSLayoutConstraint(item: LanchImg!, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute:NSLayoutAttribute.centerY , multiplier: 1.0, constant: 0)
        self.view.addConstraint(centerConY)
        
        LanchImg!.image = img
        
        let date:Date = Date(timeIntervalSinceNow: 1.0+8*60*60)
        timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(HZLanchScreenViewController.clear), userInfo: nil, repeats: false)
        RunLoop.current.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
    }

    func clear(){
        
        timer?.invalidate()
        let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        UIView.animate(withDuration: 1.0, animations:
        {
            
            app.startWindow?.alpha = 0.0
        },
        completion:
        {finished in
            app.startWindow?.removeFromSuperview()
        })
    }
    
    override func viewWillAppear(_ animated: Bool)
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
