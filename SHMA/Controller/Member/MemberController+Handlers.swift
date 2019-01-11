//
//  MemberController+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 09/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension MemberController: MemberViewDelegate {
    func didPressLogin() {
        let loginRegistrationController = LoginRegistrationController()
        loginRegistrationController.didSelectLogin = true
        navigationController?.pushViewController(loginRegistrationController, animated: true)
    }
    
    func didPressExistingRegistration() {
        let loginRegistrationController = LoginRegistrationController()
        loginRegistrationController.didSelectExistingMemberRegistration = true
        navigationController?.pushViewController(loginRegistrationController, animated: true)
    }
    
    func didPressNewRegistration() {
        let loginRegistrationController = LoginRegistrationController()
        loginRegistrationController.didSelectNewMemberRegistration = true
        navigationController?.pushViewController(loginRegistrationController, animated: true)
    }
    
    
}
