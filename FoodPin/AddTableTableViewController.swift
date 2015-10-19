//
//  AddTableTableViewController.swift
//  FoodPin
//
//  Created by LiuWei on 15/10/16.
//  Copyright © 2015年 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class AddTableTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var typeTextField:UITextField!
    @IBOutlet weak var locationTextField:UITextField!
    @IBOutlet weak var yesButton:UIButton!
    @IBOutlet weak var noButton:UIButton!
    var isVisited = true
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        if nameTextField.text!.isEmpty || typeTextField.text!.isEmpty || locationTextField.text!.isEmpty {
            
            let alertView = UIAlertController(title: nil, message: NSLocalizedString("Content can not be empty", comment: "Content can not be empty"), preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .Default, handler: nil)
            alertView.addAction(cancelAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            
            return
        }
        //获取管理对象上下文
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //创建管理对象实体
        restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
        restaurant.name = nameTextField.text
        restaurant.type = typeTextField.text
        restaurant.location = locationTextField.text
        /* As we’ve changed the type of image property from String to NSData. We use the
          UIImagePNGRepresentation function to get the image data of the selected image.
         */
        restaurant.image = UIImagePNGRepresentation(imageView.image!)
        restaurant.isVisited = isVisited
        //保存到数据库
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            NSLog("save error \(nserror), \(nserror.userInfo)")
        }
            
        print("Name:\(nameTextField.text!)")
        print("Type:\(typeTextField.text!)")
        print("Location:\(locationTextField.text!)")
        print("Have you been here:" + (isVisited ? "YES" : "NO"))
        //返回home screen
        performSegueWithIdentifier("unwindToHomeScreen", sender: self)
    }
    
    @IBAction func yesOrNoButtonBeenTaped(sender: UIButton) {
        if sender.titleLabel?.text == "YES" || sender.titleLabel?.text == "来过"{
            yesButton.backgroundColor = UIColor.redColor()
            noButton.backgroundColor = UIColor.grayColor()
            isVisited = true
        } else {
            yesButton.backgroundColor = UIColor.grayColor()
            noButton.backgroundColor = UIColor.redColor()
            isVisited = false
        }
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary //从照片库获取，.Camera从摄像头拍摄
                imagePicker.delegate = self //设置代理！！！！
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //显示用户选择的图片
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
                
        dismissViewControllerAnimated(true, completion: nil)
    }
}
