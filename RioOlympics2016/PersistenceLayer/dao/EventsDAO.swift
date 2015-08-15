//
//  EventsDAO.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/12.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import Foundation

class EventsDAO: BaseDAO {
    
    class var sharedInstance: EventsDAO {
        struct Static {
            static var instance: EventsDAO?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = EventsDAO()
        }
        
        return Static.instance!
    }
    
    //插入
    func create(model: Events) -> Int {
        
        if self.openDB() {
            let sql = "INSERT INTO Events (EventName,EventIcon,KeyInfo,BasicsInfo,OlympicInfo) VALUES (?,?,?,?,?);"
            let paramList:[AnyObject] = [
                model.EventName!,
                model.EventIcon!,
                model.KeyInfo!,
                model.BasicsInfo!,
                model.OlympicInfo!]
            
            //执行sql
            if !self.db.executeUpdate(sql, withArgumentsInArray:paramList) {
                assert(false, "插入数据失败。")
            }
            
            self.closeDB()
        }
        return 0
    }
    
    //删除
    func remove(model: Events) -> Int {
        
        if self.openDB() {
            
            //开始事务
            self.db.beginTransaction()
            
            //删除子表Schedule数据sql
            let delScheduleSql = "DELETE from Schedule where EventID=?;"
            //删除父表Events数据sql
            let delEventsSql = "DELETE from Events where EventID=?;"
            let paramList:[AnyObject] = [model.EventID!]
            
            //执行sql
            var flag1 = self.db.executeUpdate(delScheduleSql, withArgumentsInArray:paramList)
            var flag2 = self.db.executeUpdate(delEventsSql, withArgumentsInArray:paramList)
            
            if !flag1 || !flag2 {
                self.db.rollback()
                assert(false, "删除数据失败。")
            } else {
                self.db.commit()
            }
            
            self.closeDB()
        }
        return 0
    }
    
    //修改
    func modify(model: Events) -> Int {
        
        if self.openDB() {
            let sql = "UPDATE Events set EventName=?, EventIcon=?,KeyInfo=?,BasicsInfo=?,OlympicInfo=? where EventID=?;"
            let paramList:[AnyObject] = [
                model.EventName!,
                model.EventIcon!,
                model.KeyInfo!,
                model.BasicsInfo!,
                model.OlympicInfo!,
                model.EventID!]
            
            //执行sql
            if !self.db.executeUpdate(sql, withArgumentsInArray:paramList) {
                assert(false, "插入数据失败。")
            }
            
            self.closeDB()
        }
        return 0
    }
    
    //查询所有
    func findAll() -> NSMutableArray {
        var listData = NSMutableArray()
        
        if self.openDB() {
            let sql = "SELECT EventName,EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID FROM Events;"
            let paramList:[AnyObject] = []
            
            //执行sql
            if var res = self.db.executeQuery(sql, withArgumentsInArray: paramList) {
                
                while(res.next()) {
                    
                    var eventName = res.stringForColumn("EventName")
                    var eventIcon = res.stringForColumn("EventIcon")
                    var keyInfo = res.stringForColumn("KeyInfo")
                    var basicsInfo = res.stringForColumn("BasicsInfo")
                    var olypicInfo = res.stringForColumn("OlympicInfo")
                    var eventId = Int(res.intForColumn("EventID"))
                    
                    var events = Events()
                    events.EventName = eventName
                    events.EventIcon = eventIcon
                    events.KeyInfo = keyInfo
                    events.BasicsInfo = basicsInfo
                    events.OlympicInfo = olypicInfo
                    events.EventID = eventId
                    
                    listData.addObject(events)
                }
            }
            
            self.closeDB()
        }
        
        return listData
    }
    
    //根据主键查询
    func findById(model: Events) -> Events? {
        
        if self.openDB() {
            let sql = "SELECT EventName,EventIcon,KeyInfo,BasicsInfo,OlympicInfo,EventID FROM Events WHERE EventID=?;"
            let paramList:[AnyObject] = [model.EventID!]
            
            //执行sql
            if var res = self.db.executeQuery(sql, withArgumentsInArray: paramList) {
                
                while(res.next()) {
                    
                    var eventName = res.stringForColumn("EventName")
                    var eventIcon = res.stringForColumn("EventIcon")
                    var keyInfo = res.stringForColumn("KeyInfo")
                    var basicsInfo = res.stringForColumn("BasicsInfo")
                    var olypicInfo = res.stringForColumn("OlympicInfo")
                    var eventId = Int(res.intForColumn("EventID"))
                    
                    var events = Events()
                    events.EventName = eventName
                    events.EventIcon = eventIcon
                    events.KeyInfo = keyInfo
                    events.BasicsInfo = basicsInfo
                    events.OlympicInfo = olypicInfo
                    events.EventID = eventId
                    
                    self.closeDB()
                    return events
                }
            }
            
            self.closeDB()
        }
        
        return nil
    }
}
