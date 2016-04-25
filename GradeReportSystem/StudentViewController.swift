//
//  StudentViewController.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/25/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var finalLbl: UILabel!
    @IBOutlet weak var midtermLbl: UILabel!
    @IBOutlet weak var quizLbl: UILabel!
    
    var activtyIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Student Grade"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateStudentData()
    }
    
    func updateStudentData() {
        startActivtyIndicator()
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        DownloadManager.downlodUserInformation(uid) { (user: User) -> () in
            self.nameLbl.text = user.name
            DownloadManager.downloadGradforStudent(uid, completion: { (grade: Grade) -> () in
                self.finalLbl.text = "\(grade.finalGrade)"
                self.midtermLbl.text = "\(grade.midtermGrade)"
                self.quizLbl.text = "\(grade.quizGrade)"
                self.stopActivtyIndicator()
            })
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

    @IBAction func onRefreshBtnPressed(sender: AnyObject) {
        updateStudentData()
    }
    
}
