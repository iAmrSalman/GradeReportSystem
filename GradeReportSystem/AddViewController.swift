//
//  AddViewController.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/26/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: MaterialTextField!
    @IBOutlet weak var emailField: MaterialTextField!
    @IBOutlet weak var passwordField: MaterialTextField!
    @IBOutlet weak var addBtn: MaterialButton!
    
    var userType: UserType!
    
    var activtyIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add \(userType.rawValue)".uppercaseString
        
        // Empty back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }

    @IBAction func onAddBtnPressed(sender: AnyObject) {
        if let name = nameField.text where name != "", let email = emailField.text where email != "", let password = passwordField.text where password != "" {
            
            DataService.ds.REF_BAE.createUser(email, password: password, withValueCompletionBlock: { error, result in
                if error != nil {
                    alertWithTitle("Error", message: error.debugDescription, target: self)
                } else {
                    let user = User(name: name, uid: result["uid"] as! String, userType: self.userType)
                    DataService.ds.REF_USERS.childByAppendingPath(user.uid).updateChildValues(["name" : user.name, "user-type" : user.userType])
                    self.emptyTextFields()
                }
            })
            
        } else {
            alertWithTitle("Complete All Fields", message: "You hav to complete all fields in order to add a new \(userType)", target: self)
        }

    }
    
    func emptyTextFields() {
        nameField.text = ""
        emailField.text = ""
        passwordField.text = ""
        nameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
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
