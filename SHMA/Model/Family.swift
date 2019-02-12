//
//  Family.swift
//  SHMA
//
//  Created by Umar Yaqub on 16/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

class Family: Codable {
    let fullName: String
    var email: String?
    let dob: String
    var relationship: Relationship?
    
    private enum CodingKeys: String, CodingKey {
        case fullName
        case email
        case dob = "DOB"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.dob = try container.decode(String.self, forKey: .dob)
    }
}


enum Relationship {
    case Spouse
    case Child
}
