//
//  FinalNamesTableViewController.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/25/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import UIKit

class FinalNamesTableViewController: UITableViewController {
    
    var students = [User]()
    
    var activtyIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Choose Student"
        
        // Empty back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateStudentsData()
    }
    
    func updateStudentsData() {
        students = []
        DownloadManager.downlodAllUserInformation { (users: [User]) -> () in
            self.startActivtyIndicator()
            for user in users {
                if user.userType == UserType.Student.rawValue {
                    self.students.append(user)
                }
            }
            self.tableView.reloadData()
            self.stopActivtyIndicator()
        }
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let student = students[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell

        cell.configerCell(student.name)

        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedStudent = students[indexPath.row]
        self.performSegueWithIdentifier("updateGrade", sender: selectedStudent)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "updateGrade" {
            let destnation = segue.destinationViewController as! UpdateGradeViewController
            destnation.student = sender as! User
        }
    }
    

}
