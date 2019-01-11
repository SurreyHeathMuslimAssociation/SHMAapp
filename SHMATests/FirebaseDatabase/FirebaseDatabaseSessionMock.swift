//
//  FirebaseDatabaseSessionMock.swift
//  SHMATests
//
//  Created by Umar Yaqub on 07/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseDatabase
@testable import SHMA

class FirebaseDatabaseSessionMock: FirebaseDatabaseSession {
    
    var didInitiateDatabaseCall = false
    var memberDob: String!
    var memberSurname: String!
    let shmaId = "100"
    let wasFound = true
    
    func searchMemberUsing(_ dob: String, _ surname: String, completion: @escaping (String?, Bool) -> Void) {
        didInitiateDatabaseCall = true
        memberDob = dob
        memberSurname = surname
        completion(shmaId, wasFound)
    }
    
}
