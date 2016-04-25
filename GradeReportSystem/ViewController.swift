//
//  ViewController.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/24/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: MaterialButton!
    
    var activtyIndicator = UIActivityIndicatorView()
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        checkForReachablility()
    }
    
    
    @IBAction func onEmailBtnPressed(sender: UIButton) {
        if Reachability.isConnectedToNetwork() {
            checkForReachablility()
            if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
                startActivtyIndicator()
                DataService.ds.REF_BAE.authUser(email, password: pwd, withCompletionBlock: { error, authData in
                    if error != nil {
                        alertWithTitle("Could not login", message: "Please check your Email and Password", target: self)
                        
                    } else {
                        DownloadManager.downlodUserInformation(authData.uid, completion: { (userData: User) -> () in
                            self.user = userData
                            self.performSegueWithIdentifier(userData.userType, sender: nil)
                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: KEY_UID)
                        })
                    }
                })
                
            } else {
                alertWithTitle("Email and Password Required", message: "You must enter an Email and a Password", target: self)
            }
            
            stopActivtyIndicator()
        } else {
            checkForReachablility()
        }
        
    }
    
    func checkForReachablility() {
        startActivtyIndicator()
        if Reachability.isConnectedToNetwork() {
            emailField.hidden = false
            passwordField.hidden = false
            loginBtn.setTitle("Login / SignUp", forState: .Normal)
            if let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as? String {
                DownloadManager.downlodUserInformation(uid, completion: { (user: User) -> () in
                    self.user = user
                    self.performSegueWithIdentifier(user.userType, sender: nil)
                })
            }
            
        } else {
            emailField.hidden = true
            passwordField.hidden = true
            loginBtn.setTitle("Refresh", forState: .Normal)
            alertWithTitle("Not Connected", message: "Please Connect to Internet and Refresh", target: self)
        }
        
        stopActivtyIndicator()
    }
    
    func startActivtyIndicator() {
        activtyIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activtyIndicator.center = view.center
        activtyIndicator.hidesWhenStopped = true
        activtyIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activtyIndicator)
        activtyIndicator.startAnimating()
        //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func stopActivtyIndicator() {
        activtyIndicator.stopAnimating()
        //UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}


