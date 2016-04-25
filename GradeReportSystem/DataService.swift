//
//  DataService.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/24/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_COURSES = Firebase(url: "\(URL_BASE)/courses")
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
    private var _REF_GRADES = Firebase(url: "\(URL_BASE)/grades")
    private var _REF_STUDENT = Firebase(url: "\(URL_BASE)/students")
	private var _REF_PROFOSSER = Firebase(url: "\(URL_BASE)/professoers")
    
    var REF_BAE: Firebase {
        return _REF_BASE
    }
    
    var REF_COURSES: Firebase {
        return _REF_COURSES
    }
    
    var REF_GRADES: Firebase {
        return _REF_GRADES
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: Firebase {
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        let user = Firebase(url: "\(URL_BASE)").childByAppendingPath("users").childByAppendingPath(uid)
        return user!
    }
    
    func updateChildValuesToFirebaseUser(uid: String, value: Dictionary<String, String>) {
        REF_USERS.childByAppendingPath(uid).updateChildValues(value)
    }
}

