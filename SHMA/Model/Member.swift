//
//  Member.swift
//  SHMA
//
//  Created by Umar Yaqub on 26/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

class Member: Codable {
    
    let firstName: String
    let middleName: String?
    let lastName: String
    let fullName: String
    let dob: String?
    var email: String?
    let membershipType: String
    var status: String?
    var shmaId: Int?
    let addressLineOne: String?
    let addressLineTwo: String?
    let town: String?
    let county: String?
    let postcode: String?
    let mobileNumber: String?
    let alternatePhoneNo: String?
    
    private enum CodingKeys: String, CodingKey {
        case firstName
        case middleName
        case lastName
        case dob = "DOB"
        case email
        case membershipType
        case status
        case shmaId
        case addressLineOne
        case addressLineTwo
        case town
        case county
        case postcode
        case mobileNumber = "mobileNo"
        case alternatePhoneNo
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.middleName = try container.decodeIfPresent(String.self, forKey: .middleName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        if self.middleName != "" {
            self.fullName = "\(self.firstName) \(self.middleName ?? "") \(self.lastName)"
        } else {
            self.fullName = "\(self.firstName) \(self.lastName)"
        }
        self.dob = try container.decodeIfPresent(String.self, forKey: .dob)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.membershipType = try container.decode(String.self, forKey: .membershipType)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.shmaId = try container.decodeIfPresent(Int.self, forKey: .shmaId)
        self.addressLineOne = try container.decodeIfPresent(String.self, forKey: .addressLineOne)
        self.addressLineTwo = try container.decodeIfPresent(String.self, forKey: .addressLineTwo)
        self.town = try container.decodeIfPresent(String.self, forKey: .town)
        self.county = try container.decodeIfPresent(String.self, forKey: .county)
        self.postcode = try container.decodeIfPresent(String.self, forKey: .postcode)
        self.mobileNumber = try container.decodeIfPresent(String.self, forKey: .mobileNumber)
        self.alternatePhoneNo = try container.decodeIfPresent(String.self, forKey: .alternatePhoneNo)
    }
}
