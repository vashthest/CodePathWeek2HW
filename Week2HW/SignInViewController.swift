//
//  SignInViewController.swift
//  Week2HW
//
//  Created by Yi on 8/12/14.
//  Copyright (c) 2014 Dropbox. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var signInScrollView: UIScrollView!
    @IBOutlet weak var signInFormImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButtonsView: UIView!
    @IBOutlet weak var signInFormView: UIView!
    
    var oriFrame: CGSize!
    var isEditing: Bool!
    var alertView: UIAlertView!
    
    var previousContentScroll: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        oriFrame = signInScrollView.frame.size
        signInScrollView.contentSize = oriFrame
        signInScrollView.delegate = self
        isEditing = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.2, animations: {
            self.signInFormView.transform = CGAffineTransformMakeScale(1, 1)
            self.signInFormView.alpha = 1
            }, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        signInFormView.transform = CGAffineTransformMakeScale(0, 0)
        signInFormView.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            self.signInScrollView.frame = CGRectMake(self.signInScrollView.frame.origin.x, self.signInScrollView.frame.origin.y, self.signInScrollView.frame.size.width, self.signInScrollView.frame.size.height + kbSize.height)
            self.signInButtonsView.frame.origin.y = 360
            self.signInScrollView.contentSize = self.oriFrame

            }, completion: nil)
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
        
        //self.signInScrollView.scrollRectToVisible(CGRectMake(0,0,10,10), animated: true)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.fromRaw(UInt(animationCurve << 16))!, animations: {
            
            self.signInScrollView.contentOffset = CGPointMake(0, self.signInFormImageView.frame.origin.y);
            self.signInScrollView.frame = CGRectMake(self.signInScrollView.frame.origin.x, self.signInScrollView.frame.origin.y, self.signInScrollView.frame.size.width, self.signInScrollView.frame.size.height - kbSize.height)
            self.signInButtonsView.frame.origin.y = 245
            self.signInScrollView.contentSize = CGSizeMake(self.oriFrame.width, self.oriFrame.height - (360 - 245 + 25))
            
            }, completion: {
                (value: Bool) in
                self.isEditing = true
        })
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        isEditing = false
    }
    
    @IBAction func onSignInButton(sender: AnyObject) {
        if (emailTextField.text == "") {
            alertView = UIAlertView(title: "Email Required", message: "Please enter an email address.", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        } else {
            alertView = UIAlertView(title: "Signing in...", message: nil, delegate: self, cancelButtonTitle: nil)
            alertView.show()
            delay(2) {
                self.alertView.dismissWithClickedButtonIndex(0, animated: true)
                self.verifySignIn()
            }
        }
    }
    
    func verifySignIn() {
        if (emailTextField.text == "a@b.com" && passwordTextField.text == "b") {
            performSegueWithIdentifier("SignedInSegue", sender: nil)
        } else {
            alertView = UIAlertView(title: "Sign In Failed", message: "Incorrect email or password.", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        navigationController.popViewControllerAnimated(true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        if (isEditing == true && signInScrollView.contentOffset.y < previousContentScroll) {
            view.endEditing(true)
            isEditing = false
        }
        previousContentScroll = signInScrollView.contentOffset.y
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
