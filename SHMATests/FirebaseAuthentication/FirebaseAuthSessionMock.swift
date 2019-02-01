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
    var didInitiateUserCreation = false
    var didInitiatePasswordReset = false
    var didInitiateEmailVerification = false
    var userEmail: String?
    var userPassword: String?
    var didInitiateSigningOut = false
    var member: User?
    
    func signIn(with email: String, password: String, completion: @escaping AuthDataResultCallback) {
        didInitiateAuth = true
        userEmail = email
        userPassword = password
    }
    
    func signOut(completion: @escaping (Bool, Error?) -> Void) {
        didInitiateSigningOut = true
    }
    
    func createUser(with email: String, password: String, completion: @escaping AuthDataResultCallback) {
        didInitiateUserCreation = true
        userEmail = email
        userPassword = password
    }
    
    func sendPasswordReset(with email: String, completion: @escaping SendPasswordResetCallback) {
        didInitiatePasswordReset = true
        userEmail = email
    }
    
    func sendEmailVerification(_ user: User, completion: @escaping SendEmailVerificationCallback) {
        didInitiateEmailVerification =  true
        member = user
    }
}

