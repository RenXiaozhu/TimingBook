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
    
    case nomal
    case prepare
    case start
    case end
    case error
    
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
    var state             = RefreshDataState.nomal
    var isDragging    :Bool   = false
    var isDecelerating:Bool   = false
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.initUI()
    }
    
//MARK:初始化UI
    func initUI(){
        
        if bgImage == nil
        {
            bgImage = UIImage(named: "")
        }
        
       let bgImgView       = UIImageView(image: bgImage)
           bgImgView.frame = CGRect( x: 0,
                                         y: 0,
                                         width: self.bounds.width,
                                         height: self.bounds.height)
           bgImgView.backgroundColor = UIColor.red
//           self.addSubview(bgImgView)

        let trail = UITraitCollection(verticalSizeClass: UIUserInterfaceSizeClass.compact)

        indicatorCircle = UIImageView(image: UIImage(named:"refreshView", in: Bundle.main, compatibleWith:trail))
        indicatorCircle?.frame  = CGRect( x: 0, y: 0, width: 40, height: 40)
        indicatorCircle?.center = CGPoint( x: 60, y: ScreenHeight-60)
        self.addSubview(indicatorCircle!)
        
        
        tipLabel = UILabel(frame: CGRect(x: ScreenWith/2-60,
                                             y: ScreenHeight-60, width: 120, height: 40))
        tipLabel?.backgroundColor = UIColor.clear
        tipLabel?.font = UIFont.systemFont(ofSize: 14)
        tipLabel?.text = "刷新完成"
        tipLabel?.isHidden = true
        tipLabel?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.addSubview(tipLabel!)
        
        NotificationCenter.default.addObserver(self, selector:#selector(HZRefreshView.resetRefreshView(_:)), name: NSNotification.Name(rawValue: RefreshDataFinished), object: nil)
        
        let value:NSValue = NSValue(cgPoint:tableViewDelegate!.contentOffset)
        
        tableViewDelegate?.setValue( value, forKeyPath: "contentOffset" )
        tableViewDelegate?.addObserver( self ,
                                       forKeyPath: "contentOffset",
                                          options: NSKeyValueObservingOptions.new,
                                          context: nil)
        
    }
    
   
//MARK:监测contentOffset变化
    override func observeValue(forKeyPath keyPath: String?,
                                 of object: Any?,
                                          change: [NSKeyValueChangeKey : Any]?,
                                         context: UnsafeMutableRawPointer?)
    {
        
        if keyPath == "contentOffset"
        {
           
            let dict:NSDictionary = change! as! NSDictionary 
            let value:NSValue = dict["new"] as! NSValue
            let contentOffset:CGPoint = value.cgPointValue
            
            changeRefreshState(econtentOffset: contentOffset)
            
        }
        
    }
    
    func changeRefreshState(econtentOffset contentOffset:CGPoint)
    {
        isDragging = tableViewDelegate!.isDragging
        isDecelerating = tableViewDelegate!.isDecelerating
        
        
        offsetValue = contentOffset.y
        
        if isDragging == true
        {
            state = RefreshDataState.prepare
            setState()
            
            fromValue = toValue
            toValue = -(offsetValue/100.0)*2.0*(CGFloat(M_PI))
            
            indicatorCircle?.transform = CGAffineTransform(rotationAngle: toValue)
            
            print("start refresh dragging")
        }
        else
        {
            if offsetValue > -100
            {
                state = RefreshDataState.nomal
                setState()
                print("refresh state nomal")
            }
            else
            {
                var animation:CABasicAnimation?  = indicatorCircle?.layer.animation(forKey: "rotationAnimation") as? CABasicAnimation
                
                if animation == nil
                {
                    animation = CABasicAnimation(keyPath: "transform.rotation.z")
                    animation?.fromValue = CGFloat(0)
                    animation!.toValue = CGFloat(MAXFLOAT)
                    animation!.isCumulative = false
                    animation!.fillMode = kCAFillModeForwards
                    animation?.autoreverses = false
                    animation!.duration = NSString(string:"\(speed)").doubleValue*NSString(string:"\(duartion)").doubleValue/2
                    animation!.repeatCount = MAXFLOAT
                    animation!.isRemovedOnCompletion = false
                
                    indicatorCircle?.layer.add(animation!, forKey!,: "rotationAnimation")
                    
                }
                
                if state == RefreshDataState.prepare
                {
                    state = RefreshDataState.start
                    
                    self.setState()
                    
                    if loadData != nil
                    {
                        if (DataDelegate?.responds(to: loadData!) != false)
                        {
                            let viewcontroller
                                =
                                DataDelegate as! UIViewController
                            
                                viewcontroller.target(forAction: loadData!,
                                                               withSender: nil)
                        }
                        
                        UIView.animate(withDuration: 0.1,
                        animations:
                        {
                            self.tableViewDelegate?.contentInset
                            =
                            UIEdgeInsetsMake(-self.offsetValue+5, 0, 0, 0)
                        },
                        completion:
                        {finished in
                           UIView.animate(withDuration: 0.6,
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
        case .nomal:
            tipLabel?.isHidden = true;
            indicatorCircle?.isHidden = false;
            indicatorCircle?.layer.removeAnimation(forKey: "rotationAnimation")
        case .prepare:
            tipLabel?.isHidden = true;
            indicatorCircle?.isHidden = false;
        case .start:
            tipLabel?.isHidden = true;
            indicatorCircle?.isHidden = false;
        case .end:
            tipLabel?.isHidden = false;
            indicatorCircle?.isHidden = true;
        case .error:
            tipLabel?.isHidden = false;
            indicatorCircle?.isHidden = true;
        default:
            print("refreshView 未设置状态")
        }
    }
    
    /*
    * @description 重置刷新状态
    */
    func resetRefreshView(_ not:Notification)
    {
        if not.name == RefreshDataFinished
        {
            state = RefreshDataState.end
            self.setState()
            UIView.animate(withDuration: 0.5,
                animations:
                {
                    self.tipLabel?.text = "刷新完成"
                    self.tipLabel?.transform
                        =
                        CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                },
                completion:
                {finished in
                    UIView.animate(withDuration: 1.0,
                        animations:
                        {
                            self.tableViewDelegate?.contentInset
                                =
                                UIEdgeInsetsMake(0, 0, 0, 0)
                        },
                        completion:
                        {finished in
                           self.state = .nomal
                           self.setState()
                        })
                    
            })
        }
        
        if not.name == RefreshDataError
        {
            state = .error
            self.setState()
            UIView.animate(withDuration: 0.5,
                animations:
                {
                    self.tipLabel?.text = "加载失败"
                    self.tipLabel?.transform
                        =
                        CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                },
                completion:
                {finished in
                    UIView.animate(withDuration: 1.0,
                        animations:
                        {
                            self.tableViewDelegate?.contentInset
                                =
                                UIEdgeInsetsMake(0, 0, 0, 0)
                        },
                        completion:
                        {finished in
                            self.state = .error
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
