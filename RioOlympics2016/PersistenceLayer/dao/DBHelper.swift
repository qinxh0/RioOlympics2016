//
//  DBHelper.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/14.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import Foundation

class DBHelper : NSObject{
    
    //数据库版本号
    static let VERSION_NUMBER = "version_number"
    
    //获得沙箱Document目录下全路径
    class func applicationDocumentsDirectoryFile(fileName: String) -> String {
        
        let  documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path = documentDirectory[0].stringByAppendingPathComponent(fileName) as String
        NSLog("path : %@", path)
        
        return path
    }
    
    //获得FMDatabase
    class func getDb()->FMDatabase{

        //取得沙箱Document目录路径
        var dbFilePath = DBHelper.applicationDocumentsDirectoryFile(DB_FILE_NAME)
        //创建数据库
        let db = FMDatabase(path: dbFilePath)
        
        return db
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
                let usql = String(format:"update  DBVersionInfo set ? = ?")
                db.executeUpdate(usql, withArgumentsInArray: [VERSION_NUMBER,dbConfigVersion!.integerValue])
                
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
            let sql = "create table if not exists DBVersionInfo ( ? int )"
            db.executeUpdate(sql, withArgumentsInArray: [VERSION_NUMBER])
            
            //执行查询
            let qsql = "select ? from DBVersionInfo"
            var fmRes = db.executeQuery(qsql, withArgumentsInArray: [VERSION_NUMBER])
            
            if fmRes.next() {
                NSLog("有数据情况")
                versionNubmer = Int(fmRes.intForColumn(VERSION_NUMBER))
                
            } else {
                NSLog("无数据情况")
                //插入初始版本号
                let insertSql = "insert into DBVersionInfo (?) values(?)"
                db.executeUpdate(insertSql, withArgumentsInArray: [VERSION_NUMBER,versionNubmer])
            }
            
            db.close()
        }
        return versionNubmer
    }
    
}
