//
//  FirebaseDatabaseSessionMock.swift
//  SHMATests
//
//  Created by Umar Yaqub on 07/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation
import FirebaseDatabase
@testable import SHMA

class FirebaseDatabaseSessionMock: FirebaseDatabaseSession {
    
    var didInitiateDatabaseCall = false
    var memberDob: String!
    var memberSurname: String!
    var memberFirstname: String!
    var memberShmaId = "100"
    let wasFound = true
    
    func searchMemberUsing(_ dob: String, _ surname: String, completion: @escaping (String?, Bool) -> Void) {
        didInitiateDatabaseCall = true
        memberDob = dob
        memberSurname = surname
        completion(memberShmaId, wasFound)
    }
    
    func checkShmaIdExistsWithInOfflineDatabaseUsing(_ shmaId: String, completion: @escaping (Bool, String?, String?) -> Void) {
        didInitiateDatabaseCall = true
        memberShmaId = shmaId
    }
    
    func checkShmaIdIsntAlreadyRegisteredInFirebase(_ shmaId: String, completion: @escaping (Bool) -> Void) {
        didInitiateDatabaseCall = true
        memberShmaId = shmaId
    }
    
    func saveMemberDetailsToDatabase(_ uid: String, _ shmaId: String, _ firstname: String, _ surname: String, _ email: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        didInitiateDatabaseCall = true
        memberShmaId = shmaId
        memberSurname = surname
        memberFirstname = firstname
    }
    
}
