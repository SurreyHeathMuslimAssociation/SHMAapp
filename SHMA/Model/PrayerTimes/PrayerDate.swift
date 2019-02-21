//
//  PrayerDate.swift
//  SHMA
//
//  Created by Umar Yaqub on 18/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

struct PrayerDate: Decodable {
    
    let hijri: Hijri
    
    private enum CodingKeys: String, CodingKey {
        case hijri
    }
}
