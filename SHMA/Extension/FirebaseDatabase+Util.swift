//
//  FirebaseDatabase+Util.swift
//  SHMA
//
//  Created by Umar Yaqub on 04/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension Database: FirebaseDatabaseSession {

    func searchMemberUsing(_ dob: String, _ surname: String, completion: @escaping (String?, Bool) -> Void) {
//        Database.database().reference().child("member_search").queryOrdered(byChild: "DOB").queryEqual(toValue: dob).observe( .childAdded) { (snapshot) in
//            let shmaId = snapshot.key
//            if let lastName = snapshot.childSnapshot(forPath: "surname").value as? String {
//                if lastName == surname {
//                    completion(shmaId, true)
//                }
//            }
//        }
        
        Database.database().reference().child("member_search").observeSingleEvent(of: .value) { (snapshot) in
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            allObjects.forEach({ (snapshot) in
                guard let member = snapshot.value as? [String: Any] else { return }
                let memberDOB = member["DOB"] as? String
                let memberSurname = member["surname"] as? String
                if dob == memberDOB && surname == memberSurname {
                    let shmaId = snapshot.key
                    completion(shmaId, true)
                } else {
                    completion(nil, false)
                }
            })
        }
        
    }
   
}
