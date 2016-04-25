//
//  DownloadManager.swift
//  GradeReportSystem
//
//  Created by Amr Salman on 4/24/16.
//  Copyright © 2016 Amr Salman. All rights reserved.
//

import Foundation
import Firebase

class DownloadManager {
    static func downlodUserInformation(uid: String, completion: (User) -> ()) {
        DataService.ds.REF_USERS.childByAppendingPath(uid).observeEventType(.Value) { (snapshot: FDataSnapshot!) -> Void in
            
            if let userDictionary = snapshot.value as? Dictionary<String, AnyObject> {
                completion(User(uid: uid, dictionary: userDictionary))
                DataService.ds.REF_USERS.childByAppendingPath(uid).removeAllObservers()
            }
        }
    }
    
    static func downloadGradforStudent(uid: String, completion: (Grade) -> ()) {
        DataService.ds.REF_GRADES.childByAppendingPath(uid).observeEventType(.Value) { (snapshot: FDataSnapshot!) -> Void in
            
            if let gradeDictionary = snapshot.value as? Dictionary<String, AnyObject> {
                completion(Grade(dictionadry: gradeDictionary))
                DataService.ds.REF_GRADES.childByAppendingPath(uid).removeAllObservers()
            }
        }
    }
    
    static func downlodAllUserInformation(completion: ([User]) -> ()) {
        var users = [User]()
        DataService.ds.REF_USERS.observeEventType(.Value) { (snapshot: FDataSnapshot!) -> Void in
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let userDictionary = snap.value as? Dictionary<String, AnyObject> {
                        users.append(User(uid: snap.key, dictionary: userDictionary))
                    }
                }
                DataService.ds.REF_USERS.removeAllObservers()
                completion(users)
            }
        }
    }

}