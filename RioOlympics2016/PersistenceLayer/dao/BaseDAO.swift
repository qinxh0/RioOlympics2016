//
//  BaseDAO.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/12.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import Foundation


let DB_FILE_NAME = "app.db"

let writableDBPath = DBHelper.applicationDocumentsDirectoryFile(DB_FILE_NAME)

class BaseDAO :NSObject {
    
    var db:FMDatabase
    
    override init() {
        //初始化数据库
        DBHelper.initDB()
        self.db = DBHelper.getDb()
        
    }
    
    //打开数据酷
    func openDB()->Bool {
        if !self.db.open() {
            self.db.close()
            NSLog("数据库打开失败。")
            return false
        }
        return true
    }
    
    //关闭数据库
    func closeDB() {
        self.db.close()
        NSLog("数据库关闭。")
    }
}