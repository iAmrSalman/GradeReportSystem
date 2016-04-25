//
//  UpdateGradeViewController.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/25/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import UIKit

class UpdateGradeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var finalField: MaterialTextField!
    @IBOutlet weak var midtermField: MaterialTextField!
    @IBOutlet weak var quizField: MaterialTextField!
    
    var student: User!
    
    var activtyIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Update Grade"
        
        finalField.delegate = self
        midtermField.delegate = self
        quizField.delegate = self
    }

    @IBAction func onEditFinelBtnPressed(sender: AnyObject) {
        if let final = finalField.text where final != "" {
            startActivtyIndicator()
            DataService.ds.REF_GRADES.childByAppendingPath(student.uid).updateChildValues(["final-grade": Double(final)!])
            stopActivtyIndicator()
            finalField.text = ""
            finalField.resignFirstResponder()
        }
    }
    
    @IBAction func onEditMidtermBtnPressed(sender: AnyObject) {
        if let midterm = midtermField.text where midterm != "" {
            startActivtyIndicator()
            DataService.ds.REF_GRADES.childByAppendingPath(student.uid).updateChildValues(["midterm-grade": Double(midterm)!])
            stopActivtyIndicator()
            midtermField.text = ""
            midtermField.resignFirstResponder()
        }

    }
    
    @IBAction func onEditQuizBtnPressed(sender: AnyObject) {
        if let quiz = quizField.text where quiz != "" {
            startActivtyIndicator()
            DataService.ds.REF_GRADES.childByAppendingPath(student.uid).updateChildValues(["quiz-grade": Double(quiz)!])
            stopActivtyIndicator()
            quizField.text = ""
            quizField.resignFirstResponder()
        }
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
