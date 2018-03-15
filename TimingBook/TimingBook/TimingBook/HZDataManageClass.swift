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
    
    
    fileprivate func readConfig()
    {
        
        let paths:NSArray = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) as NSArray
        
        let documentDirectory:String = paths[0] as! String
        
        let plistPath:String = documentDirectory+"UIConfig.plist"
        
        let filemanage:FileManager = FileManager.default
        
        if filemanage.fileExists(atPath: plistPath)
        {
            configDict = NSMutableDictionary(contentsOfFile: plistPath)
        }
        else
        {
            filemanage.createFile(atPath: plistPath, contents: nil, attributes: [:])
        }
    }
    
    fileprivate func creatDefaultConfig()
    {
        /*
            
        */
        var dictBoy:NSMutableDictionary = ["tbColor":"",]
        
        
    }
}
