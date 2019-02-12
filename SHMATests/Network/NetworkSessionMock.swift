//
//  NetworkSessionMock.swift
//  SHMATests
//
//  Created by Umar Yaqub on 12/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation
@testable import SHMA

class NetworkSessionMock: NetworkSession {
    
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    var lastUrl: URL?
    var googlePlaceId: String?
    var wasResumeCalled = false
    
    func loadData(from url: URL, completionHandler: @escaping NetworkCallback) {
        completionHandler(data, urlResponse, error)
        lastUrl = url
        wasResumeCalled = true
    }
    
    func fetchGooglePlaceData(using placeId: String, completion: @escaping GooglePlacesAPICallback) {
        wasResumeCalled = true
        googlePlaceId = placeId
    }
    
}
