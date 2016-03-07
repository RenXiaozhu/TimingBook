//
//  HZPublicClass.swift
//  TimingBook
//
//  Created by Hexun pro on 15/8/13.
//  Copyright (c) 2015年 Horizon. All rights reserved.
//

import UIKit

/// 定义常用常量
let ScreenWith = UIScreen.mainScreen().bounds.width
let ScreenHeight = UIScreen.mainScreen().bounds.height


extension NSObject {
    
   func DeLog(message:AnyObject){
        debugPrint(message)
    }
    
}


// MARK: - extension UIColor
extension UIColor
{
    
    class func ColorWith(ColorString aColorString:String) ->UIColor {

        if aColorString.hasPrefix("#") || aColorString.hasPrefix("0x")
        {
            let co = aColorString.characters.count
            let rs = aColorString.getSubStringWithRange(Range(start: co-6, end: co-4))
            let gs = aColorString.getSubStringWithRange(Range(start: co-4, end: co-2))
            let bs = aColorString.getSubStringWithRange(Range(start: co-2, end: co))
            
            var r:UInt32 = 0
            var g:UInt32 = 0
            var b:UInt32 = 0
            
             NSScanner(string: rs ).scanHexInt( &r )
             NSScanner(string: gs ).scanHexInt( &g )
             NSScanner(string: bs ).scanHexInt( &b )
            
            return UIColor(red:   CGFloat(r)/255.0,
                           green: CGFloat(g)/255.0,
                           blue:  CGFloat(b)/255.0,
                           alpha: 1.0)
        }
        
        return UIColor.clearColor()
    }
    
    class func ColorWith16Value(ColorString aColor:UInt) ->UIColor {
    
        let str:String = String(aColor)
        if str.hasPrefix("0x")
        {
            let r = aColor & 0xFF0000
            let g = aColor & 0x00FF00
            let b = aColor & 0x0000FF
            
            return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
        }
        
        return UIColor.clearColor()
    }
    
    
    
}

// MARK: - extension String->subString
extension String {
    
    func getSubStringWithRange(aRange:Range<Int>)->String
    {
        let ran = Range( start: self.startIndex.advancedBy(aRange.startIndex), end: self.startIndex.advancedBy(aRange.endIndex))
        
        return self.substringWithRange(ran)
    }
    
}

class HZPublicClass: NSObject {
 

    
}
