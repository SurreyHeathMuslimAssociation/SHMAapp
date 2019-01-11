//
//  TermsAndConditionsViewTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 11/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class TermsAndConditionsViewTests: XCTestCase, TermsAndConditionsViewDelegate {
    
    var sut: TermsAndConditionsView!
    var traitCollection: UITraitCollection!
    
    var didFireAgree: Bool!
    var didFireDisagree: Bool!
    
    override func setUp() {
        super.setUp()
        
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        sut = TermsAndConditionsView(traitCollection: traitCollection)
        sut.delegate = self
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        didFireAgree = nil
        didFireDisagree = nil
        super.tearDown()
    }
    
    func testDidFireAgree() {
        sut.agreeButton.sendActions(for: .touchUpInside)
        XCTAssert(didFireAgree)
    }
    
    func didPressAgree() {
        didFireAgree = true
    }
    
    func testDidFireDisagree() {
        sut.disagreeButton.sendActions(for: .touchUpInside)
        XCTAssert(didFireDisagree)
    }
    
    func didPressDisagree() {
        didFireDisagree = true
    }
}
