//
//  GettingStartedViewController.swift
//  Week2HW
//
//  Created by Yi on 8/12/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

import UIKit

class GettingStartedViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var learnMorePhotoLabel: UILabel!
    @IBOutlet weak var learnMoreSpeedscrollerLabel: UILabel!
    @IBOutlet weak var learnMoreShareLabel: UILabel!
    @IBOutlet weak var learnMorePhotoImageView: UIImageView!
    @IBOutlet weak var learnMoreSpeedscrollerImageView: UIImageView!
    @IBOutlet weak var learnMoreShareImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var defaults = NSUserDefaults.standardUserDefaults()
        if defaults.integerForKey("learnMorePhoto") == 1 {
            learnMorePhotoLabel.textColor = UIColor(red: 0, green: 0.75, blue: 0, alpha: 1)
            learnMorePhotoImageView.image = UIImage(named: "checkbox_complete")
        }
        if defaults.integerForKey("learnMoreSpeedscroller") == 1 {
            learnMoreSpeedscrollerLabel.textColor = UIColor(red: 0, green: 0.75, blue: 0, alpha: 1)
            learnMoreSpeedscrollerImageView.image = UIImage(named: "checkbox_complete")
        }
        if defaults.integerForKey("learnMoreShare") == 1 {
            learnMoreShareLabel.textColor = UIColor(red: 0, green: 0.75, blue: 0, alpha: 1)
            learnMoreShareImageView.image = UIImage(named: "checkbox_complete")
        }
        if defaults.integerForKey("learnMorePhoto") == 1 && defaults.integerForKey("learnMoreSpeedscroller") == 1 && defaults.integerForKey("learnMoreShare") == 1 {
            titleLabel.text = "Congrats on completing all the steps. You've made it!"
            defaults.setInteger(2, forKey: "learnMore")
            defaults.synchronize()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCloseButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
