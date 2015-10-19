//
//  AboutViewController.swift
//  FoodPin
//
//  Created by LiuWei on 15/10/18.
//  Copyright © 2015年 AppCoda. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController {

    @IBAction func sendEmail(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "mailto://1582129083@qq.com")!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
