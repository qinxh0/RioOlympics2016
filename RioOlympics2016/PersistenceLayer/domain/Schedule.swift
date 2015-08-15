//
//  Schedule.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/11.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import Foundation

class Schedule: NSObject {
    //编号
    var ScheduleID :Int?
    //比赛日期
    var GameDate :String?
    //比赛时间
    var GameTime :String?
    //比赛描述
    var GameInfo :String?
    //比赛项目
    var Event :Events?
}