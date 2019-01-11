//
//  FirebaseDatabaseSession.swift
//  SHMA
//
//  Created by Umar Yaqub on 04/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation

protocol FirebaseDatabaseSession {
    func searchMemberUsing(_ dob: String,_ surname: String, completion: @escaping (String?, Bool) -> Void)
}
