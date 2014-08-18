//
//  SplashViewController.swift
//  Week2HW
//
//  Created by Yi on 8/12/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var splashScrollView: UIScrollView!
    @IBOutlet weak var splashImageView: UIImageView!
    
    @IBOutlet weak var img1ImageView: UIImageView!
    @IBOutlet weak var img2ImageView: UIImageView!
    @IBOutlet weak var img3ImageView: UIImageView!
    @IBOutlet weak var img4ImageView: UIImageView!
    @IBOutlet weak var img5ImageView: UIImageView!
    @IBOutlet weak var img6ImageView: UIImageView!
    
    var img1Center: CGPoint!
    var img2Center: CGPoint!
    var img3Center: CGPoint!
    var img4Center: CGPoint!
    var img5Center: CGPoint!
    var img6Center: CGPoint!
    
    var maxY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splashScrollView.delegate = self
        splashScrollView.contentSize = splashImageView.frame.size
        
        var defaults = NSUserDefaults.standardUserDefaults()
        //defaults.setInteger(0, forKey: "learnMore")
        
        maxY = 568
        img1Center = img1ImageView.center
        img2Center = img2ImageView.center
        img3Center = img3ImageView.center
        img4Center = img4ImageView.center
        img5Center = img5ImageView.center
        img6Center = img6ImageView.center
        
        scrollViewDidScroll(splashScrollView)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        var y = scrollView.contentOffset.y
        if (y >= 0 && y <= maxY) {
            imgScrollTransform(y, iniScale: 1, iniRadians: -0.2, iniCenterX: 40, iniCenterY: 540, endCenter: img1Center, img: img1ImageView)
            imgScrollTransform(y, iniScale: 1.6, iniRadians: -0.2, iniCenterX: 270, iniCenterY: 532, endCenter: img2Center, img: img2ImageView)
            imgScrollTransform(y, iniScale: 1.6, iniRadians: 0.2, iniCenterX: 161, iniCenterY: 533, endCenter: img4Center, img: img4ImageView)
            imgScrollTransform(y, iniScale: 1.6, iniRadians: 0.2, iniCenterX: 250, iniCenterY: 434, endCenter: img3Center, img: img3ImageView)
            imgScrollTransform(y, iniScale: 1.6, iniRadians: -0.2, iniCenterX: 136, iniCenterY: 445, endCenter: img6Center, img: img6ImageView)
            imgScrollTransform(y, iniScale: 1.6, iniRadians: 0.2, iniCenterX: 30, iniCenterY: 433, endCenter: img5Center, img: img5ImageView)
        }
    }
    
    func imgScrollTransform(y: CGFloat!, iniScale: CGFloat!, iniRadians: CGFloat!, iniCenterX: CGFloat!, iniCenterY: CGFloat!, endCenter: CGPoint!, img: UIImageView!) {
        img.center.x = iniCenterX + y/maxY * (endCenter.x - iniCenterX)
        img.center.y = iniCenterY + y/maxY * (endCenter.y - iniCenterY)
        
        var scale = iniScale - y/maxY * (iniScale - 1)
        var radians = iniRadians - y/maxY * (iniRadians)
        
        img.transform = CGAffineTransformMakeScale(scale, scale)
        img.transform = CGAffineTransformRotate(img.transform, radians)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
