//
//  MemberViewTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 09/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class MemberViewTests: XCTestCase, MemberViewDelegate {
    
    var sut: MemberView!
    var didFireLogin: Bool!
    var didFireExistingRegistration: Bool!
    var didFireNewRegistration: Bool!
    
    override func setUp() {
        super.setUp()
        
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        
        sut = MemberView(traitCollection: iPadTraits)
        sut.delegate = self
        
        didFireLogin = false
        didFireExistingRegistration = false
        didFireNewRegistration = false
    }
    
    override func tearDown() {
        sut = nil
        didFireLogin = nil
        didFireExistingRegistration = nil
        didFireNewRegistration = nil
        super.tearDown()
    }
    
    func testLoginWasFired() {
        sut.loginButton.sendActions(for: .touchUpInside)
        XCTAssert(didFireLogin)
    }
    
    func didPressLogin() {
        didFireLogin = true
    }
    
    func testExistingRegistrationWasFired() {
        sut.existingMemberRegistrationButton.sendActions(for: .touchUpInside)
        XCTAssert(didFireExistingRegistration)
    }
    
    func didPressExistingRegistration() {
        didFireExistingRegistration = true
    }
    
    func testNewRegistrationWasFired() {
        sut.newMemberRegistrationButton.sendActions(for: .touchUpInside)
        XCTAssert(didFireNewRegistration)
    }
    
    func didPressNewRegistration() {
        didFireNewRegistration = true
    }
}

