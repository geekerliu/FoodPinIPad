//
//  WebViewController.swift
//  FoodPin
//
//  Created by LiuWei on 15/10/18.
//  Copyright © 2015年 AppCoda. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = NSURL(string: "http://www.baidu.com") {
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
