//
//  MemberViewModelTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 09/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class MemberViewModelTests: XCTestCase {
    
    var sut: MemberViewModel!
    var traitCollection: UITraitCollection!
    var memberView: UIView!
    
    let iPadMainLabelFont = UIFont.systemFont(ofSize: 26)
    let iPhoneMainLabelFont = UIFont.systemFont(ofSize: 16)
    let iPadButtonFont = UIFont.systemFont(ofSize: 22)
    let iPhoneButtonFont = UIFont.systemFont(ofSize: 14)
    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        memberView = UIView()
        
        sut = MemberViewModel(traitCollection, memberView)
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        memberView = nil
        super.tearDown()
    }
    
    func testGetsCorrectMainLabelFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getMainLabelFontForEachDevice(), iPadMainLabelFont)
        } else {
            XCTAssertEqual(sut.getMainLabelFontForEachDevice(), iPhoneMainLabelFont)
        }
    }
    
    func testGetsCorrectButtonFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getButtonFontForEachDevice(), iPadButtonFont)
        } else {
            XCTAssertEqual(sut.getButtonFontForEachDevice(), iPhoneButtonFont)
        }
    }
    
    func testGetsCorrectButtonStackViewWidthForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getButtonStackViewWidthForEachDevice(), 520)
        } else {
            XCTAssertEqual(sut.getButtonStackViewWidthForEachDevice(), 260)
        }
    }
    
    func testGetsCorrectButtonStackViewHeightForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getButtonStackViewHeightForEachDevice(), 255)
        } else {
            XCTAssertEqual(sut.getButtonStackViewHeightForEachDevice(), 135)
        }
    }
    
    func testGetsCorrectButtonCornerRadiusAndSpacingForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getButtonCornerRadiusAndSpacingForEachDevice(), 10)
        } else {
            XCTAssertEqual(sut.getButtonCornerRadiusAndSpacingForEachDevice(), 5)
        }
    }
    
    func testGetsCorrectMemberViewHeightForLandscapeiPhonesAndNonLandscapeDevices() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getMemberViewHeightForEachDevice().constant, 250)
        } else {
            XCTAssertEqual(sut.getMemberViewHeightForEachDevice().constant, 180)
        }
    }
}
