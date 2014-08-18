//
//  IntroScreensViewController.swift
//  Week2HW
//
//  Created by Yi on 8/13/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

import UIKit

class IntroScreensViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var introScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var backupButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        introScrollView.delegate = self
        introScrollView.contentSize = CGSizeMake(320 * 4, introScrollView.frame.size.height)
        backupButtonView.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // Get the current page based on the scroll offset
        var page : Int = Int(round(scrollView.contentOffset.x / 320))
        
        // Set the current page, so the dots will update
        pageControl.currentPage = page
        
        if (page == 3) {
            if (backupButtonView.hidden) {
                backupButtonView.hidden = false
                backupButtonView.alpha = 0
                UIView.animateWithDuration(0.2, animations: {
                    self.backupButtonView.alpha = 1
                    }, completion: nil)
            }
        } else {
            UIView.animateWithDuration(0.2, animations: {
                self.backupButtonView.alpha = 0
                }, completion: {
                    (value: Bool) in
                    self.backupButtonView.hidden = true
            })
        }
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
