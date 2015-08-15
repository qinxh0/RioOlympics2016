//
//  ScheduleDAO.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/15.
//  Copyright (c) 2015年 qin. All rights reserved.
//


import Foundation

class ScheduleDAO: BaseDAO {
    
    class var sharedInstance: ScheduleDAO {
        struct Static {
            static var instance: ScheduleDAO?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ScheduleDAO()
        }
        
        return Static.instance!
    }
    
    //插入
    func create(model: Schedule) -> Int {
        
        if self.openDB() {
            let sql = "INSERT INTO Schedule (GameDate,GameTime,GameInfo,EventID) VALUES (?,?,?,?);"
            let paramList:[AnyObject] = [
                model.GameDate!,
                model.GameTime!,
                model.GameInfo!,
                model.Event!.EventID!]
            
            //执行sql
            if !self.db.executeUpdate(sql, withArgumentsInArray:paramList) {
                assert(false, "插入数据失败。")
            }
            
            self.closeDB()
        }
        return 0
    }
    
    //删除
    func remove(model: Schedule) -> Int {
        
        if self.openDB() {
            
            //开始事务
            self.db.beginTransaction()
            
            //删除子表Schedule数据sql
            let delScheduleSql = "DELETE from Schedule where ScheduleID=?;"
            let paramList:[AnyObject] = [model.ScheduleID!]
            
            //执行sql
            var flag = self.db.executeUpdate(delScheduleSql, withArgumentsInArray:paramList)
            
            if !flag {
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
    func modify(model: Schedule) -> Int {
        
        if self.openDB() {
            let sql = "UPDATE Schedule set GameDate=?, GameTime=?,GameInfo=?,EventID=? where ScheduleID=?;"
            let paramList:[AnyObject] = [
                model.GameDate!,
                model.GameTime!,
                model.GameInfo!,
                model.Event!.EventID!,
                model.ScheduleID!]
            
            //执行sql
            if !self.db.executeUpdate(sql, withArgumentsInArray:paramList) {
                assert(false, "修改数据失败。")
            }
            
            self.closeDB()
        }
        return 0
    }
    
    //查询所有
    func findAll() -> NSMutableArray {
        var listData = NSMutableArray()
        
        if self.openDB() {
            let sql = "SELECT GameDate,GameTime,GameInfo,EventID,ScheduleID FROM Schedule;"
            let paramList:[AnyObject] = []
            
            //执行sql
            if var res = self.db.executeQuery(sql, withArgumentsInArray: paramList) {
                
                while(res.next()) {
                    
                    var gameDate = res.stringForColumn("GameDate")
                    var gameTime = res.stringForColumn("GameTime")
                    var gameInfo = res.stringForColumn("GameInfo")
                    var eventID = Int(res.intForColumn("EventID"))
                    var scheduleID = Int(res.intForColumn("ScheduleID"))

                    
                    var schedule = Schedule()
                    var event = Events()
                    schedule.Event = event
                    
                    schedule.GameDate = gameDate
                    schedule.GameTime = gameTime
                    schedule.GameInfo = gameInfo
                    schedule.ScheduleID = scheduleID
                    schedule.Event!.EventID = eventID

                    
                    listData.addObject(Schedule)
                }
            }
            
            self.closeDB()
        }
        
        return listData
    }
    
    //根据主键查询
    func findById(model: Schedule) -> Schedule? {
        
        if self.openDB() {
            let sql = "SELECT GameDate,GameTime,GameInfo,EventID,ScheduleID FROM Schedule WHERE ScheduleID=?;"
            let paramList:[AnyObject] = [model.ScheduleID!]
            
            //执行sql
            if var res = self.db.executeQuery(sql, withArgumentsInArray: paramList) {
                
                while(res.next()) {
                    
                    var gameDate = res.stringForColumn("GameDate")
                    var gameTime = res.stringForColumn("GameTime")
                    var gameInfo = res.stringForColumn("GameInfo")
                    var eventID = Int(res.intForColumn("EventID"))
                    var scheduleID = Int(res.intForColumn("ScheduleID"))
                    
                    
                    var schedule = Schedule()
                    var event = Events()
                    schedule.Event = event
                    
                    schedule.GameDate = gameDate
                    schedule.GameTime = gameTime
                    schedule.GameInfo = gameInfo
                    schedule.ScheduleID = scheduleID
                    schedule.Event!.EventID = eventID
                    
                    self.closeDB()
                    return schedule
                }
            }
            
            self.closeDB()
        }
        
        return nil
    }
}
