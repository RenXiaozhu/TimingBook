//
//  HZFMDatabase.swift
//  TimingBook
//
//  Created by Hexun pro on 15/8/17.
//  Copyright (c) 2015年 Horizon. All rights reserved.
//

import UIKit

class HZFMDatabase: NSObject {
   
    var dbpath:String?
    var database:OpaquePointer? = nil
    
    func initWith(_ dbString:String)
    {
        dbpath = dbString
        
        if dbpath == nil
        {
            DeLog("path不能为空")
        }
        
    }
    
    /**
    打开数据库
    
    - parameter dbname: 数据库路径
    
    - returns: 是否打开成功
    */
    func openDataBase()->Bool{
        
        let openDatabaseResult = sqlite3_open( dbpath!.cString(using: String.Encoding.utf8)!, &database )
        let result:Bool        = printResultwith( openDatabaseResult,
                                                  methodName: "sqlite3_open" )
        
        DeLog(dbpath!)
        
        return result
    }
    
    /**
    创建表格
    
    - parameter tableName: 表格名称
    - parameter fields:    表格属性
    
    - returns: 是否创建成功
    */
    func creatTable(_ tableName:String,fields:NSDictionary)->Bool
    {
    
        let error:UnsafeMutablePointer<UnsafeMutablePointer<Int8>> = UnsafeMutablePointer(bitPattern: 0)!
        
        
        let handle:String = creatTableHandle(tableName, fields: fields)
        
        let resultInt:Int32 = sqlite3_exec(database, handle, nil, nil,error)
        
        let result:Bool = printResultwith(resultInt, methodName: "sqlite3_exec")
        
        if result == false
        {
            DeLog(error.debugDescription)
        }
        
        return result
    }
    
    
    /**
    创建表格句柄
    
    - parameter tableName: 表格名称
    - parameter fields:    表格属性
    
    - returns: 返回句柄
    */
    fileprivate func creatTableHandle(_ tableName:String,
                                  fields:NSDictionary)->String
    {
        var handleString:String = "creat table if not exist \(tableName)"
        
        for i in 0  ..< fields.count 
        {
            let key:String   = fields.allKeys[i] as! String
            let value:String = fields.value(forKey: key) as! String
            
            if i == 0
            {
                handleString = handleString+"("+"\(key) \(value)"+","
            }
            else
            {
                if i == (fields.count-1)
                {
                    handleString = handleString+"\(key) \(value)"+")"
                }
                else
                {
                    handleString = handleString+"\(key) \(value)"+","
                }
            }
        }
        

        return handleString
    }
    
    fileprivate func creatSearchSqliteHandle( _ tableName:String,
                                          condition:String,
                                          andOther:String)->String
    {
        
        let handle:String = "select * from \(tableName) where \(condition) \(andOther)"
        
        return handle
    }
    
    
    //MARK:打印错误日志
    fileprivate func printResultwith( _ resultData:Int32 ,
                                  methodName:String)->Bool{
        
        switch resultData{

        case SQLITE_OK:
           DeLog(methodName+"成功\nSuccessful result")
           return true
            
        case SQLITE_ERROR:
            DeLog(methodName+"SQL 错误 或者 database 缺失\nSQL error or missing database")
            return false
            
        case SQLITE_INTERNAL:
            DeLog(methodName+"SQLite 内部逻辑错误\nInternal logic error in SQLite")
            return false
            
        case SQLITE_PERM:
            DeLog(methodName+"没有访问权限\nAccess permission denied")
            return false
            
        case SQLITE_ABORT:
            DeLog(methodName+"回调程序未实现或缺失\nCallback routine requested an abort")
            return false
            
        case SQLITE_BUSY:
            DeLog(methodName+"数据库文件已锁 \nThe database file is locked")
            return false
            
        case SQLITE_LOCKED:
            DeLog(methodName+"数据表被已锁 \nA table in the database is locked")
            return false
        
        case SQLITE_NOMEM:
            DeLog(methodName+"请求内存空间失败\n A malloc() failed")
            return false
        
        case SQLITE_READONLY:
            DeLog(methodName+"试图将数据写入只读数据库\nAttempt to write a readonly database")
            return false
            
        case SQLITE_INTERRUPT:
            DeLog(methodName+"操作被sqlite3_interrupt()终止\n Operation terminated by sqlite3_interrupt()")
            return false
            
        case SQLITE_IOERR:
            DeLog(methodName+"发生磁盘I/O错误\n Some kind of disk I/O error occurred")
            return false
            
        case SQLITE_CORRUPT:
            DeLog(methodName+"数据库磁盘映像是畸形的\nThe database disk image is malformed")
            return false
            
        case SQLITE_NOTFOUND:
            DeLog(methodName+"未知的sqlite语句\n Unknown opcode in sqlite3_file_control()")
            return false
            
        case SQLITE_FULL:
            DeLog(methodName+"插入失败 因为数据库已满\n Insertion failed because database is full")
            return false
            
        case SQLITE_CANTOPEN:
            DeLog(methodName+"无法打开数据库文件\n Unable to open the database file")
            return false
            
        case SQLITE_PROTOCOL:
            DeLog(methodName+"数据库锁定协议错误\n Database lock protocol error")
            return false
            
        case SQLITE_EMPTY:
            DeLog(methodName+"数据库没有数据\n Database is empty")
            return false
            
        case SQLITE_SCHEMA:
            DeLog(methodName+"数据库模式改变\n The database schema changed")
            return false
            
        case SQLITE_TOOBIG:
            DeLog(methodName+"字符串或blob超过大小限制\n String or BLOB exceeds size limit")
            return false
            
        case SQLITE_CONSTRAINT:
            DeLog(methodName+"终止由于违反约束条件\n Abort due to constraint violation")
            return false
            
        case SQLITE_MISMATCH:
            DeLog(methodName+"数据类型不匹配\n Data type mismatch")
            return false
        
        case SQLITE_MISUSE:
            DeLog(methodName+"Library 使用不当\n Library used incorrectly")
            return false
            
        case SQLITE_NOLFS:
            DeLog(methodName+"在主机上使用了不支持的OS框架\n  Uses OS features not supported on host")
            return false
           
        case SQLITE_AUTH:
            DeLog(methodName+"授权被拒\n  Authorization denied")
            return false
            
        case SQLITE_FORMAT:
            DeLog(methodName+"辅助数据库格式错误\n  Auxiliary database format error")
            return false
            
        case SQLITE_RANGE:
            DeLog(methodName+"sqlite3_bind第二个参数越界\n  2nd parameter to sqlite3_bind out of range")
            return false
            
        case SQLITE_NOTADB:
            DeLog(methodName+"打开文件不是数据库文件\n  File opened that is not a database file")
            return false
            
        case SQLITE_NOTICE:
            DeLog(methodName+"来自sqlite3_log()的通知\n  Notifications from sqlite3_log()")
            return false
            
        case SQLITE_WARNING:
            DeLog(methodName+"来自sqlite3_log()的警告\n  Warnings from sqlite3_log()")
            return false
            
        case SQLITE_ROW:
            DeLog(methodName+"sqlite3_step()已经有一个线程准备好\n  sqlite3_step() has another row ready ")
            return false
            
        case SQLITE_DONE:
            DeLog(methodName+"sqlite3_step()已经执行完成\n  sqlite3_step() has finished executing")
            return false
            
        default:
            return false
        }

    
    }
    
}
