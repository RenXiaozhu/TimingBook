//
//  HZRefreshView.swift
//  TimingBook
//
//  Created by Hexun pro on 15/8/11.
//  Copyright (c) 2015年 Horizon. All rights reserved.
//

import UIKit

//protocol refreshDataDelegate{
//
//  func refreshViewReloadData(erefreshView refreshView:HZRefreshView)
//    
//}

//MARK:下载完成后发送完成通知

let RefreshDataFinished = "HZRefreshDataFinished"
let RefreshDataError    = "RefreshDataError"

//MARK:刷新状态
enum RefreshDataState: UInt {
    
    case Nomal
    case Prepare
    case Start
    case End
    case Error
    
}


class HZRefreshView: UIView {

//MARK:属性声明
    var bgImage:UIImage?
    var indicatorCircle:UIImageView?
    var tipLabel:UILabel?
    var DataDelegate:NSObject?
    var tableViewDelegate:UIScrollView?
    var offsetValue:CGFloat = 0.0
    var loadData:Selector?
    /*
    * 基本配置
    */
    var duartion :CGFloat = 1.0
    let speed    :CGFloat = CGFloat(MAXFLOAT/4)
    var fromValue:CGFloat = 0.0
    var toValue  :CGFloat = 0.0
    var state             = RefreshDataState.Nomal
    var isDragging    :Bool   = false
    var isDecelerating:Bool   = false
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        self.initUI()
    }
    
//MARK:初始化UI
    func initUI(){
        
        if bgImage == nil
        {
            bgImage = UIImage(named: "")
        }
        
       let bgImgView       = UIImageView(image: bgImage)
           bgImgView.frame = CGRectMake( 0,
                                         0,
                                         self.bounds.width,
                                         self.bounds.height)
           bgImgView.backgroundColor = UIColor.redColor()
//           self.addSubview(bgImgView)

        let trail = UITraitCollection(verticalSizeClass: UIUserInterfaceSizeClass.Compact)

        indicatorCircle = UIImageView(image: UIImage(named:"refreshView", inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection:trail))
        indicatorCircle?.frame  = CGRectMake( 0, 0, 40, 40)
        indicatorCircle?.center = CGPointMake( 60, ScreenHeight-60)
        self.addSubview(indicatorCircle!)
        
        
        tipLabel = UILabel(frame: CGRectMake(ScreenWith/2-60,
                                             ScreenHeight-60, 120, 40))
        tipLabel?.backgroundColor = UIColor.clearColor()
        tipLabel?.font = UIFont.systemFontOfSize(14)
        tipLabel?.text = "刷新完成"
        tipLabel?.hidden = true
        tipLabel?.transform = CGAffineTransformMakeScale(0.1, 0.1)
        self.addSubview(tipLabel!)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("resetRefreshView:"), name: RefreshDataFinished, object: nil)
        
        let value:NSValue = NSValue(CGPoint:tableViewDelegate!.contentOffset)
        
        tableViewDelegate?.setValue( value, forKeyPath: "contentOffset" )
        tableViewDelegate?.addObserver( self ,
                                       forKeyPath: "contentOffset",
                                          options: NSKeyValueObservingOptions.New,
                                          context: nil)
        
    }
    
   
