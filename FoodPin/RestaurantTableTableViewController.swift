//
//  RestaurantTableTableViewController.swift
//  FoodPin
//
//  Created by LiuWei on 15/10/14.
//  Copyright © 2015年 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
    }
    
    var fetchResultController:NSFetchedResultsController!
    var restaurants:[Restaurant] = []
    var searchController:UISearchController!
    var searchResults:[Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //显示pageview controller
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasViewedWalkthrough = defaults.boolForKey("hasViewedWalkthrough")
        
        if hasViewedWalkthrough == false {
            if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") {
                self.presentViewController(pageViewController, animated: true, completion: nil)
            }
        }
        
        // Empty back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationController?.hidesBarsOnSwipe = true
        
        //？？不加这句无法修改状态栏的颜色
        navigationController?.navigationBar.barStyle = UIBarStyle.Black;
            
        //自动调整高度
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //从数据库获取数据
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let ManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        
        do {
            try fetchResultController.performFetch()
            restaurants = fetchResultController.fetchedObjects as! [Restaurant]
        } catch {
            print("error = \(error)")
        }
        
        // 添加搜索栏
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.searchResultsUpdater = self //assigns the current class as the search results updater
        searchController.dimsBackgroundDuringPresentation = false // 搜索的时候不模糊背景
        searchController.searchBar.placeholder = "Search your restaurant"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - search
    // implemented the search logic
    func filterContentForSearchText(searchText: String) {
        searchResults = restaurants.filter({ (restaurant: Restaurant) -> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let locationMatch = restaurant.location.rangeOfString(searchText)
            return nameMatch != nil || locationMatch != nil
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // 获取用户的输入
        let searchText = searchController.searchBar.text
        // 调用过滤方法
        filterContentForSearchText(searchText!)
        // 更新tableView数据
        tableView.reloadData()
    }
    
    //MARK: - NSFetchedResultsControllerDelegate 
    /* When there is any content change, the following methods of the 
    NSFetchedResultsControllerDelegate will be called: */
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        default:
            tableView.reloadData()
        }
        
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }

    // MARK: - Table view data source
    //有多少组，如果不设置默认就是1
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //每组有多少行
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active == true {
            return searchResults.count
        } else {
            return restaurants.count
        }
    }

    //每一行的内容
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        let restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data: restaurant.image)
        //将图片变圆
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        cell.heartImageView.image = UIImage(named: "heart")
        cell.heartImageView.hidden = restaurant.isVisited.boolValue
            
        return cell
    }
 
    //自定义滑动动作
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let shareAction = UITableViewRowAction(style: .Default, title: "Share") { (action, indexPath) -> Void in
            let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .Alert)
            let twitterAction = UIAlertAction(title: "Twitter", style:
                    UIAlertActionStyle.Default, handler: nil)
            let facebookAction = UIAlertAction(title: "Facebook", style:
                    UIAlertActionStyle.Default, handler: nil)
            let emailAction = UIAlertAction(title: "Email", style: UIAlertActionStyle.Default,
                    handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel,
                    handler: nil)
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(emailAction)
            shareMenu.addAction(cancelAction)
            self.presentViewController(shareMenu, animated: true, completion: nil)
        }
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) -> Void in
            // Delete the row from the data source
            let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
            managedObjectContext.deleteObject(restaurantToDelete)
            
            do {
                try managedObjectContext.save()
            } catch {
                print("delete error: \(error)")
            }
        }
        shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue:
        51.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue:
        51.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
    
    //在搜索的时候禁止编辑
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active {
            return false
        } else {
            return true
        }
    }
    
    //MARK: - Another
    //场景转换
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! DetailViewController
                destinationController.restaurant = (searchController.active) ? searchResults[indexPath.row] : self.restaurants[indexPath.row]
            }
        }
    }
    
    //设置向上滑动的时候隐藏导航栏
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }
    
//    //把状态栏改成白色
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return .LightContent
//    }
//    隐藏状态栏
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
}
