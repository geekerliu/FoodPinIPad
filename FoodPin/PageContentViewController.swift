//
//  PageContentViewController.swift
//  FoodPin
//
//  Created by LiuWei on 15/10/18.
//  Copyright © 2015年 AppCoda. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var headingLabel:UILabel!
    @IBOutlet weak var subHeadingLabel:UILabel!
    @IBOutlet weak var contentImageView:UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    var index: Int = 0
    var heading: String = ""
    var imageFile: String = ""
    var subHeading: String = ""
    
    @IBAction func close(sender: UIButton) {
        //viewed Walkthrough
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasViewedWalkthrough")
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextScreen(sender: UIButton) {
        let pageViewController = parentViewController as! PageViewController
        pageViewController.forward(index)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStartedButton.hidden = (index == 2) ? false : true
        forwardButton.hidden = (index == 2) ? true : false
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
