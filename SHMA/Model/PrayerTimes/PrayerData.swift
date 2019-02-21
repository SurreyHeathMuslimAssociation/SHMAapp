//
//  PrayerData.swift
//  SHMA
//
//  Created by Umar Yaqub on 18/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

struct PrayerData: Decodable {
    
    let timings: Timings
    let date: PrayerDate
    
    private enum CodingKeys: String, CodingKey {
        case timings
        case date
    }
}
