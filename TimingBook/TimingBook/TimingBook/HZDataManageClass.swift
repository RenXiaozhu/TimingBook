//
//  HZDataManageClass.swift
//  TimingBook
//
//  Created by Hexun pro on 15/8/31.
//  Copyright (c) 2015年 Horizon. All rights reserved.
//

import UIKit



class HZDataManageClass: NSObject {
    
    static var manager:HZDataManageClass?
    
    var configDict:NSMutableDictionary?
    
    class func shareDataManager()->HZDataManageClass
    {
        
        if manager == nil
        {
            manager = HZDataManageClass()
            
        }
    
        return manager!
    }
    
    
    
    override init() {
        
        super.init()
        
        readConfig()
    }
    
    
    private func readConfig()
    {
        
        let paths:NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        let documentDirectory:String = paths[0] as! String
        
        let plistPath:String = documentDirectory+"UIConfig.plist"
        
        let filemanage:NSFileManager = NSFileManager.defaultManager()
        
        if filemanage.fileExistsAtPath(plistPath)
        {
            configDict = NSMutableDictionary(contentsOfFile: plistPath)
        }
        else
        {
            filemanage.createFileAtPath(plistPath, contents: nil, attributes: [:])
        }
    }
    
    private func creatDefaultConfig()
    {
        /*
            
        */
        var dictBoy:NSMutableDictionary = ["tbColor":"",]
        
        
    }
}
