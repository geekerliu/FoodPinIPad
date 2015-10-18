//
//  PageViewController.swift
//  FoodPin
//
//  Created by LiuWei on 15/10/18.
//  Copyright © 2015年 AppCoda. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var pageHeadings = ["Personalize", "Locate", "Discover"]
    var pageImages = ["homei", "mapintro", "fiveleaves"]
    var pageSubHeadings = ["Pin your favourite restaurants and create your own food guide", "Search and locate your favourite restaurant on Maps", "Find restaurants pinned by your friends and other foodies around the world"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置数据源为自己
        dataSource = self
        if let startingViewController = self.viewControllerAtIndex(0) {
            //显示该view content controller
            setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -
    func viewControllerAtIndex(index: Int) -> PageContentViewController? {
        if index == NSNotFound || index < 0 || index >= self.pageHeadings.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageContentViewController).index
        
        index++
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageContentViewController).index
        
        index--
        
        return viewControllerAtIndex(index)
    }
    
    func forward(index: Int) {
        if let nextViewController = self.viewControllerAtIndex(index + 1) {
            setViewControllers([nextViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    //Default Page Indicator
//    //总共的页数
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return pageHeadings.count
//    }
//    
//    //当前索引
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as? PageContentViewController {
//            return pageContentViewController.index
//        }
//
//        return 0
//    }
}
