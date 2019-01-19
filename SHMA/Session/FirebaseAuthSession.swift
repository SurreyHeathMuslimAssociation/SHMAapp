//
//  FirebaseAuthSession.swift
//  SHMA
//
//  Created by Umar Yaqub on 11/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthSession {
    func signIn(with email: String, password: String, completion: @escaping AuthDataResultCallback)
    func signOut(completion: @escaping (Bool, Error?) -> Void)
    func createUser(with email: String, password: String, completion: @escaping AuthDataResultCallback)
}
