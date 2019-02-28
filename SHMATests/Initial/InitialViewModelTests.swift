//
//  InitialViewModelTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 20/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class InitialViewModelTests: XCTestCase {
    
    var sut: InitialViewModel!
    var traitCollection: UITraitCollection!
    var buttonStackView: UIStackView!
    var shmaLogoIV: UIImageView!
    var view: UIView!
    
    let iPadFont = UIFont.systemFont(ofSize: 25)
    let iPhoneFont = UIFont.systemFont(ofSize: 14)

    override func setUp() {
        super.setUp()
        // setting traits
        //let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPhonePortraitTraits

        buttonStackView = UIStackView()
        shmaLogoIV = UIImageView()
        view = UIView()
        sut = InitialViewModel(traitCollection, buttonStackView, shmaLogoIV, view: view)
    }

    override func tearDown() {
        traitCollection = nil
        buttonStackView = nil
        shmaLogoIV = nil
        view = nil
        sut = nil
        super.tearDown()
    }

    // shmaLogoIV
    func testGetsCorrectSHMALogoImageViewHeightForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getSHMALogoImageViewHeight(), 298)
        } else {
            XCTAssertEqual(sut.getSHMALogoImageViewHeight(), 149)
        }
    }
    
    func testGetsCorrectSHMALogoImageViewWidthForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getSHMALogoImageViewWidth(), 520)
        } else {
            XCTAssertEqual(sut.getSHMALogoImageViewWidth(), 260)
        }
    }
    
    // buttonStackView
    func testGetsCorrectButtonStackViewHeightForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getButtonStackViewHeight(), 170)
        } else {
            XCTAssertEqual(sut.getButtonStackViewHeight(), 90)
        }
    }
    
    func testGetsCorrectButtonCornerRadiusAndSpacingForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getButtonCornerRadiusAndSpacing(), 10)
        } else {
            XCTAssertEqual(sut.getButtonCornerRadiusAndSpacing(), 5)
        }
    }
    
    func testGetsCorrectButtonFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getButtonFont(), iPadFont)
        } else {
            XCTAssertEqual(sut.getButtonFont(), iPhoneFont)
        }
    }
}
