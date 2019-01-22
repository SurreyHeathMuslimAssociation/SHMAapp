//
//  PasswordResetViewTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 21/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class PasswordResetViewTests: XCTestCase, PasswordResetViewDelegate {
    
    var sut: PasswordResetView!
    var traitCollection: UITraitCollection!
    var didPressPasswordReset: Bool!
    
    override func setUp() {
        super.setUp()
        
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        
        sut = PasswordResetView(traitCollection: iPadTraits)
        sut.delegate = self
        didPressPasswordReset = false
    }
    
    override func tearDown() {
        sut = nil
        didPressPasswordReset = nil
        super.tearDown()
    }
    
    func testDidTapPasswordResetButton() {
        sut.resetPasswordButton.sendActions(for: .touchUpInside)
        XCTAssert(didPressPasswordReset)
    }
    
    func didTapPasswordReset(_ email: String) {
        didPressPasswordReset = true
    }
    
    
}
