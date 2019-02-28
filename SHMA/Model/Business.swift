//
//  Business.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

struct Business {
    var placeId: String?
    let iconUrl: String
    let discount: String
    let information: GooglePlacesResponse

    init(iconUrl: String, discount: String, information: GooglePlacesResponse) {
        self.iconUrl = iconUrl
        self.discount = discount
        self.information = information
    }
}
