//
//  ScheduleBL.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/16.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import Foundation

class ScheduleBL: NSObject {

    //查询所有数据方法
    func readData() -> NSMutableDictionary {
        
        var scheduleDAO = ScheduleDAO.sharedInstance
        var scheduleList = scheduleDAO.findAll()
        var resDict = NSMutableDictionary()
        
        var eventDAO = EventsDAO.sharedInstance
        
        for item in scheduleList {
            
            var schedule = item as! Schedule
            
            var event = eventDAO.findById(schedule.Event!)
            schedule.Event = event
            
            let allKey = resDict.allKeys as NSArray
            
            if allKey.containsObject(schedule.GameDate!) {
                var value = resDict.objectForKey(schedule.GameDate!) as! NSMutableArray
                value.addObject(schedule)
            } else {
                var value = NSMutableArray()
                value.addObject(schedule)
                resDict.setObject(value, forKey: schedule.GameDate!)
            }
        }
        
        return resDict
    }
}