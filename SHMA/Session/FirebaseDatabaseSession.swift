//
//  FirebaseDatabaseSession.swift
//  SHMA
//
//  Created by Umar Yaqub on 04/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol FirebaseDatabaseSession {
    func searchMemberUsing(_ dob: String,_ surname: String, completion: @escaping (String?, Bool) -> Void)
    func checkShmaIdExistsWithInOfflineDatabaseUsing(_ shmaId: String, completion: @escaping (Bool, String?, String?) -> Void)
    func checkShmaIdIsntAlreadyRegisteredInFirebase(_ shmaId: String, completion: @escaping (Bool) -> Void)
    func saveExistingMemberDetailsToDatabase(_ uid: String, _ shmaId: String, _ firstname: String, _ surname: String, _ email: String, completion: @escaping (Error?, DatabaseReference?) -> Void)
    func saveNewMemberDetailsToDatabase(_ uid: String, _ firstname: String, _ surname: String, _ email: String, _ dob: String, _ addressLineOne: String, _ addressLineTwo: String, _ town: String, _ postcode: String, _ mobileNo: String, completion: @escaping (Error?, DatabaseReference?) -> Void)
    func saveNewMembersSpouseDetailsToDatabase(_ uid: String, _ spouseName: String, _ spouseEmail: String, _ spouseDob: String, completion: @escaping (Error?, DatabaseReference?) -> Void)
    func saveNewMembersChildrenDetailsToDatabase(_ uid: String, _ childName: String, _ childDob: String, completion: @escaping (Error?, DatabaseReference?) -> Void)
}
