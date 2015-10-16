//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by LiuWei on 15/10/15.
//  Copyright © 2015年 AppCoda. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet weak var dialogView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //让背景变模糊，给imageview盖上了一层view
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        //Combining Two Transforms
        let scale = CGAffineTransformMakeScale(0.0, 0.0) //先把view缩小
        let translation = CGAffineTransformMakeTranslation(0, 500) //把view移出屏幕
        dialogView.transform = CGAffineTransformConcat(scale, translation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        //普通的动画
//        UIView.animateWithDuration(0.7, animations: { () -> Void in
//            self.dialogView.transform = CGAffineTransformMakeScale(1.0, 1.0)
//            }, completion: nil)
        //spring animation,
        //usingSpringWithDamping 表示阻力，initialSpringVelocity 初始的值
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            let scale = CGAffineTransformMakeScale(1.0, 1.0)
            let translation = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(scale, translation)
            }, completion: nil)
    }
}
