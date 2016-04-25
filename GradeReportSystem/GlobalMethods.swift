//
//  GlobalMethods.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/24/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import UIKit


func intializeRefresher(var refresher: UIRefreshControl, tableView: UITableView, target: UIViewController) {
    refresher = UIRefreshControl()
    refresher.attributedTitle = NSAttributedString (string: "Refresh")
    refresher.addTarget(target, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
    tableView.addSubview(refresher)
}

func alertWithTitle(title: String, message: String, target: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
    
    alert.addAction(okAction)
    
    target.presentViewController(alert, animated: true, completion: nil)
}
