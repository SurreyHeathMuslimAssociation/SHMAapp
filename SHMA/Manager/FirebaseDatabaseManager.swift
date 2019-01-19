//
//  FirebaseDatabaseManager.swift
//  SHMA
//
//  Created by Umar Yaqub on 04/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirebaseDatabaseManager {
    
    private let session: FirebaseDatabaseSession
    
    init(session: FirebaseDatabaseSession) {
        self.session = session
    }
    
    func searchMemberUsing(_ dob: String, _ surname: String, completion: @escaping (String?, Bool) -> Void) {
        session.searchMemberUsing(dob, surname) { (shmaId, memberFound) in
            completion(shmaId, memberFound)
        }
    }
    
    func checkShmaIdExistsWithInOfflineDatabaseUsing(_ shmaId: String, completion: @escaping (Bool, String?, String?) -> Void) {
        session.checkShmaIdExistsWithInOfflineDatabaseUsing(shmaId) { (exists, firstname, surname) in
            completion(exists, firstname, surname)
        }
    }
    
    func checkShmaIdIsntAlreadyRegisteredInFirebase(_ shmaId: String, completion: @escaping (Bool) -> Void) {
        session.checkShmaIdIsntAlreadyRegisteredInFirebase(shmaId) { (registered) in
            completion(registered)
        }
    }
    
    func saveExistingMemberDetailsToDatabase(_ uid: String, _ shmaId: String, _ firstname: String, _ surname: String, _ email: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        session.saveExistingMemberDetailsToDatabase(uid, shmaId, firstname, surname, email) { (error, ref) in
            completion(error, ref)
        }
    }
    
    func saveNewMemberDetailsToDatabase(_ uid: String, _ firstname: String, _ surname: String, _ email: String, _ dob: String, _ addressLineOne: String, _ addressLineTwo: String, _ town: String, _ postcode: String, _ mobileNo: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        session.saveNewMemberDetailsToDatabase(uid, firstname, surname, email, dob, addressLineOne, addressLineTwo, town, postcode, mobileNo) { (error, ref) in
            completion(error, ref)
        }
    }
    
    func saveNewMembersSpouseDetailsToDatabase(_ uid: String, _ spouseName: String, _ spouseEmail: String, _ spouseDob: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        session.saveNewMembersSpouseDetailsToDatabase(uid, spouseName, spouseEmail, spouseDob) { (error, ref) in
            completion(error, ref)
        }
    }
    
    func saveNewMembersChildrenDetailsToDatabase(_ uid: String, _ childName: String, _ childDob: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        session.saveNewMembersChildrenDetailsToDatabase(uid, childName, childDob) { (error, ref) in
            completion(error, ref)
        }
    }
    
}
