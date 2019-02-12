//
//  GooglePlacesResponse.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

struct GooglePlacesResponse: Decodable {
    
    let result: Place
    
    private enum CodingKeys: String, CodingKey {
        case result
    }
}
