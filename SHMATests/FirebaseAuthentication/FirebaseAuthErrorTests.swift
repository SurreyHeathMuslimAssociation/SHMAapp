//
//  FirebaseAuthErrorTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 22/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
import FirebaseAuth
@testable import SHMA

class FirebaseAuthErrorTests: XCTestCase {
    
    func testAuthErrorWith17005ReturnsUserDisabled() {
        let authenticationError = AuthErrorCode(rawValue: 17005)
        XCTAssertEqual(AuthErrorCode.userDisabled, authenticationError)
    }
 
    func testAuthErrorWith17007ReturnsEmailAlreadyInUse() {
        let authenticationError = AuthErrorCode(rawValue: 17007)
        XCTAssertEqual(AuthErrorCode.emailAlreadyInUse, authenticationError)
    }
    
    func testAuthErrorWith17008ReturnsInvalidEmail() {
        let authenticationError = AuthErrorCode(rawValue: 17008)
        XCTAssertEqual(AuthErrorCode.invalidEmail, authenticationError)
    }
    
    func testAuthErrorWith17026ReturnsInvalidPassword() {
        let authenticationError = AuthErrorCode(rawValue: 17009)
        XCTAssertEqual(AuthErrorCode.wrongPassword, authenticationError)
    }
    
    func testAuthErrorWith17011ReturnsUserNotFound() {
        let authenticationError = AuthErrorCode(rawValue: 17011)
        XCTAssertEqual(AuthErrorCode.userNotFound, authenticationError)
    }
    
    func testAuthErrorWith17020ReturnsNetworkError() {
        let authenticationError = AuthErrorCode(rawValue: 17020)
        XCTAssertEqual(AuthErrorCode.networkError, authenticationError)
    }
    
    func testAuthErrorWith17026ReturnsWeakPassword() {
        let authenticationError = AuthErrorCode(rawValue: 17026)
        XCTAssertEqual(AuthErrorCode.weakPassword, authenticationError)
    }
    
    func testAuthErrorWith17032ReturnsInvalidSender() {
        let authenticationError = AuthErrorCode(rawValue: 17032)
        XCTAssertEqual(AuthErrorCode.invalidSender, authenticationError)
    }
    
    func testAuthErrorWith17033ReturnsInvalidRecipientEmail() {
        let authenticationError = AuthErrorCode(rawValue: 17033)
        XCTAssertEqual(AuthErrorCode.invalidRecipientEmail, authenticationError)
    }
    
    func testAuthErrorWith17034ReturnsMissingEmail() {
        let authenticationError = AuthErrorCode(rawValue: 17034)
        XCTAssertEqual(AuthErrorCode.missingEmail, authenticationError)
    }
}
