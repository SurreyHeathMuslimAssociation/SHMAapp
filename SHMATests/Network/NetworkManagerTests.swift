//
//  NetworkManagerTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 12/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation
import XCTest
@testable import SHMA

class NetowrkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    var session: NetworkSessionMock!
    
    override func setUp() {
        super.setUp()
        
        session = NetworkSessionMock()
        sut = NetworkManager(session: session)
    }
    
    override func tearDown() {
        sut = nil
        session = nil
        super.tearDown()
    }
    
    func testGetsRequestUsingUrl() {
        guard let url = URL(string: "https://testurl.com") else { fatalError("invalid url") }
        session.loadData(from: url) { (data, response, error) in
        }
        XCTAssert(session.lastUrl == url)
    }
    
    func testResumeWasCalledOnLoadData() {
        guard let url = URL(string: "https://testurl.com") else { fatalError("invalid url") }
        session.loadData(from: url) { (data, response, error) in
        }
        XCTAssert(session.wasResumeCalled)
    }
    
    func testResumeWasCalledOnGooglePlacesAPI() {
        let placeId = "123"
        session.fetchGooglePlaceData(using: placeId) { (response) in
        }
        XCTAssert(session.wasResumeCalled)
    }
    
    func testGetsRequestUsingPlaceId() {
        let placeId = "123"
        session.fetchGooglePlaceData(using: placeId) { (response) in
        }
        XCTAssert(session.googlePlaceId == placeId)
    }
    
    func testResumeWasCalledOnPrayerTimesAPI() {
        let date = "12/12/2008"
        let lat = "51.1212331"
        let lon = "-0.1234444"
        session.fetchPrayerTimes(using: date, lat, lon) { (response) in
        }
        XCTAssert(session.wasResumeCalled)
    }
    
    func testGetsPrayerTimesUsingDateLatAndLon() {
        let date = "12/12/2008"
        let lat = "51.1212331"
        let lon = "-0.1234444"
        session.fetchPrayerTimes(using: date, lat, lon) { (response) in
        }
        XCTAssert(session.prayerDate == date)
        XCTAssert(session.userLat == lat)
        XCTAssert(session.userLon == lon)
    }
}

