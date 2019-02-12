//
//  NetworkSession.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

typealias GooglePlacesAPICallback = (GooglePlacesResponse) -> Void
typealias NetworkCallback = (Data?, URLResponse?, Error?) -> Void
protocol NetworkSession {
    func fetchGooglePlaceData(using placeId: String, completion: @escaping GooglePlacesAPICallback)
    func loadData(from url: URL, completionHandler: @escaping NetworkCallback)
}
