//
//  CountDownViewController.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/17.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import UIKit

class CountDownViewController: UIViewController {

    @IBOutlet weak var countDownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 创建NSDateComponents对象
        let comps = NSDateComponents()
        comps.day = 5
        comps.month = 8
        comps.year = 2016
        
        // 创建日历对象
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        // 获取2016-08-05日历对象
        let destinationDate = calendar?.dateFromComponents(comps)
        // 获取当前日期
        let date = NSDate()
        // 获取当前日期到2016-08-05的Componenets对象
        let components = calendar!.components(NSCalendarUnit.CalendarUnitDay, fromDate: date, toDate: destinationDate!, options: nil)
        // 取得相差天数
        let days = components.day
        // 设置到空间
        countDownLabel.text = String(format: "%i天", days)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
