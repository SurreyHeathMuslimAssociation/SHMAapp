//
//  Association.swift
//  SHMA
//
//  Created by Umar Yaqub on 26/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

struct Association: Decodable {

    let name: String
    let alias: String
    let generalEmail: String
    let committeeEmail: String
    let web: String
    let postalAddress: String
    
}
