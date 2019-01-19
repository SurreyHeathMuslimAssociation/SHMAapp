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
    // sorts on client side, possibly future improvement
    func searchMemberUsing(_ dob: String, _ surname: String, completion: @escaping (String?, Bool) -> Void) {
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
    func checkShmaIdExistsWithInOfflineDatabaseUsing(_ shmaId: String, completion: @escaping (Bool, String?, String?) -> Void) {
        Database.database().reference().child("member_search").queryOrderedByKey().queryEqual(toValue: shmaId).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                allObjects.forEach({ (snapshot) in
                    guard let value = snapshot.value as? [String: Any] else { return }
                    let firstname = value["firstname"] as? String
                    let surname = value["surname"] as? String
                    completion(true, firstname, surname)
                })
            } else {
                completion(false, nil, nil)
            }
        }
    }
    
    // sorts on client side, possibly future improvement
    func checkShmaIdIsntAlreadyRegisteredInFirebase(_ shmaId: String, completion: @escaping (Bool) -> Void) {
        var isRegistered = false
        Database.database().reference().child("members").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                allObjects.forEach({ (snapshot) in
                    guard let member = snapshot.value as? [String: Any] else { return }
                    let memberShmaId = member["shmaId"] as? String
                    if shmaId == memberShmaId {
                        isRegistered = true
                    }
                })
                completion(isRegistered)
            } else {
                completion(isRegistered)
            }
        }
    }
    
    func saveExistingMemberDetailsToDatabase(_ uid: String, _ shmaId: String, _ firstname: String, _ surname: String, _ email: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        
        let values = ["shmaId": shmaId, "email": email, "firstname": firstname, "surname": surname]
        Database.database().reference().child("members").child(uid).updateChildValues(values) { (error, ref) in
            completion(error, ref)
        }
    }
    
    func saveNewMemberDetailsToDatabase(_ uid: String, _ firstname: String, _ surname: String, _ email: String, _ dob: String, _ addressLineOne: String, _ addressLineTwo: String, _ town: String, _ postcode: String, _ mobileNo: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        
        let values = ["email": email, "firstname": firstname, "surname": surname, "dob": dob, "addressLineOne": addressLineOne, "addressLineTwo": addressLineTwo, "town": town, "postcode": postcode, "mobileNo": mobileNo, "status": "Applied"]
        Database.database().reference().child("members").child(uid).updateChildValues(values) { (error, ref) in
            completion(error, ref)
        }
    }
    
    func saveNewMembersSpouseDetailsToDatabase(_ uid: String, _ spouseName: String, _ spouseEmail: String, _ spouseDob: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        
        let values = ["spouseName": spouseName, "spouseEmail": spouseEmail, "spouseDob": spouseDob]
        Database.database().reference().child("spouse").child(uid).updateChildValues(values) { (error, ref) in
            completion(error, ref)
        }
    }
    
    func saveNewMembersChildrenDetailsToDatabase(_ uid: String, _ childName: String, _ childDob: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        
        let values = ["childName": childName, "childDob": childDob]
        Database.database().reference().child("children").child(uid).childByAutoId().updateChildValues(values) { (error, ref) in
            completion(error, ref)
        }
    }
}
