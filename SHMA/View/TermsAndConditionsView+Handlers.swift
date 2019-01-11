//
//  TermsAndConditionsView+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension TermsAndConditionsView {
    
    @objc func handleAgree() {
        delegate?.didPressAgree()
    }
    
    @objc func handleDisagree() {
        delegate?.didPressDisagree()
    }
}
