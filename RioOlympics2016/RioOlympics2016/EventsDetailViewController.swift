//
//  EventsDetailViewController.swift
//  RioOlympics2016
//
//  Created by 秦绪海 on 15/8/17.
//  Copyright (c) 2015年 qin. All rights reserved.
//

import UIKit

class EventsDetailViewController: UIViewController {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var keyInfo: UITextView!
    @IBOutlet weak var BasicsInfo: UITextView!
    @IBOutlet weak var olympicInfo: UITextView!
    
    var event: Events!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.eventImage.image = UIImage(named: event.EventIcon!)
        self.eventName.text = event.EventName!
        self.keyInfo.text = event.KeyInfo!
        self.BasicsInfo.text = event.BasicsInfo!
        self.olympicInfo.text = event.OlympicInfo!
        
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
