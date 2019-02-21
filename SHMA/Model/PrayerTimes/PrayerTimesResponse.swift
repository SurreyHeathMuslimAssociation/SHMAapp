//
//  PrayerTimesResponse.swift
//  SHMA
//
//  Created by Umar Yaqub on 18/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

struct PrayerTimesResponse: Decodable {
    
    let data: PrayerData
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}
