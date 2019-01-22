//
//  FirebaseAuthManager.swift
//  SHMA
//
//  Created by Umar Yaqub on 11/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager {
    
    private let session: FirebaseAuthSession
    
    init(session: FirebaseAuthSession) {
        self.session = session
    }
    
    func signIn(with email: String, password: String, completion: @escaping AuthDataResultCallback) {
        session.signIn(with: email, password: password) { (result, error) in
            completion(result, error)
        }
    }
    
    func signOut(completion: @escaping (Bool, Error?) -> Void) {
        session.signOut { (success, error) in
            completion(success, error)
        }
    }
    
    func createUser(with email: String, password: String, completion: @escaping AuthDataResultCallback) {
        session.createUser(with: email, password: password) { (result, error) in
            completion(result, error)
        }
    }
    
    func sendPasswordReset(with email: String, completion: @escaping SendPasswordResetCallback) {
        session.sendPasswordReset(with: email) { (error) in
            completion(error)
        }
    }
}
