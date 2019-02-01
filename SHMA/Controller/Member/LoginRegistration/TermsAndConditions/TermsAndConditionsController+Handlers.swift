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
            let name = Notification.Name(rawValue: "register")
            NotificationCenter.default.post(name: name, object: nil)
        }
    }
    
    func didPressDisagree() {
        dismiss(animated: true) {
            let name = Notification.Name(rawValue: "registerationCancelled")
            NotificationCenter.default.post(name: name, object: nil)
        }
    }
    
}
