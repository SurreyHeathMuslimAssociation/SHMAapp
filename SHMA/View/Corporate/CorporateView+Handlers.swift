//
//  CorporateView+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 13/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension CorporateView: UITextFieldDelegate {
    
    @objc func handleSearchAction() {
        delegate?.didPressSearch()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}
