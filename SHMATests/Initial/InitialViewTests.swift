//
//  InitialViewTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 25/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class InitialViewTests: XCTestCase, InitialViewDelegate {
    
    var sut: InitialView!
    var didFireCorporate: Bool!
    var didFireMember: Bool!
    
    override func setUp() {
        super.setUp()
        
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        
        sut = InitialView(traitCollection: iPadTraits)
        sut.delegate = self
        
        didFireCorporate = false
        didFireMember = false
    }
    
    override func tearDown() {
        sut = nil
        didFireMember = nil
        didFireCorporate = nil
        super.tearDown()
    }
    
    func testCorporateWasFired() {
        sut.corporateButton.sendActions(for: .touchUpInside)
        XCTAssert(didFireCorporate)
    }
    
    func testMemberWasFired() {
        sut.memberButton.sendActions(for: .touchUpInside)
        XCTAssert(didFireMember)
    }
    
    func didPressCorporate() {
        didFireCorporate = true
    }
    
    func didPressMember() {
        didFireMember = true
    }
    
}
