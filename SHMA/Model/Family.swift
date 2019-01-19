//
//  Family.swift
//  SHMA
//
//  Created by Umar Yaqub on 16/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

struct Family {
    let fullName: String
    var email: String?
    let dob: String
    let relationship: Relationship
    
    init(fullName: String, dob: String, relationship: Relationship) {
        self.fullName = fullName
        self.dob = dob
        self.relationship = relationship
    }
}

enum Relationship {
    case Spouse
    case Child
}
