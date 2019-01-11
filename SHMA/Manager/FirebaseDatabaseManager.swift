//
//  FirebaseDatabaseManager.swift
//  SHMA
//
//  Created by Umar Yaqub on 04/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirebaseDatabaseManager {
    
    private let session: FirebaseDatabaseSession
    
    init(session: FirebaseDatabaseSession) {
        self.session = session
    }
    
    func searchMemberUsing(_ dob: String, _ surname: String, completion: @escaping (String?, Bool) -> Void) {
        session.searchMemberUsing(dob, surname) { (shmaId, memberFound) in
            completion(shmaId, memberFound)
        }
    }
    
}
