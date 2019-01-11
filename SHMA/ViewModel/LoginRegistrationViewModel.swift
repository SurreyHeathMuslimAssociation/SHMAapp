//
//  LoginRegistrationViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 09/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class LoginRegistrationViewModel {

    var traitCollection: UITraitCollection
    let loginRegistrationView: UIView
    let didSelectLogin: Bool
    let didSelectExistingMemberRegistration: Bool
    let didSelectNewMemberRegistration: Bool
    let shmaIdTextField: UITextField
    let nameTextField: UITextField
    let emailTextField: UITextField
    let passwordTextField: UITextField
    let dobTextField: UITextField
    let addressTextField: UITextField
    let townTextField: UITextField
    let postcodeTextField: UITextField
    let mobileNoTextField: UITextField
    let loginRegisterButton: UIButton
    
    init(_ traitCollection: UITraitCollection, loginRegistrationView: UIView, _ didSelectLogin: Bool, _ didSelectExistingMemberRegistration: Bool, _ didSelectNewMemberRegistration: Bool, _ shmaIdTextField: UITextField, _ nameTextField: UITextField, _ emailTextField: UITextField, _ passwordTextField: UITextField, _ dobTextField: UITextField, _ addressTextField: UITextField, _ townTextField: UITextField, _ postcodeTextField: UITextField, _ mobileNoTextField: UITextField, _ loginRegisterButton: UIButton) {
        self.traitCollection = traitCollection
        self.loginRegistrationView = loginRegistrationView
        self.didSelectLogin = didSelectLogin
        self.didSelectExistingMemberRegistration = didSelectExistingMemberRegistration
        self.didSelectNewMemberRegistration = didSelectNewMemberRegistration
        self.shmaIdTextField = shmaIdTextField
        self.nameTextField = nameTextField
        self.emailTextField = emailTextField
        self.passwordTextField = passwordTextField
        self.dobTextField = dobTextField
        self.addressTextField = addressTextField
        self.townTextField = townTextField
        self.postcodeTextField = postcodeTextField
        self.mobileNoTextField = mobileNoTextField
        self.loginRegisterButton = loginRegisterButton
    }
    
    // buttons
    func getLoginRegisterButtonFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    func getLoginRegisterButtonHeightConstraintBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if didSelectLogin {
            return loginRegisterButton.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/3)
        } else if didSelectExistingMemberRegistration {
            return loginRegisterButton.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/4)
        } else {
            return loginRegisterButton.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/9)
        }
    }
    
    // textfields
    func getTextFieldFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    func getShmaIdTextFieldHeightConstraintBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        return shmaIdTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: didSelectExistingMemberRegistration ? 1/4 : 0)
    }
    
    func getNameTextFieldHeightConstraintBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        return nameTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: didSelectNewMemberRegistration ? 1/9 : 0)
    }
    
    func getEmailTextFieldHeightConstraintBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if didSelectLogin {
            return emailTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/3)
        } else if didSelectExistingMemberRegistration {
            return emailTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/4)
        } else {
            return emailTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/9)
        }
    }
    
    func getPasswordTextFieldHeightConstraintBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if didSelectLogin {
            return passwordTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/3)
        } else if didSelectExistingMemberRegistration {
            return passwordTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/4)
        } else {
            return passwordTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/9)
        }
    }
    
    func getDobTextFieldHeightConstraintBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        return dobTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: didSelectNewMemberRegistration ? 1/9 : 0)
    }
    
    func getAddressTextFieldHeightConstraintBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        return addressTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: didSelectNewMemberRegistration ? 1/9 : 0)
    }
    
    func getTownTextFieldHeightConstraintBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        return townTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: didSelectNewMemberRegistration ? 1/9 : 0)
    }
    
    func getPostcodeTextFieldHeightConstraintBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        return postcodeTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: didSelectNewMemberRegistration ? 1/9 : 0)
    }
    
    func getMobileNoTextFieldHeightConstraintBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        return mobileNoTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: didSelectNewMemberRegistration ? 1/9 : 0)
    }
    
    func getLoginRegistrationViewHeightConstraitForEachTypeAndDevice() -> NSLayoutConstraint {
        guard let superviewHeight = loginRegistrationView.superview?.heightAnchor else {
            return NSLayoutConstraint()
        }
        if didSelectLogin {
            return getLoginViewHeightConstraitForDifferentOrientations(superviewHeight)
        } else if didSelectExistingMemberRegistration {
            return getExistingMemberRegistrationViewHeightConstraitForDifferentOrientations(superviewHeight)
        } else {
            return getNewMemberRegistrationViewHeightConstraitForDifferentOrientations(superviewHeight)
        }
    }
    
    private func getLoginViewHeightConstraitForDifferentOrientations(_ superviewHeight: NSLayoutDimension) -> NSLayoutConstraint {
        if traitCollection.isIphoneLandscape {
            return loginRegistrationView.heightAnchor.constraint(equalTo: superviewHeight, multiplier: 0.35)
        } else {
            return loginRegistrationView.heightAnchor.constraint(equalTo: superviewHeight, multiplier: 0.25)
        }
    }
    
    private func getExistingMemberRegistrationViewHeightConstraitForDifferentOrientations(_ superviewHeight: NSLayoutDimension) -> NSLayoutConstraint {
        if traitCollection.isIphoneLandscape {
            return loginRegistrationView.heightAnchor.constraint(equalTo: superviewHeight, multiplier: 0.4)
        } else {
            return loginRegistrationView.heightAnchor.constraint(equalTo: superviewHeight, multiplier: 0.3)
        }
    }
    
    private func getNewMemberRegistrationViewHeightConstraitForDifferentOrientations(_ superviewHeight: NSLayoutDimension) -> NSLayoutConstraint {
        if traitCollection.isIphoneLandscape {
            return loginRegistrationView.heightAnchor.constraint(equalTo: superviewHeight, multiplier: 0.8)
        } else {
            return loginRegistrationView.heightAnchor.constraint(equalTo: superviewHeight, multiplier: 0.65)
        }
    }
}
