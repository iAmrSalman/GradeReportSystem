//
//  AdminPanelTableViewController.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/25/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import UIKit

class AdminPanelTableViewController: UITableViewController {
    
    var userType: UserType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Admin Panel"
        
        // Empty back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            userType = .Student
            switch indexPath.row {
            case 0:
                self.performSegueWithIdentifier("add", sender: nil)
            case 1:
                self.performSegueWithIdentifier("delete", sender: nil)
            default:
                print("error")
            }
        case 1:
            userType = .Professor
            switch indexPath.row {
            case 0:
                self.performSegueWithIdentifier("add", sender: nil)
            case 1:
                self.performSegueWithIdentifier("delete", sender: nil)
            default:
                print("error")
            }
        case 2:
            userType = .Admin
            switch indexPath.row {
            case 0:
                self.performSegueWithIdentifier("add", sender: nil)
            case 1:
                self.performSegueWithIdentifier("delete", sender: nil)
            default:
                print("error")
            }
        default:
            print("Error")
        }
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "add" {
            let destnation = segue.destinationViewController as! AddViewController
            destnation.userType = userType
        } else if segue.identifier == "delete" {
            let destnation = segue.destinationViewController as! DeleteTableViewController
            destnation.userType = userType
        }
    }


}
