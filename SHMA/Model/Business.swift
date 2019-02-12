//
//  Business.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

struct Business {
    
    let iconUrl: String
    let information: GooglePlacesResponse

    init(iconUrl: String, information: GooglePlacesResponse) {
        self.iconUrl = iconUrl
        self.information = information
    }
}
