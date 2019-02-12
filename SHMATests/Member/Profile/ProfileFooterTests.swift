//
//  ProfileFooterTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 12/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class ProfileFooterTests: XCTestCase, ProfileFooterDelegate {
    
    var sut: ProfileFooter!
    var didFireDelegate: Bool!
    
    override func setUp() {
        super.setUp()
        
        sut = ProfileFooter(frame: .zero)
        sut.delegate = self
        didFireDelegate = false
    }
    
    override func tearDown() {
        sut = nil
        didFireDelegate = nil
        super.tearDown()
    }
    
    func didTapGetDirections() {
        didFireDelegate = true
    }
    
    func testDelegateIsFired() {
        sut.getDirectionsButton.sendActions(for: .touchUpInside)
        XCTAssert(didFireDelegate)
    }
}
