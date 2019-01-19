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
    let dob = "04/04/18"
    let surname = "Doe"
    
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
}
