//
//  DeleteTableViewController.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/26/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import UIKit

class DeleteTableViewController: UITableViewController {
    
    var userType: UserType!
    
    var users = [User]()
    
    var activtyIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Choose \(userType.rawValue)".uppercaseString
        
        // Empty back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateStudentsData()
    }
    
    func updateStudentsData() {
        DownloadManager.downlodAllUserInformation { (users: [User]) -> () in
            self.startActivtyIndicator()
            for user in users {
                if user.userType == self.userType.rawValue {
                    self.users.append(user)
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
        return users.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let user = users[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as! NameTableViewCell
        
        cell.configerCell(user.name)
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedUser = users[indexPath.row]
        let alert = UIAlertController(title: "Are You Sure Deleting \(selectedUser.name) ?", message: "", preferredStyle: .Alert)
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive) { (action: UIAlertAction) -> Void in
            DataService.ds.REF_USERS.childByAppendingPath(selectedUser.uid).setValue(nil)
            self.navigationController?.popViewControllerAnimated(true)
        }
        let noActon = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(noActon)
        alert.addAction(yesAction)
        self.presentViewController(alert, animated: true, completion: nil)
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

    
}
