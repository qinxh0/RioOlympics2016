//
//  BusinessLogicLayerTest.swift
//  BusinessLogicLayerTest
//
//  Created by 秦绪海 on 15/8/16.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import UIKit
import XCTest

class EventsBLTests: XCTestCase {
    
    var bl:EventsBL!
    var theEvents: Events!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //创建EventsBL对象
        self.bl = EventsBL()
        //创建Events对象
        self.theEvents = Events()
        self.theEvents.EventName = "test EventName"
        self.theEvents.EventIcon = "test EventIcon"
        self.theEvents.KeyInfo = "test KeyInfo"
        self.theEvents.BasicsInfo = "test BasicsInfo"
        self.theEvents.OlympicInfo = "test OlympicInfo"
        
        //插入测试数据
        let dao = EventsDAO.sharedInstance
        dao.create(self.theEvents)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        //删除测试数据
        self.theEvents.EventID = 41
        let dao = EventsDAO.sharedInstance
        dao.remove(self.theEvents)
        self.bl = nil
        
        super.tearDown()
    }
    
    //测试 按照主键查询数据方法
    func testFindAll() {
        
        let list =  self.bl.readData()
        //断言 查询记录数为1
        XCTAssertEqual(list.count, 41)
        let resEvents:Events = list[40] as! Events
        
        //断言
        XCTAssertEqual(self.theEvents.EventName! ,resEvents.EventName!)
        XCTAssertEqual(self.theEvents.EventIcon! ,resEvents.EventIcon!)
        XCTAssertEqual(self.theEvents.KeyInfo! ,resEvents.KeyInfo!)
        XCTAssertEqual(self.theEvents.BasicsInfo! ,resEvents.BasicsInfo!)
        XCTAssertEqual(self.theEvents.OlympicInfo! ,resEvents.OlympicInfo!)
    }
    
}
