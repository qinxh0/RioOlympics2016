//
//  ScheduleViewController.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/17.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import UIKit

class ScheduleViewController: UITableViewController {

    // 数据
    var data: NSDictionary!
    // 日期集合
    var gameDateList: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var bl = ScheduleBL()
        // 获取数据
        self.data = bl.readData()
        // 取得日期集合
        let keys = self.data.allKeys as NSArray
        // 日期集合排序
        self.gameDateList = keys.sortedArrayUsingSelector("compare:") as NSArray
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.gameDateList.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        // 比赛日期
        let gameDate = self.gameDateList[section] as! String
        
        // 比赛日期下的比赛日程表
        let schedules = self.data.objectForKey(gameDate) as! NSArray
        
        return schedules.count
    }

    override func  tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 比赛日期
        let gameDate = self.gameDateList[section] as! String
        return gameDate
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        // 比赛日期
        let gameDate = self.gameDateList[indexPath.section] as! String
        
        // 比赛日期下的比赛日程表
        let schedules = self.data.objectForKey(gameDate) as! NSArray
        
        // 比赛日程
        let schedule = schedules[indexPath.row] as! Schedule
        
        // 描述
        let des = String(format: "%@ | %@", schedule.GameInfo!, schedule.Event!.EventName!)
        
        cell.textLabel?.text = schedule.GameTime
        cell.detailTextLabel?.text = des
        
        return cell
    }

    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        
        var titleList = [AnyObject]()
        
        for item in self.gameDateList {
            let title = (item as! NSString).substringFromIndex(5)
            titleList.append(title)
        }
        
        return titleList
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
