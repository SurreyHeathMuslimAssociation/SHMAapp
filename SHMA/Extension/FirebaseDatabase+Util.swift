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
//
//    func fetchMemberUsing(_ shmaId: String, completion: @escaping (String?, String?) -> Void) {
//        Database.database().reference().child("member_search").queryOrderedByKey().queryEqual(toValue: shmaId).observeSingleEvent(of: .value) { (snapshot) in
//            print(snapshot.key)
//
//            guard let dob = snapshot.childSnapshot(forPath: "DOB").value as? String else { return }
//            guard let surname = snapshot.childSnapshot(forPath: "surname").value as? String else { return }
//            completion(dob, surname)
//        }
//    }
    
    func searchMemberUsing(_ dob: String, _ surname: String, completion: @escaping (String, Bool) -> Void) {
        //Database.database().reference().child("member_search").child("144").updateChildValues(["surname": "Test", "DOB": "04/12/2018"])
        Database.database().reference().child("member_search").queryOrdered(byChild: "DOB").queryEqual(toValue: dob).observe( .childAdded) { (snapshot) in
            let shmaId = snapshot.key
            if let lastName = snapshot.childSnapshot(forPath: "surname").value as? String {
                if lastName == surname {
                    completion(shmaId, true)
                }
            }
        }
        
    }
   
}
