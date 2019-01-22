//
//  AuthErrorCode+Util.swift
//  SHMA
//
//  Created by Umar Yaqub on 22/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import FirebaseAuth

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .missingEmail:
            return "Please enter a valid email"
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userNotFound:
            return "Email provided isn't registered to any user"
        case .userDisabled:
            return "Your account is disabled, please contact SHMA support at enquiries@gmai.com."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "A network error occured, please try again."
        case .weakPassword:
            return "Please ensure your chosen password is atleast six characters long."
        case .wrongPassword:
            return "Password entered is incorrect, please try again or use 'Forgot password' to reset your password."
        default:
            return "An unknown error occured, please try again."
        }
    }
}
