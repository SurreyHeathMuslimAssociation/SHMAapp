//
//  Location.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

struct Location: Decodable {
    
    let location: LatLong
}

struct LatLong: Decodable {
    
    let latitude: Double
    let longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}
