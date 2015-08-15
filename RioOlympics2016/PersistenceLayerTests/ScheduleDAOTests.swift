//
//  ScheduleDAOTests.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/15.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import Foundation


import UIKit
import XCTest

class ScheduleDAOTests: XCTestCase {
    
    var dao: ScheduleDAO!
    var theSchedule: Schedule!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //取得DAO实例
        self.dao = ScheduleDAO.sharedInstance
        //创建Schedule对象
        self.theSchedule = Schedule()
        self.theSchedule.GameDate = "test GameDate"
        self.theSchedule.GameTime = "test GameTime"
        self.theSchedule.GameInfo = "test GameInfo"
        var event = Events()
        event.EventID = 1
        self.theSchedule.Event = event
        
        
    }
    
    override func tearDown() {
        self.dao = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //测试代码
    func test_1_code() {
        let configTablePath = NSBundle.mainBundle().pathForResource("DBConfig", ofType : "plist")!
        NSLog("configTablePath = %@",configTablePath)
    }
    
    //测试插入
    func test_1_Create() {
        
        let res = self.dao.create(self.theSchedule)
        XCTAssertEqual(res, 0)
    }
    
    //测试按照主见查询
    func test_2_FindById() {
        self.theSchedule.ScheduleID = 502
        let resSchedule = self.dao.findById(theSchedule)
        
        XCTAssertNotNil(resSchedule)
        
        //断言
        XCTAssertEqual(self.theSchedule!.GameDate!, resSchedule!.GameDate!)
        XCTAssertEqual(self.theSchedule!.GameTime!, resSchedule!.GameTime!)
        XCTAssertEqual(self.theSchedule!.GameInfo!, resSchedule!.GameInfo!)
        XCTAssertEqual(self.theSchedule!.Event!.EventID!, resSchedule!.Event!.EventID!)
        
    }
    
    //测试查询所有数据
    func test_3_FindAll() {
        
        let list = self.dao.findAll()
        //断言：查询记录数为1
        XCTAssertEqual(list.count, 502)
        
//        let resSchedule:Schedule = list[501] as! Schedule
//        
//        //断言
//        XCTAssertEqual(self.theSchedule!.GameDate!, resSchedule.GameDate!)
//        XCTAssertEqual(self.theSchedule!.GameTime!, resSchedule.GameTime!)
//        XCTAssertEqual(self.theSchedule!.GameInfo!, resSchedule.GameInfo!)
//        XCTAssertEqual(self.theSchedule!.Event!.EventID!, resSchedule.Event!.EventID!)
    }
    
    //测试修改数据
    func test_4_Modify() {
        self.theSchedule.ScheduleID = 502
        self.theSchedule.GameInfo = "test modify GameInfo"
        
        let res = self.dao.modify(self.theSchedule)
        //断言 无异常，返回值为0
        XCTAssert(res == 0)
        
        let resSchedule = self.dao.findById(self.theSchedule)
        //断言 查询结果非nil
        XCTAssertNotNil(resSchedule)
        //断言
        XCTAssertEqual(self.theSchedule!.GameDate!, resSchedule!.GameDate!)
        XCTAssertEqual(self.theSchedule!.GameTime!, resSchedule!.GameTime!)
        XCTAssertEqual(self.theSchedule!.GameInfo!, resSchedule!.GameInfo!)
        XCTAssertEqual(self.theSchedule!.Event!.EventID!, resSchedule!.Event!.EventID!)
        
    }
    
    //测试删除数据
    func test_5_Remove() {
        self.theSchedule.ScheduleID = 502
        let res = self.dao.remove(self.theSchedule)
        //断言 无异常，返回值为0
        XCTAssert(res == 0)
        
        let resSchedule = self.dao.findById(self.theSchedule)
        //断言 查询结果nil
        XCTAssertNil(resSchedule)
    }
    
    
}
