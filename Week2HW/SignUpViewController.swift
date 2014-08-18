//
//  SignUpViewController.swift
//  Week2HW
//
//  Created by Yi on 8/12/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var createScrollView: UIScrollView!
    @IBOutlet weak var createFormImageView: UIImageView!
    @IBOutlet weak var agreeTermsButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createButtonView: UIView!
    
    var oriFrame: CGSize!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        oriFrame = createScrollView.frame.size
        createScrollView.contentSize = oriFrame
        createScrollView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        navigationController.popViewControllerAnimated(true)
    }
    
    @IBAction func onTermsTapButton(sender: AnyObject) {
        agreeTermsButton.selected = !agreeTermsButton.selected
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        var userInfo = notification.userInfo
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.fromRaw(UInt(animationCurve << 16))!, animations: {
            
            self.createScrollView.contentOffset = CGPointMake(0, 0)
            self.createScrollView.contentSize = self.oriFrame
            self.createScrollView.frame.size = self.oriFrame
            self.createButtonView.frame.origin.y = 350
            
            }, completion: nil)
    }
    
    @IBAction func onCreateButton(sender: AnyObject) {
        if (firstNameTextField.text.isEmpty || lastNameTextField.text.isEmpty || emailTextField.text.isEmpty || passwordTextField.text.isEmpty || !agreeTermsButton.selected) {
            var alertView = UIAlertView(title: "Please fill in everything", message: "Please fill in all the fields and agree to terms.", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        } else {
            performSegueWithIdentifier("createSegue", sender: nil)
            var defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(0, forKey: "learnMore")
        }
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        var userInfo = notification.userInfo
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.fromRaw(UInt(animationCurve << 16))!, animations: {
            
            self.createButtonView.frame.origin.y = 300
            self.createScrollView.contentSize = CGSizeMake(self.oriFrame.width, self.oriFrame.height - kbSize.height + 90)
            self.createScrollView.frame = CGRectMake(self.createScrollView.frame.origin.x, self.createScrollView.frame.origin.y, self.createScrollView.frame.width, self.createScrollView.frame.height - kbSize.height)
            self.createScrollView.contentOffset = CGPointMake(0, self.createFormImageView.frame.origin.y)
            
            }, completion: nil)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
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
