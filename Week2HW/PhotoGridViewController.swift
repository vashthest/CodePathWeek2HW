//
//  PhotoGridViewController.swift
//  Week2HW
//
//  Created by Yi on 8/12/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

import UIKit

class PhotoGridViewController: UIViewController {

    @IBOutlet weak var gridScrollView: UIScrollView!
    @IBOutlet weak var gridImageView: UIImageView!
    @IBOutlet weak var learnMoreBannerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridScrollView.contentSize = gridImageView.frame.size
        learnMoreBannerView.hidden = true
        
        var defaults = NSUserDefaults.standardUserDefaults()
        //defaults.setInteger(0, forKey: "learnMore")
        
        //println(defaults.integerForKey("learnMore"))
        if defaults.integerForKey("learnMore") != 1 &&  defaults.integerForKey("learnMore") != 2 {
            //println("Init learn more")
            defaults.setInteger(1, forKey: "learnMore")
            defaults.setInteger(0, forKey: "learnMorePhoto")
            defaults.setInteger(0, forKey: "learnMoreSpeedscroller")
            defaults.setInteger(0, forKey: "learnMoreShare")
            defaults.synchronize()
            learnMoreBannerView.hidden = false
            gridScrollView.frame = CGRectMake(gridScrollView.frame.origin.x, gridScrollView.frame.origin.y + 44, gridScrollView.frame.width, gridScrollView.frame.height - 22)
        } else if defaults.integerForKey("learnMore") == 1 {
            //println("checking if done")
            if defaults.integerForKey("learnMorePhoto") != 1 || defaults.integerForKey("learnMoreSpeedscroller") != 1 || defaults.integerForKey("learnMoreShare") != 1 {
                learnMoreBannerView.hidden = false
                gridScrollView.frame = CGRectMake(gridScrollView.frame.origin.x, gridScrollView.frame.origin.y + 44, gridScrollView.frame.width, gridScrollView.frame.height - 22)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        if defaults.integerForKey("learnMore") == 2 {
            learnMoreBannerView.hidden = true
            gridScrollView.frame = CGRectMake(gridScrollView.frame.origin.x, 65, gridScrollView.frame.width, 471)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCloseLearnMore(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(2, forKey: "learnMore")
        defaults.synchronize()
        learnMoreBannerView.hidden = true
        gridScrollView.frame = CGRectMake(gridScrollView.frame.origin.x, gridScrollView.frame.origin.y - 44, gridScrollView.frame.width, gridScrollView.frame.height + 22)
    }
    
    @IBAction func onShareButton(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        if defaults.integerForKey("learnMoreShare") != 1 {
            defaults.setInteger(1, forKey: "learnMoreShare")
            showCompleteStep()
        }
    }
    
    @IBAction func onSwipeTimeline(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        if defaults.integerForKey("learnMoreSpeedscroller") != 1 {
            defaults.setInteger(1, forKey: "learnMoreSpeedscroller")
            showCompleteStep()
        }
    }
    
    @IBAction func onPhotoButton(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        if defaults.integerForKey("learnMorePhoto") != 1 {
            defaults.setInteger(1, forKey: "learnMorePhoto")
            showCompleteStep()
        }
    }
    
    func showCompleteStep() {
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 1000, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.learnMoreBannerView.center.y = self.learnMoreBannerView.center.y + 1
            }, completion: {
                (value: Bool) in
                self.learnMoreBannerView.center.y = self.learnMoreBannerView.center.y - 1
        })
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
