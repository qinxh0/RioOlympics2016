//
//  PersistenceLayerTests.swift
//  PersistenceLayerTests
//
//  Created by 秦绪海 on 15/8/12.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import UIKit
import XCTest

class EventsDAOTests: XCTestCase {
    
    var dao: EventsDAO!
    var theEvents: Events!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //取得DAO实例
        self.dao = EventsDAO.sharedInstance
        //创建Events对象
        self.theEvents = Events()
        self.theEvents.EventName = "test EventName"
        self.theEvents.EventIcon = "test EventIcon"
        self.theEvents.KeyInfo = "test KeyInfo"
        self.theEvents.BasicsInfo = "test BasicsInfo"
        self.theEvents.OlympicInfo = "test OlympicInfo"
        
        
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
        
        let res = self.dao.create(self.theEvents)
        XCTAssertEqual(res, 0)
    }
    
    //测试按照主见查询
    func test_2_FindById() {
        self.theEvents.EventID = 41
        let resEvents = self.dao.findById(theEvents)
        
        XCTAssertNotNil(resEvents)
        
        XCTAssertEqual(self.theEvents.EventName!, resEvents!.EventName!)
        XCTAssertEqual(self.theEvents.EventIcon!, resEvents!.EventIcon!)
        XCTAssertEqual(self.theEvents.KeyInfo!, resEvents!.KeyInfo!)
        XCTAssertEqual(self.theEvents.BasicsInfo!, resEvents!.BasicsInfo!)
        XCTAssertEqual(self.theEvents.OlympicInfo!, resEvents!.OlympicInfo!)
        
    }
    
    //测试查询所有数据
    func test_3_FindAll() {
        
        let list = self.dao.findAll()
        //断言：查询记录数为1
        XCTAssertEqual(list.count, 41)
    }
    
    //测试修改数据
    func test_4_Modify() {
        self.theEvents.EventID = 41
        self.theEvents.EventName = "modify Name"
        
        var res = self.dao.modify(self.theEvents)
        
        //断言：修改失败
        XCTAssertEqual(res, 0)
        
    }
    
    //测试删除数据
    func test_5_Remove() {
        self.theEvents.EventID = 38
        
        var res = self.dao.remove(self.theEvents)
        //断言：删除失败
        XCTAssertEqual(res, 0)
        
        let resEvents = self.dao.findById(self.theEvents)
        XCTAssertNil(resEvents)
    }
    
    
}
