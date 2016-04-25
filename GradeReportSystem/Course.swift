//
//  Course.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/24/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import Foundation

class Course {
    private var _cid: String
    private var _name: String
    private var _uid: String
    
    var cid: String {
        return _cid
    }
    
    var name: String {
        return _name
    }
    
    var uid: String {
        return _uid
    }
    
    var courseJSON: [String:AnyObject] {
        return ["name" : name, "uid" : uid]
    }
    
    init(cid: String, name: String, uid: String) {
        _cid = cid
        _name = name
        _uid = uid
    }
}