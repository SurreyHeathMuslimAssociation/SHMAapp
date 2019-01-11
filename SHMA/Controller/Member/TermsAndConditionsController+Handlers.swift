//
//  TermsAndConditionsController+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension TermsAndConditionsController: TermsAndConditionsViewDelegate {
    
    func didPressAgree() {
        dismiss(animated: true) {
            print("agreed, go to home")
        }
    }
    
    func didPressDisagree() {
        dismiss(animated: true, completion: nil)
    }
    
}
