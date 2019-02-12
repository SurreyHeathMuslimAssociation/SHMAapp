//
//  NetworkManager.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private let session: NetworkSession
    
    init(session: NetworkSession) {
        self.session = session
    }
    
    func fetchGooglePlaceData(using placeId: String, completion: @escaping GooglePlacesAPICallback) {
        session.fetchGooglePlaceData(using: placeId) { (response) in
            completion(response)
        }
    }
    
    func loadData(from url: URL, completionHandler: @escaping NetworkCallback) {
        session.loadData(from: url) { (data, response, error) in
            completionHandler(data, response, error)
        }
    }
}
