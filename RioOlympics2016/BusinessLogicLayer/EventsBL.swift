//
//  EventsBL.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/16.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import Foundation

class EventsBL: NSObject {
    
    
    //查询所有数据方法
    func readData() -> NSMutableArray {
        
        var dao = EventsDAO.sharedInstance
        
        return dao.findAll()
    }
}