//MARK:监测contentOffset变化
    override func observeValueForKeyPath(keyPath: String?,
                                 ofObject object: AnyObject?,
                                          change: [String : AnyObject]?,
                                         context: UnsafeMutablePointer<Void>)
    {
        
        if keyPath == "contentOffset"
        {
           
            let dict:NSDictionary = change 
            let value:NSValue = dict["new"] as! NSValue
            let contentOffset:CGPoint = value.CGPointValue()
            
            changeRefreshState(econtentOffset: contentOffset)
            
        }
        
    }
    
    func changeRefreshState(econtentOffset contentOffset:CGPoint)
    {
        isDragging = tableViewDelegate!.dragging
        isDecelerating = tableViewDelegate!.decelerating
        
        
        offsetValue = contentOffset.y
        
        if isDragging == true
        {
            state = RefreshDataState.Prepare
            setState()
            
            fromValue = toValue
            toValue = -(offsetValue/100.0)*2.0*(CGFloat(M_PI))
            
            indicatorCircle?.transform = CGAffineTransformMakeRotation(toValue)
            
            print("start refresh dragging")
        }
        else
        {
            if offsetValue > -100
            {
                state = RefreshDataState.Nomal
                setState()
                print("refresh state nomal")
            }
            else
            {
                var animation:CABasicAnimation?  = indicatorCircle?.layer.animationForKey("rotationAnimation") as? CABasicAnimation
                
                if animation == nil
                {
                    animation = CABasicAnimation(keyPath: "transform.rotation.z")
                    animation?.fromValue = CGFloat(0)
                    animation!.toValue = CGFloat(MAXFLOAT)
                    animation!.cumulative = false
                    animation!.fillMode = kCAFillModeForwards
                    animation?.autoreverses = false
                    animation!.duration = NSString(string:"\(speed)").doubleValue*NSString(string:"\(duartion)").doubleValue/2
                    animation!.repeatCount = MAXFLOAT
                    animation!.removedOnCompletion = false
                
                    indicatorCircle?.layer.addAnimation(animation, forKey: "rotationAnimation")
                    
                }
                
                if state == RefreshDataState.Prepare
                {
                    state = RefreshDataState.Start
                    
                    self.setState()
                    
                    if loadData != nil
                    {
                        if (DataDelegate?.respondsToSelector(loadData!) != false)
                        {
                            var viewcontroller
                                =
                                DataDelegate as! UIViewController
                            
                                viewcontroller.targetForAction(loadData!,
                                                               withSender: nil)
                        }
                        
                        UIView.animateWithDuration(0.1,
                        animations:
                        {
                            self.tableViewDelegate?.contentInset
                            =
                            UIEdgeInsetsMake(-self.offsetValue+5, 0, 0, 0)
                        },
                        completion:
                        {finished in
                           UIView.animateWithDuration(0.6,
                           animations:
                           {
                            self.tableViewDelegate?.contentInset
                                =
                                UIEdgeInsetsMake(100, 0, 0, 0)
                           },
                           completion:
                           {finished in
 
                           })
                        
                          })
                        
                         }
                     }
            }
        }
        
        
    }
    
    func setState(){
        
        switch state
        {
        case .Nomal:
            tipLabel?.hidden = true;
            indicatorCircle?.hidden = false;
            indicatorCircle?.layer.removeAnimationForKey("rotationAnimation")
        case .Prepare:
            tipLabel?.hidden = true;
            indicatorCircle?.hidden = false;
        case .Start:
            tipLabel?.hidden = true;
            indicatorCircle?.hidden = false;
        case .End:
            tipLabel?.hidden = false;
            indicatorCircle?.hidden = true;
        case .Error:
            tipLabel?.hidden = false;
            indicatorCircle?.hidden = true;
        default:
            print("refreshView 未设置状态")
        }
    }
    
    /*
    * @description 重置刷新状态
    */
    func resetRefreshView(not:NSNotification)
    {
        if not.name == RefreshDataFinished
        {
            state = RefreshDataState.End
            self.setState()
            UIView.animateWithDuration(0.5,
                animations:
                {
                    self.tipLabel?.text = "刷新完成"
                    self.tipLabel?.transform
                        =
                        CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
                },
                completion:
                {finished in
                    UIView.animateWithDuration(1.0,
                        animations:
                        {
                            self.tableViewDelegate?.contentInset
                                =
                                UIEdgeInsetsMake(0, 0, 0, 0)
                        },
                        completion:
                        {finished in
                           self.state = .Nomal
                           self.setState()
                        })
                    
            })
        }
        
        if not.name == RefreshDataError
        {
            state = .Error
            self.setState()
            UIView.animateWithDuration(0.5,
                animations:
                {
                    self.tipLabel?.text = "加载失败"
                    self.tipLabel?.transform
                        =
                        CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
                },
                completion:
                {finished in
                    UIView.animateWithDuration(1.0,
                        animations:
                        {
                            self.tableViewDelegate?.contentInset
                                =
                                UIEdgeInsetsMake(0, 0, 0, 0)
                        },
                        completion:
                        {finished in
                            self.state = .Error
                            self.setState()
                    })
                    
            })

        }
        
    }

//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

}





extension HZRefreshView{

    
}
