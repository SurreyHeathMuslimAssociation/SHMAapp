//
//  FirebaseAuthTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 11/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation
@testable import SHMA
import FirebaseDatabase
import XCTest

class FirebaseAuthTests: XCTestCase {
    
    var sut: FirebaseAuthManager!
    var session: FirebaseAuthSessionMock!
    let email = "test1@gmail.com"
    let password = "123456"
    
    override func setUp() {
        super.setUp()
        
        session = FirebaseAuthSessionMock()
        sut = FirebaseAuthManager(session: session)
    }
    
    override func tearDown() {
        sut = nil
        session = nil
        super.tearDown()
    }
    
    func testDidInitiateLogin() {
        session.signIn(with: email, password: password) { (result, error) in
        }
        XCTAssert(session.didInitiateAuth)
    }
    
    func testValidEmailWasUsed() {
        session.signIn(with: email, password: password) { (result, error) in
        }
        XCTAssertEqual(email, session.userEmail)
    }
    
    func testValidPasswordWasUsed() {
        session.signIn(with: email, password: password) { (result, error) in
        }
        XCTAssertEqual(password, session.userPassword)
    }
    
    func testDidInitiateSigningOutProcess() {
        session.signOut { (success, error) in
        }
        XCTAssert(session.didInitiateSigningOut)
    }
    
    func testDidInitiateUserCreation() {
        session.createUser(with: email, password: password) { (result, error) in
        }
        XCTAssert(session.didInitiateUserCreation)
        XCTAssertEqual(session.userEmail, email)
        XCTAssertEqual(session.userPassword, password)
    }
    
    func testDidInitiateUserPasswordReset() {
        session.sendPasswordReset(with: email) { (error) in
        }
        XCTAssert(session.didInitiatePasswordReset)
        XCTAssertEqual(session.userEmail, email)
    }
}

