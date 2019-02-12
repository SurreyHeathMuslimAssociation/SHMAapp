//
//  OpeningHours.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

struct OpeningHours: Decodable {
    
    let isOpen: Bool
    let timings: [String]
    
    private enum CodingKeys: String, CodingKey {
        case isOpen = "open_now"
        case timings = "weekday_text"
    }
}
