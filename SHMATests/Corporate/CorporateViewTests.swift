//
//  CorporateViewTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 27/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class CorporateViewTests: XCTestCase, CorporateViewDelegate {
    
    var sut: CorporateView!
    var didFireSearch: Bool!
    
    override func setUp() {
        super.setUp()
        
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        
        sut = CorporateView(traitCollection: iPadTraits)
        sut.delegate = self
        
        didFireSearch = false
    }
    
    override func tearDown() {
        sut = nil
        didFireSearch = nil
        super.tearDown()
    }
    
    func testSearchWasFired() {
        sut.searchButton.sendActions(for: .touchUpInside)
        XCTAssert(didFireSearch)
    }
    
    func didPressSearch() {
        didFireSearch = true
    }
    
    
}
