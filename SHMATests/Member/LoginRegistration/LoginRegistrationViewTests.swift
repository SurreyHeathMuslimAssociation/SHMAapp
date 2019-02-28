//
//  LoginRegistrationViewTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 11/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class LoginRegistrationViewTests: XCTestCase, LoginRegistrationViewDelegate {
    
    var sut: LoginRegistrationView!
    var traitCollection: UITraitCollection!
    var didFireLoginRegistration: Bool!
    var didSwitchMembershipType: Bool!
    var didSelectLogin: Bool!
    var didSelectExistingMemberRegistration: Bool!
    var didSelectNewMemberRegistration: Bool!
    var didTapPasswordReset: Bool!
    
    override func setUp() {
        super.setUp()
        
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        didSelectLogin = true
        didSelectNewMemberRegistration = false
        didSelectExistingMemberRegistration = false
        didSwitchMembershipType = false
        didTapPasswordReset = false
        
        sut = LoginRegistrationView(traitCollection: traitCollection, didSelectLogin, didSelectExistingMemberRegistration, didSelectNewMemberRegistration)
        sut.delegate = self
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        didSelectLogin = nil
        didSelectNewMemberRegistration = nil
        didSelectExistingMemberRegistration = nil
        didFireLoginRegistration = nil
        didSwitchMembershipType = nil
        didTapPasswordReset = nil
        super.tearDown()
    }
    
    func testDidFireLoginRegistration() {
        sut.loginRegisterButton.sendActions(for: .touchUpInside)
        XCTAssert(didFireLoginRegistration)
    }
    
    func testDidSwitchMembershipType() {
        sut.membershipSwitch.sendActions(for: .valueChanged)
        XCTAssert(didSwitchMembershipType)
    }
    
    func testDidTapPasswordResetButton() {
        sut.passswordResetButton.sendActions(for: .touchUpInside)
        XCTAssert(didTapPasswordReset)
    }
    
    func didPressLoginRegister() {
        didFireLoginRegistration = true
    }
    
    func didSwitchToFamilyMembership() {
        didSwitchMembershipType = true
    }
    
    func didPressPasswordReset() {
        didTapPasswordReset = true
    }
}
