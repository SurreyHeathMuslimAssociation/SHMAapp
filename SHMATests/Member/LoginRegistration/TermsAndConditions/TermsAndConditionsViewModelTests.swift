//
//  TermsAndConditionsViewModelTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 11/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class TermsAndConditionsViewModelTests: XCTestCase {
    
    var sut: TermsAndConditionsViewModel!
    var traitCollection: UITraitCollection!
    var termsAndConditionsView: UIView!
    
    let iPadAgreeButtonFont = UIFont.boldSystemFont(ofSize: 22)
    let iPhoneAgreeButtonFont = UIFont.boldSystemFont(ofSize: 14)
    let iPadDisagreeButtonFont = UIFont.systemFont(ofSize: 22)
    let iPhoneDisagreeButtonFont = UIFont.systemFont(ofSize: 14)
    
    override func setUp() {
        super.setUp()
        
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        termsAndConditionsView = UIView()
        
        sut = TermsAndConditionsViewModel(traitCollection, termsAndConditionsView: termsAndConditionsView)
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        termsAndConditionsView = nil
        super.tearDown()
    }
    
    func testGetsCorrectAgreeButtonFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getAgreeButtonFontForEachDevice(), iPadAgreeButtonFont)
        } else {
            XCTAssertEqual(sut.getAgreeButtonFontForEachDevice(), iPhoneAgreeButtonFont)
        }
    }
    
    func testGetsCorrectDisagreeButtonFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getDisagreeButtonFontForEachDevice(), iPadDisagreeButtonFont)
        } else {
            XCTAssertEqual(sut.getDisagreeButtonFontForEachDevice(), iPhoneDisagreeButtonFont)
        }
    }
    
    // navbar title attributes tests
    func testGetsNavigationBarTitleTextAttributesForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        } else {
            XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        }
    }
    
    func testGetsNavBarText() {
        XCTAssertEqual(sut.getNavBarText(), "SHMA Terms And Conditions")
    }
}
