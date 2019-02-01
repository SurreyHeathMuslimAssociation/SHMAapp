//
//  WelcomeViewModelTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 30/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class WelcomeViewModelTests: XCTestCase {
    
    var sut: WelcomeViewModel!
    var traitCollection: UITraitCollection!
    var member: Member!
    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        
        do {
            let value = ["firstName": "firstname", "lastName": "lastname", "membershipType": "Single", "status": "Approved", "shmaId": 123] as [String : Any]
            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
            let member = try JSONDecoder().decode(Member.self, from: jsonData)
            self.member = member
        } catch {
            print(error)
        }
        
        sut = WelcomeViewModel(traitCollection, member)
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        member = nil
        super.tearDown()
    }
    
    func testGetsWelcomePageTitle() {
        if member.status == "Approved" {
            XCTAssertEqual(sut.getWelcomePageTitle(), "Welcome, ")
        } else {
            XCTAssertEqual(sut.getWelcomePageTitle(), "Congratulations on joining SHMA,\n")
        }
    }
    
    func testGetsWelcomePageMessage() {
        if member.status == "Approved" {
            let message = "Congratulations on signing up to our Surrey Heath Muslim Association App, this is another step to bringing our members closer.\n\nWe have sent you an email asking you to verfiy your account, you will be able to log in once it has been verified."
            XCTAssertEqual(sut.getWelcomePageMessage(), message)
        } else {
            let message = "You are now just a few steps away from being a full feldged Surrey Heath Muslim Association Member.\n\n Please swipe right to continue..."
            XCTAssertEqual(sut.getWelcomePageMessage(), message)
        }
    }
    
    func testGetsDetailPageMessage() {
        var cost: Int!
        if member.membershipType == "Single" {
            cost = 4
        } else {
            cost = 7
        }
        let message = "Your membership cost is £\(cost ?? 0).\n However, many of our members choose to contribute more and the rest is counted as donation.\nThis enables us to provide more services to our members."
        XCTAssertEqual(sut.getDetailPageMessage(), message)
    }
    
    func testGetsPaymentPageMessage() {
        let message = "Just few more steps to go:\n\n✔ Verfiy your account via the link in your email\n✔ Setup your monthly standing order to the following account:\n\nSurrey Heath Muslim Association\n(Registered Charity Number 1126441)\nAl Rayan Bank, 77-79 Edgware Road, London. W2 2HZ\nSort Code: 30-00-83\nAccount Number: 01222601\n\nThe payment reference must be: SHMA-\(member.shmaId ?? 0)"
        XCTAssertEqual(sut.getPaymentPageMessage(), message)
    }
}

