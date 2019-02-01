//
//  WelcomeViewTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 30/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class WelcomeViewTests: XCTestCase, WelcomeViewDelegate {
    
    var sut: WelcomeView!
    var member: Member!
    var didSendUserToLogin: Bool!
    
    override func setUp() {
        super.setUp()
        
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        do {
            let value = ["firstName": "firstname", "lastName": "lastname", "membershipType": "Applied"]
            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
            let member = try JSONDecoder().decode(Member.self, from: jsonData)
            self.member = member
        } catch {
            print(error)
        }
        sut = WelcomeView(traitCollection: iPadTraits, member, true)
        sut.delegate = self
        
        didSendUserToLogin = false
    }
    
    override func tearDown() {
        sut = nil
        didSendUserToLogin = nil
        member = nil
        super.tearDown()
    }
    
    func sendUserToLogin() {
        didSendUserToLogin = true
    }
    
    func testdoesSendUserToLogin() {
        sut.handleLoginReturn()
        XCTAssert(didSendUserToLogin)
    }
    
}
