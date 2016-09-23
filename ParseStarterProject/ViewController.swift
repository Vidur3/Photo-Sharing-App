/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var clickLoginBtn: UIButton!
    
    @IBOutlet weak var alreadyregisteredLbl: UILabel!
    @IBOutlet weak var clickSignupBtn: UIButton!
    
    var signupActive = true
    
    
    var activityView = UIActivityIndicatorView()
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser() != nil {
            
            self.performSegueWithIdentifier("login", sender: self)
        }
    }
    
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    clickLoginBtn.layer.borderWidth = 2.0
    clickLoginBtn.layer.cornerRadius = 5.0
    clickLoginBtn.layer.borderColor = UIColor.whiteColor().CGColor
    
    clickSignupBtn.layer.borderWidth = 2.0
    clickSignupBtn.layer.cornerRadius = 5.0
    clickSignupBtn.layer.borderColor = UIColor.whiteColor().CGColor
    
    
    
 }
    
    func displayAlert(title: String, message: String) {
        
        
            if #available(iOS 8.0, *) {
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
                
            } else {
                // Fallback on earlier versions
            }
            
        }
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        if username.text == "" || password.text == "" {
            
           displayAlert("Instagram", message: "Check the empty fields")
            
        } else {
            
            activityView = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
            activityView.center = self.view.center
            activityView.hidesWhenStopped = true
            activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityView)
            activityView.startAnimating()
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
        if signupActive {
                
            let user = PFUser()
            user.username = username.text
            user.password = password.text
            
            user.signUpInBackgroundWithBlock({ (success, error) in
                
                self.activityView.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if success {
                    
                    print("signup succesfull")
                    
                self.performSegueWithIdentifier("login", sender: self)
                    
                } else {
                    
                    if let errString = error?.userInfo["error"] as? String {
                        
                        self.displayAlert("Instagram", message: errString)
                    }
                }
            })
            
            } else {
                
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) in
                    
                    self.activityView.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil {
                        
                        print("user logged in")
                        
                    } else {
                        
                        if let errString = error?.userInfo["error"] as? String {
                            
                            self.displayAlert("Instagram", message: errString)
                        }
                    }
                })
            }
        }
        
    }
    
    
    @IBAction func loginBtnClicked(sender: AnyObject) {
        
        if signupActive {
            
            clickSignupBtn.setTitle("Log In", forState: UIControlState.Normal)
            alreadyregisteredLbl.text = "Not Registered?"
            clickLoginBtn.setTitle("Sign Up", forState: UIControlState.Normal)
            
            signupActive = false
        } else {
            
            clickSignupBtn.setTitle("Sign Up", forState: UIControlState.Normal)
            alreadyregisteredLbl.text = "Already Registered?"
            clickLoginBtn.setTitle("Log In", forState: UIControlState.Normal)
            
            signupActive = true
            
            
        }
    }
    
    
    
}
