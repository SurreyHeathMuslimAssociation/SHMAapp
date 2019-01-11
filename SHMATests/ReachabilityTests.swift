//
//  ReachabilityTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 08/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class ReachabilityTests: XCTestCase {
    
    var sut: Reachability!
    
    override func setUp() {
        super.setUp()
        sut = Reachability()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testIsConnectedToNetwork() {
        XCTAssert(Reachability.isConnectedToNetwork())
    }
}
