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
    var memberEmail: String!
    var memberPostcode: String!
    var memberMobileNo: String!
    var memberTown: String!
    var memberAddressLineOne: String!
    var memberAddressLineTwo: String!
    var memberShmaId = "100"
    let wasFound = true
    var memberUid: String!
    var memberSpouseName: String!
    var memberSpouseDob: String!
    var memberSpouseEmail: String!
    var memberChildName: String!
    var memberChildDob: String!
    
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
    
    func saveExistingMemberDetailsToDatabase(_ uid: String, _ shmaId: String, _ firstname: String, _ surname: String, _ email: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        didInitiateDatabaseCall = true
        memberShmaId = shmaId
        memberUid = uid
        memberFirstname = firstname
        memberSurname = surname
        memberEmail = email
    }
    
    func saveNewMemberDetailsToDatabase(_ uid: String, _ firstname: String, _ surname: String, _ email: String, _ dob: String, _ addressLineOne: String, _ addressLineTwo: String, _ town: String, _ postcode: String, _ mobileNo: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        didInitiateDatabaseCall = true
        memberUid = uid
        memberFirstname = firstname
        memberSurname = surname
        memberEmail = email
        memberDob = dob
        memberAddressLineOne = addressLineOne
        memberAddressLineTwo = addressLineTwo
        memberTown = town
        memberPostcode = postcode
        memberMobileNo = mobileNo
    }
    
    func saveNewMembersSpouseDetailsToDatabase(_ uid: String, _ spouseName: String, _ spouseEmail: String, _ spouseDob: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        didInitiateDatabaseCall = true
        memberSpouseName = spouseName
        memberSpouseEmail = spouseEmail
        memberSpouseDob = spouseDob
    }
    
    func saveNewMembersChildrenDetailsToDatabase(_ uid: String, _ childName: String, _ childDob: String, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        didInitiateDatabaseCall = true
        memberChildName = childName
        memberChildDob = childDob
    }
    
}
