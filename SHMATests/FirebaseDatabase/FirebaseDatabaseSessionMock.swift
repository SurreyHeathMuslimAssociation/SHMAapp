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
    var memberLastName: String!
    var memberMiddleName: String!
    var memberFirstName: String!
    var memberEmail: String!
    var memberPostcode: String!
    var memberMobileNo: String!
    var memberTown: String!
    var memberAddressLineOne: String!
    var memberAddressLineTwo: String!
    var memberShmaId: Int!
    var MemberMembershipType: String!
    var memberCounty: String!
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
        memberLastName = surname
        completion(String(memberShmaId), wasFound)
    }
    
    func checkShmaIdIsntAlreadyRegisteredInFirebase(_ shmaId: String, completion: @escaping (Bool) -> Void) {
        didInitiateDatabaseCall = true
        memberShmaId = Int(shmaId)
    }
    
    func saveExistingMemberDetailsToDatabase(_ uid: String, _ member: Member, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        didInitiateDatabaseCall = true
        memberUid = uid
        memberFirstName = member.firstName
        memberMiddleName = member.middleName
        memberLastName = member.lastName
        memberShmaId = member.shmaId
        memberDob = member.dob
        MemberMembershipType = member.membershipType
    }
    
    func saveNewMemberDetailsToDatabase(_ uid: String, _ member: Member, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        didInitiateDatabaseCall = true
        memberUid = uid
        memberFirstName = member.firstName
        memberMiddleName = member.middleName
        memberLastName = member.lastName
        memberShmaId = member.shmaId
        memberEmail = member.email
        memberDob = member.dob
        MemberMembershipType = member.membershipType
        memberAddressLineOne = member.addressLineOne
        memberAddressLineTwo = member.addressLineTwo
        memberTown = member.town
        memberCounty = member.county
        memberPostcode = member.postcode
        memberMobileNo = member.mobileNumber
    }
    
    func saveNewMemberFamilyDetailsToDatabase(_ uid: String, _ family: Family, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        didInitiateDatabaseCall = true
        memberUid = uid
        if family.relationship == .Spouse {
            memberSpouseName = family.fullName
            memberSpouseDob = family.dob
            memberSpouseEmail = family.email
        } else {
            memberChildName = family.fullName
            memberChildDob = family.dob
        }
    }
    
    
    
    func fetchExistingMemberFromOfflineDatabaseUsing(_ shmaId: String, completion: @escaping (Bool, Member?) -> Void) {
        didInitiateDatabaseCall = true
        memberShmaId = Int(shmaId)
    }
    
   
    func generateNewMemberShmaId(completion: @escaping (Int) -> Void) {
        didInitiateDatabaseCall = true
    }
    
    
    func fetchAssociationDetails(completion: @escaping (Association) -> Void) {
        didInitiateDatabaseCall = true
    }
    
    func fetchMemberDetails(_ uid: String, completion: @escaping (Member) -> Void) {
        didInitiateDatabaseCall = true
        memberUid = uid
    }
    
}
