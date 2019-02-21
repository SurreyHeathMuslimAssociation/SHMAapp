//
//  PrayerTimesViewModelTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 19/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class PrayerTimesViewModelTests: XCTestCase {
    
    var sut: PrayerTimesViewModel!
    var traitCollection: UITraitCollection!
    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        
        sut = PrayerTimesViewModel()
        sut.traitCollection = traitCollection
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        super.tearDown()
    }
    
    func testGetsPrayerTimesLabelFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getPrayerTimesLabelFontForEachDevice(), UIFont.systemFont(ofSize: 35))
        } else {
            XCTAssertEqual(sut.getPrayerTimesLabelFontForEachDevice(), UIFont.systemFont(ofSize: 25))
        }
    }
    
    func testGetsPrayerTitlesLabelFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getPrayerTitlesLabelFontForEachDevice(), UIFont.systemFont(ofSize: 22))
        } else {
            XCTAssertEqual(sut.getPrayerTitlesLabelFontForEachDevice(), UIFont.systemFont(ofSize: 14))
        }
    }
    
    func testGetsLabelTextColour() {
        XCTAssertEqual(sut.getLabelTextColour(), .lightGray)
    }
}
