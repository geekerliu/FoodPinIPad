//
//  ShareViewController.swift
//  FoodPin
//
//  Created by LiuWei on 15/10/16.
//  Copyright © 2015年 AppCoda. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var message: UIButton!
    @IBOutlet weak var email: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //让背景变模糊，给imageview盖上了一层view
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        //让button都移到屏幕外面
        let translationUp = CGAffineTransformMakeTranslation(0, 1000) //移到下面
        let translationDown = CGAffineTransformMakeTranslation(0, -1000) //移到上面
        facebook.transform = translationDown
        message.transform = translationDown
        twitter.transform = translationUp
        email.transform = translationUp
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            let translation = CGAffineTransformMakeTranslation(0, 0)
            self.facebook.transform = translation
            self.email.transform = translation
            }, completion: nil)
        UIView.animateWithDuration(0.7, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            let translation = CGAffineTransformMakeTranslation(0, 0)
            self.twitter.transform = translation
            self.message.transform = translation
            }, completion: nil)
    }
}
