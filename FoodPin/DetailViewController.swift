//
//  DetailViewController.swift
//  FoodPin
//
//  Created by LiuWei on 15/10/14.
//  Copyright © 2015年 AppCoda. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restaurantImageView: UIImageView!
    var restaurant: Restaurant!
    
    //用于关闭model segue
    @IBAction func close(segue:UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantImageView.image = UIImage(data: restaurant.image)
        //修改tableview的背景
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        //去掉多余的行
        tableView.tableFooterView = UIView(frame: CGRectZero)
        //修改分割线的颜色
        self.tableView.separatorColor = UIColor(red:240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0,alpha: 0.8)
        
        //设置UINavigationBar的标题
        title = restaurant.name
        
        //自动调整高度
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DetailTableViewCell
        
        cell.mapButton.hidden =  true
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = NSLocalizedString("Name", comment:"detailViewcontrolelr->name")
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = NSLocalizedString("Type", comment:"detailViewcontrolelr->Type")
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = NSLocalizedString("Location", comment:"detailViewcontrolelr->Location")
            cell.valueLabel.text = restaurant.location
            cell.mapButton.hidden = false
        case 3:
            cell.fieldLabel.text = NSLocalizedString("Been here", comment:"detailViewcontrolelr->Been here")
            cell.valueLabel.text = restaurant.isVisited.boolValue ? NSLocalizedString("Yes, I've been here before", comment:"detailViewcontrolelr->Yes, I've been here before") : NSLocalizedString("No", comment:"detailViewcontrolelr->NO")
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        //清除单元格的颜色
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    //显示被隐藏的导航栏
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
//    //把状态栏改成白色
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.LightContent
//    }
    
    //场景转换
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destinationViewController as! MapViewController
            destinationController.restaurant = restaurant
        }
    }
}
