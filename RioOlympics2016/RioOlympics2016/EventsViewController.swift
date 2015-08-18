//
//  EventsViewController.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/17.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"
var COL_COUNT = 2

class EventsViewController: UICollectionViewController {

    var events: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        
        // ipad每行显示5条记录
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            COL_COUNT = 5
        }
        
        var bl = EventsBL()
        // 获取全部数据
        events = bl.readData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            
            let indexPaths = self.collectionView!.indexPathsForSelectedItems()  as! [NSIndexPath]
            let indexPath: NSIndexPath = indexPaths[0]
            
            let event = self.events.objectAtIndex(indexPath.section * COL_COUNT + indexPath.row) as! Events
            
            var detailVC = segue.destinationViewController as! EventsDetailViewController
            detailVC.event = event
            
        }
        
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return events.count/COL_COUNT
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return COL_COUNT
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! EventsViewCell
    
        // Configure the cell
        var event = events.objectAtIndex(indexPath.section*COL_COUNT+indexPath.row) as! Events
        cell.imageView.image = UIImage(named: event.EventIcon!)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
