//
//  Place.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

struct Place: Decodable {
    
    let geometry: Location
    let name: String
    let openingHours: OpeningHours?
    let types: [String]
    let address: String
    let rating: Double
    
    private enum CodingKeys: String, CodingKey {
        case geometry
        case name
        case openingHours = "opening_hours"
        case types
        case address = "formatted_address"
        case rating
    }
}
