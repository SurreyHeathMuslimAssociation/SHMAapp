//
//  LoginRegistrationController+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension LoginRegistrationController: LoginRegistrationViewDelegate {
    
    func didPressLoginRegister() {
        if didSelectLogin == true {
            
        } else if didSelectExistingMemberRegistration == true {
            
        } else {
            presentTermsAndConditions()
        }
    }
    
    private func presentTermsAndConditions() {
        let nav = UINavigationController(rootViewController: TermsAndConditionsController())
        present(nav, animated: true, completion: nil)
    }
    
}
