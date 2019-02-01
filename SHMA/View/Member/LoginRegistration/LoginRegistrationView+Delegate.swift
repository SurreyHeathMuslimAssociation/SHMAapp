//
//  LoginRegistrationView+Delegate.swift
//  SHMA
//
//  Created by Umar Yaqub on 16/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension LoginRegistrationView: UITableViewDelegate, UITextFieldDelegate, SpouseChildCellDelegate, AddSpouseChildCellDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 90
        } else {
            return 50
        }
    }
    
    func setTextFieldDelegates() {
        shmaIdTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        dobTextField.delegate = self
        addressLineOneTextField.delegate = self
        addressLineTwoTextField.delegate = self
        townTextField.delegate = self
        postcodeTextField.delegate = self
        mobileNoTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Format Date of Birth dd-MM-yyyy
        if textField == dobTextField {
            if let text = dobTextField.text {
                // check the chars length dd --> 2 at the same time calculate the dd-MM --> 5
                if (text.count == 2) || (text.count == 5) {
                    //Handle backspace being pressed
                    if !(string == "") {
                        // append
                        dobTextField.text = text + "/"
                    }
                }
                // check the condition not exceed 9 chars
                return !(text.count > 9 && (string.count) > range.length)
            } else {
                return true
            }
        } else {
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
    
    func didSelectTextField() {
        didSelectSpouseChildTextField = true
    }
    
    func didUnselectTextField() {
        didSelectSpouseChildTextField = false
    }
    
    func didTapAddChild() {
        childRows.append(1)
        spouseChildTableView?.beginUpdates()
        spouseChildTableView?.insertRows(at: [IndexPath(row: childRows.count-1, section: 1)], with: .automatic)
        spouseChildTableView?.endUpdates()
    }
 
}
