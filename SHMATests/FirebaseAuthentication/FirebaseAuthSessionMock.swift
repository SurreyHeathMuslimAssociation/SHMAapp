//
//  FirebaseAuthSessionMock.swift
//  SHMATests
//
//  Created by Umar Yaqub on 11/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation
import FirebaseAuth
@testable import SHMA

class FirebaseAuthSessionMock: FirebaseAuthSession {
    
    var didInitiateAuth = false
    var userEmail: String?
    var userPassword: String?
    
    func signIn(with email: String, password: String, completion: @escaping AuthDataResultCallback) {
        didInitiateAuth = true
        userEmail = email
        userPassword = password
    }
    
    func signOut(completion: @escaping (Bool, Error?) -> Void) {
        didInitiateAuth = true
    }
    
    func createUser(with email: String, password: String, completion: @escaping AuthDataResultCallback) {
        
    }
    
}

