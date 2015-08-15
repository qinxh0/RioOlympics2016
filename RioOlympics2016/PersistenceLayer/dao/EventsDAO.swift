//
//  EventsDAO.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/12.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import Foundation

class EventsDAO: BaseDAO {
    
    //对应表中字段
    let EVENT_ID = "EventID"
    let EVENT_NAME = "EventName"
    let EVGENT_ICON = "EventIcon"
    let KEY_INFO = "KeyInfo"
    let BASICS_INFO = "BasicsInfo"
    let OLYPIC_INFO = "OlympicInfo"
    
    
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
            let sql = "INSERT INTO Events (?,?,?,?,?) VALUES (?,?,?,?,?)"
            let paramList:[AnyObject] = [
                EVENT_NAME,
                EVGENT_ICON,
                KEY_INFO,
                BASICS_INFO,
                OLYPIC_INFO,
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
            let sql = "DELETE  from Schedule where ?=?"
            let paramList:[AnyObject] = [
                EVENT_ID,
                model.EventID!.description]
            
            //执行sql
            if !self.db.executeUpdate(sql, withArgumentsInArray:paramList) {
                assert(false, "删除数据失败。")
            }
            
            self.closeDB()
        }
        return 0
    }
    
    //修改
    func modify(model: Events) -> Int {
        
        if self.openDB() {
            let sql = "UPDATE Events set ?=?, ?=?,?=?,?=?,?=? where ?=?"
            let paramList:[AnyObject] = [
                EVENT_NAME,
                model.EventName!,
                EVGENT_ICON,
                model.EventIcon!,
                KEY_INFO,
                model.KeyInfo!,
                BASICS_INFO,
                model.BasicsInfo!,
                OLYPIC_INFO,
                model.OlympicInfo!,
                EVENT_ID,
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
            let sql = "SELECT ?,?,?,?,?,? FROM Events"
            let paramList:[AnyObject] = [
                EVENT_NAME,
                EVGENT_ICON,
                KEY_INFO,
                BASICS_INFO,
                OLYPIC_INFO,
                EVENT_ID]
            
            //执行sql
            if var res = self.db.executeQuery(sql, withArgumentsInArray: paramList) {
                
                while(res.next()) {
                    
                    var eventName = res.stringForColumn(EVENT_NAME)
                    var eventIcon = res.stringForColumn(EVGENT_ICON)
                    var keyInfo = res.stringForColumn(KEY_INFO)
                    var basicsInfo = res.stringForColumn(BASICS_INFO)
                    var olypicInfo = res.stringForColumn(OLYPIC_INFO)
                    var eventId = Int(res.intForColumn(EVENT_ID))
                    
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
            let sql = "SELECT ?,?,?,?,?,? FROM Events WHERE ?=?"
            let paramList:[AnyObject] = [
                EVENT_NAME,
                EVGENT_ICON,
                KEY_INFO,
                BASICS_INFO,
                OLYPIC_INFO,
                EVENT_ID,
                EVENT_ID,
                model.EventID!]
            
            //执行sql
            if var res = self.db.executeQuery(sql, withArgumentsInArray: paramList) {
                
                while(res.next()) {
                    
                    var eventName = res.stringForColumn(EVENT_NAME)
                    var eventIcon = res.stringForColumn(EVGENT_ICON)
                    var keyInfo = res.stringForColumn(KEY_INFO)
                    var basicsInfo = res.stringForColumn(BASICS_INFO)
                    var olypicInfo = res.stringForColumn(OLYPIC_INFO)
                    var eventId = Int(res.intForColumn(EVENT_ID))
                    
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
