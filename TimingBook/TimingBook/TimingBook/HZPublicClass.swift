//
//  HZPublicClass.swift
//  TimingBook
//
//  Created by Hexun pro on 15/8/13.
//  Copyright (c) 2015年 Horizon. All rights reserved.
//

import UIKit

/// 定义常用常量
let ScreenWith = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height


extension NSObject {
    
   func DeLog(_ message:AnyObject){
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
            let rs = aColorString.getSubStringWithRange(((co-6) ..< co-4))
            let gs = aColorString.getSubStringWithRange(((co-4) ..< co-2))
            let bs = aColorString.getSubStringWithRange(((co-2) ..< co))
            let color = aColorString

            var r:UInt32 = 0
            var g:UInt32 = 0
            var b:UInt32 = 0
            
             Scanner(string: rs ).scanHexInt32( &r )
             Scanner(string: gs ).scanHexInt32( &g )
             Scanner(string: bs ).scanHexInt32( &b )
            
            return UIColor(red:   CGFloat(r)/255.0,
                           green: CGFloat(g)/255.0,
                           blue:  CGFloat(b)/255.0,
                           alpha: 1.0)
        }

        return UIColor.clear
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
        
        return UIColor.clear
    }
}

// MARK: - extension String->subString
extension String {
    
    func getSubStringWithRange(_ aRange:Range<Int>)->String
    {
        let ran = (self.characters.index(self.startIndex, offsetBy: aRange.lowerBound) ..< self.characters.index(self.startIndex, offsetBy: aRange.upperBound))
        
        return self.substring(with: ran)
    }
    
}

class HZPublicClass: NSObject {
 

    
}
