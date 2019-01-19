//
//  FirebaseAuth+Util.swift
//  SHMA
//
//  Created by Umar Yaqub on 11/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation
import FirebaseAuth

extension Auth: FirebaseAuthSession {
    
    func signOut(completion: @escaping (Bool, Error?) -> Void) {
        do {
            try signOut()
            completion(true, nil)
        } catch {
            completion(false, error)
        }
    }
    
    func signIn(with email: String, password: String, completion: @escaping AuthDataResultCallback) {
        signIn(withEmail: email, password: password) { (result, error) in
            completion(result, error)
        }
    }
    
    func createUser(with email: String, password: String, completion: @escaping AuthDataResultCallback) {
        createUser(withEmail: email, password: password) { (result, error) in
            completion(result, error)
        }
    }
    
}
