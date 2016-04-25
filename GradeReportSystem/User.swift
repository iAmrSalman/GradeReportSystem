//
//  User.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/24/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import Foundation

class User {
    private var _name: String
    private var _uid: String
    private var _userType: String
    
    var name: String {
        return _name
    }
    
    var uid: String {
        return _uid
    }
    
    var userType: String {
        return _userType
    }
    
    init (name: String, uid: String, userType: UserType) {
        _name = name
        _uid = uid
        _userType = userType.rawValue
    }
    
    init(uid: String, dictionary: Dictionary<String, AnyObject>) {
        if let name = dictionary["name"] as? String {
            _name = name
        } else {
            _name = ""
        }
        
        if let userType = dictionary["user-type"] as? String {
            _userType = userType
        } else {
            _userType = ""
        }
        
        _uid = uid
    }
}