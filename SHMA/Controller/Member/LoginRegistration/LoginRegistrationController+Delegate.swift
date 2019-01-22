//
//  LoginRegistrationController+Delegate.swift
//  SHMA
//
//  Created by Umar Yaqub on 18/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension LoginRegistrationController: LoginRegistrationViewDelegate {
    
    func didPressLoginRegister() {
        if didSelectLogin == true {
            handleLogIn()
        } else if didSelectExistingMemberRegistration == true {
            handleExistingMemberSignUp()
        } else {
            determineIfMemberDetailRequirementsAreMet()
        }
    }
    
    func didSwitchToFamilyMembership() {
        setupLoginRegistrationViewHeightOrBottomAnchor()
    }
    
    func didPressPasswordReset() {
        navigationController?.pushViewController(PasswordResetController(), animated: true)
    }
}
