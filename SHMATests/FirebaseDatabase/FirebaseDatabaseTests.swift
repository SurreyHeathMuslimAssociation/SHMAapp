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
    var member: Member!
    var family: Family!
    
    let dob = "04/04/2018"
    let firstname = "John"
    let middlename = "Middle"
    let surname = "Doe"
    let email = "test@gmail.com"
    let adLineOne = "4 Park"
    let adLineTwo = "Lane"
    let town = "Town"
    let postcode = "GU11 1PL"
    let county = "County"
    let mobileNo = "123455667"
    let shmaId = 123
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
        setupMember()
        setupFamily()
    }
    
    private func setupMember() {
        do {
            let value = ["firstName": firstname, "middleName": middlename, "lastName": surname, "membershipType": "Single", "status": "Applied", "shmaId": shmaId, "email": email, "addressLineOne": adLineOne, "addressLineTwo": adLineTwo, "town": town, "postcode": postcode, "county": county, "mobileNo": mobileNo, "DOB": dob] as [String : Any]
            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
            let member = try JSONDecoder().decode(Member.self, from: jsonData)
            self.member = member
        } catch {
            print(error)
        }
    }
    
    private func setupFamily() {
        do {
            let value = ["fullName": spouseName, "email": spouseEmail, "DOB": spouseDob] as [String : Any]
            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
            let family = try JSONDecoder().decode(Family.self, from: jsonData)
            self.family = family
            self.family.relationship = .Spouse
        } catch {
            print(error)
        }
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
        XCTAssertEqual(surname, session.memberLastName)
    }
    
    func testShmaIdWasReturned() {
        session.searchMemberUsing(dob, surname) { (shmaId, wasFound) in
            XCTAssertEqual(shmaId, String(self.session.memberShmaId))
        }
    }
    
    func testUserWasReturned() {
        session.searchMemberUsing(dob, surname) { (shmaId, wasFound) in
            XCTAssert(wasFound)
        }
    }

    func testDuplicateShmaIdCheckWasInitiated() {
        session.checkShmaIdIsntAlreadyRegisteredInFirebase(String(shmaId)) { (exists) in
        }
        XCTAssert(session.didInitiateDatabaseCall)
        XCTAssertEqual(session.memberShmaId, Int(shmaId))
    }
    
    func testExistingMemberDetailsCaptureWasInitiated() {
        session.saveExistingMemberDetailsToDatabase(uid, member) { (_, _) in
        }
        XCTAssert(session.didInitiateDatabaseCall)
        XCTAssertEqual(session.memberUid, uid)
        XCTAssertEqual(session.memberShmaId, shmaId)
        XCTAssertEqual(session.memberFirstName, firstname)
        XCTAssertEqual(session.memberMiddleName, middlename)
        XCTAssertEqual(session.memberLastName, surname)
        XCTAssertEqual(session.memberDob, dob)
    }
    
    func testNewMemberDetailsCaptureWasInitiated() {
        session.saveNewMemberDetailsToDatabase(uid, member) { (_, _) in
        }
        XCTAssert(session.didInitiateDatabaseCall)
        XCTAssertEqual(session.memberUid, uid)
        XCTAssertEqual(session.memberShmaId, shmaId)
        XCTAssertEqual(session.memberFirstName, firstname)
        XCTAssertEqual(session.memberMiddleName, middlename)
        XCTAssertEqual(session.memberLastName, surname)
        XCTAssertEqual(session.memberEmail, email)
        XCTAssertEqual(session.memberPostcode, postcode)
        XCTAssertEqual(session.memberTown, town)
        XCTAssertEqual(session.memberAddressLineOne, adLineOne)
        XCTAssertEqual(session.memberAddressLineTwo, adLineTwo)
        XCTAssertEqual(session.memberMobileNo, mobileNo)
        XCTAssertEqual(session.memberDob, dob)
    }
    
    func testnewMemberFamilyDetailsCaptureWasInitiated() {
        session.saveNewMemberFamilyDetailsToDatabase(uid, family) { (_, _) in
        }
        XCTAssert(session.didInitiateDatabaseCall)
        XCTAssertEqual(session.memberSpouseName, spouseName)
        XCTAssertEqual(session.memberSpouseEmail, spouseEmail)
        XCTAssertEqual(session.memberSpouseDob, spouseDob)
    }

    func testBusinessesPlaceIdAndIconUrlFetchWasInitiated() {
        session.fetchBusinessesPlaceIdAndIconUrl { (placeId, IconUrl) in
        }
        XCTAssert(session.didInitiateDatabaseCall)
    }
    
    func testFuneralContactsFetchWasInitiated() {
        session.fetchFuneralContacts { (contact) in
        }
        XCTAssert(session.didInitiateDatabaseCall)
    }
}
