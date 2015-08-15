//
//  DBHelper.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/14.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import Foundation

class DBHelper: NSObject{
    
    
    //获得沙箱Document目录下全路径
    class func applicationDocumentsDirectoryFile(fileName: String) -> String {
        
        let  documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path = documentDirectory[0].stringByAppendingPathComponent(fileName) as String
        NSLog("path : %@", path)
        
        return path
    }
    
    //获得FMDatabase
    class func getDb() -> FMDatabase {

        //取得沙箱Document目录路径
        var dbFilePath = DBHelper.applicationDocumentsDirectoryFile(DB_FILE_NAME)
        //创建数据库
        let db = FMDatabase(path: dbFilePath)
        
        return db
    }
    
    //获得FMDatabaseQueue
    class func getQueue() -> FMDatabaseQueue {
        
        //取得沙箱Document目录路径
        var dbFilePath = DBHelper.applicationDocumentsDirectoryFile(DB_FILE_NAME)
        //创建数据库
        let queue = FMDatabaseQueue(path: dbFilePath)
        
        return queue
    }
    
    //初始化并加载数据
    class func initDB() {
        
        let configTablePath = NSBundle.mainBundle().pathForResource("DBConfig", ofType : "plist")!
        NSLog("configTablePath = %@",configTablePath)
        
        let configTable = NSDictionary(contentsOfFile : configTablePath)
        
        //从配置文件获得数据版本号
        var dbConfigVersion = configTable?.objectForKey("DB_VERSION") as! NSNumber?
        
        if (dbConfigVersion == nil) {
            dbConfigVersion = NSNumber(integer:0)
        }
        //从数据库DBVersionInfo表记录返回的数据库版本号
        var versionNubmer:Int = DBHelper.dbVersionNubmer()
        
        //版本号不一致
        if dbConfigVersion?.integerValue != versionNubmer {
            let dbFilePath = DBHelper.applicationDocumentsDirectoryFile(DB_FILE_NAME)
            
            var db = DBHelper.getDb()
            
            if db.open() {
                //加载数据到业务表中
                NSLog("数据库升级...")
                let createtablePath = NSBundle.mainBundle().pathForResource("create_load", ofType : "sql")!
                let sql = String(contentsOfFile : createtablePath, encoding : NSUTF8StringEncoding, error:nil)
                
                db.executeStatements(sql)
                
                //把当前版本号写回到文件中
                let usql = String(format:"update  DBVersionInfo set version_number = ?")
                db.executeUpdate(usql, withArgumentsInArray: [dbConfigVersion!.integerValue])
                
                db.close()
            }
        }
        
    }
    
    class func  dbVersionNubmer() -> Int {
        
        var versionNubmer :Int = -1
        
        let dbFilePath = DBHelper.applicationDocumentsDirectoryFile(DB_FILE_NAME)
        var db:FMDatabase = FMDatabase(path: dbFilePath)
        
        if db.open(){
            //不存在创建表
            let sql = "create table if not exists DBVersionInfo (version_number int )"
            db.executeUpdate(sql, withArgumentsInArray: nil)
            
            //执行查询
            let qsql = "select version_number from DBVersionInfo"
            var fmRes = db.executeQuery(qsql, withArgumentsInArray: nil)
            
            if fmRes.next() {
                NSLog("有数据情况")
                versionNubmer = Int(fmRes.intForColumn("version_number"))
                
            } else {
                NSLog("无数据情况")
                //插入初始版本号
                let insertSql = "insert into DBVersionInfo (version_number) values(?)"
                db.executeUpdate(insertSql, withArgumentsInArray: [versionNubmer])
            }
            
            db.close()
        }
        return versionNubmer
    }
    
}
