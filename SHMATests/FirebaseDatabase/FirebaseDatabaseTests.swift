//
//  FirebaseDatabaseTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 07/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation
@testable import SHMA
import FirebaseDatabase
import XCTest

class FirebaseDatabaseTests: XCTestCase {
    
    var sut: FirebaseDatabaseManager!
    var session: FirebaseDatabaseSessionMock!
    let dob = "04/04/2018"
    let firstname = "John"
    let surname = "Doe"
    let email = "test@gmail.com"
    let adLineOne = "4 Park"
    let adLineTwo = "Lane"
    let town = "Town"
    let postcode = "GU11 1PL"
    let mobileNo = "123455667"
    let shmaId = "123"
    let uid = "1234566"
    let spouseName = "Spouse"
    let spouseEmail = "test@gmail.com"
    let spouseDob = "04/04/2018"
    let childName = "Child"
    let childDob = "01/01/2019"
    
    override func setUp() {
        super.setUp()
        
        session = FirebaseDatabaseSessionMock()
        sut = FirebaseDatabaseManager(session: session)
    }
    
    override func tearDown() {
        sut = nil
        session = nil
        super.tearDown()
    }
    
    func testDatabaseCallWasInitiated() {
        session.searchMemberUsing(dob, surname) { (shmaId, wasFound) in
        }
        XCTAssert(session.didInitiateDatabaseCall)
    }
    
    func testCorrectDOBWasUsed() {
        session.searchMemberUsing(dob, surname) { (shmaId, wasFound) in
        }
        XCTAssertEqual(dob, session.memberDob)
    }
    
    func testCorrectSurnameWasUsed() {
        session.searchMemberUsing(dob, surname) { (shmaId, wasFound) in
        }
        XCTAssertEqual(surname, session.memberSurname)
    }
    
    func testShmaIdWasReturned() {
        session.searchMemberUsing(dob, surname) { (shmaId, wasFound) in
            XCTAssertEqual(shmaId, self.session.memberShmaId)
        }
    }
    
    func testUserWasReturned() {
        session.searchMemberUsing(dob, surname) { (shmaId, wasFound) in
            XCTAssert(wasFound)
        }
    }
    
//    func testShmaIdOfflineTableCheckWasInitiated() {
//        session.checkShmaIdExistsWithInOfflineDatabaseUsing(shmaId) { (exists, firstname, surname) in
//        }
//        XCTAssert(session.didInitiateDatabaseCall)
//        XCTAssertEqual(session.memberShmaId, shmaId)
//    }
    
    func testDuplicateShmaIdCheckWasInitiated() {
        session.checkShmaIdIsntAlreadyRegisteredInFirebase(shmaId) { (exists) in
        }
        XCTAssert(session.didInitiateDatabaseCall)
        XCTAssertEqual(session.memberShmaId, shmaId)
    }
    
    func testExistingMemberDetailsCaptureWasInitiated() {
        session.saveExistingMemberDetailsToDatabase(uid, shmaId, firstname, surname, email) { (error, ref) in
        }
        XCTAssert(session.didInitiateDatabaseCall)
        XCTAssertEqual(session.memberUid, uid)
        XCTAssertEqual(session.memberShmaId, shmaId)
        XCTAssertEqual(session.memberFirstname, firstname)
        XCTAssertEqual(session.memberSurname, surname)
        XCTAssertEqual(session.memberEmail, email)
    }
    
    func testNewMemberDetailsCaptureWasInitiated() {
        session.saveNewMemberDetailsToDatabase(uid, firstname, surname, email, dob, adLineOne, adLineTwo, town, postcode, mobileNo) { (error, ref) in
        }
        XCTAssert(session.didInitiateDatabaseCall)
        XCTAssertEqual(session.memberUid, uid)
        XCTAssertEqual(session.memberDob, dob)
        XCTAssertEqual(session.memberFirstname, firstname)
        XCTAssertEqual(session.memberSurname, surname)
        XCTAssertEqual(session.memberEmail, email)
         XCTAssertEqual(session.memberMobileNo, mobileNo)
         XCTAssertEqual(session.memberAddressLineOne, adLineOne)
         XCTAssertEqual(session.memberAddressLineTwo, adLineTwo)
         XCTAssertEqual(session.memberTown, town)
         XCTAssertEqual(session.memberPostcode, postcode)
    }
    
    func testnewMemberSpouseDetailsCaptureWasInitiated() {
        session.saveNewMembersSpouseDetailsToDatabase(uid, spouseName, spouseEmail, spouseDob) { (error, ref) in
        }
        XCTAssert(session.didInitiateDatabaseCall)
        XCTAssertEqual(session.memberSpouseName, spouseName)
        XCTAssertEqual(session.memberSpouseEmail, spouseEmail)
        XCTAssertEqual(session.memberSpouseDob, spouseDob)
    }
    
    func testnewMemberChildDetailsCaptureWasInitiated() {
        session.saveNewMembersChildrenDetailsToDatabase(uid, childName, childDob) { (error, ref) in
        }
        XCTAssert(session.didInitiateDatabaseCall)
        XCTAssertEqual(session.memberChildName, childName)
        XCTAssertEqual(session.memberChildDob, childDob)
    }
}
