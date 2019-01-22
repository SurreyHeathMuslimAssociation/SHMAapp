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
    let mainLabel: UILabel
    let membershipLabel: UILabel
    let shmaIdTextField: UITextField
    let nameTextField: UITextField
    let emailTextField: UITextField
    let passwordTextField: UITextField
    let dobTextField: UITextField
    let addressLineOneTextField: UITextField
    let addressLineTwoTextField: UITextField
    let townTextField: UITextField
    let postcodeTextField: UITextField
    let mobileNoTextField: UITextField
    let loginRegisterButton: UIButton
    let passwordResetButton: UIButton
    let membershipSwitch: UISwitch
    let shmaIdSeperatorView: UIView
    let emailSeperatorView: UIView
    let nameSeperatorView: UIView
    let passwordSeperatorView: UIView
    let dobSeperatorView: UIView
    let addressLineOneSeperatorView: UIView
    let addressLineTwoSeperatorView: UIView
    let townSeperatorView: UIView
    let postcodeSeperatorView: UIView
    let coverView: UIView
    
    init(_ traitCollection: UITraitCollection, loginRegistrationView: UIView, _ didSelectLogin: Bool, _ didSelectExistingMemberRegistration: Bool, _ didSelectNewMemberRegistration: Bool,_ mainLabel: UILabel, _ membershipLabel: UILabel, _ shmaIdTextField: UITextField, _ nameTextField: UITextField, _ emailTextField: UITextField, _ passwordTextField: UITextField, _ dobTextField: UITextField, _ addressLineOneTextField: UITextField, _ addressLineTwoTextField: UITextField, _ townTextField: UITextField, _ postcodeTextField: UITextField, _ mobileNoTextField: UITextField, _ loginRegisterButton: UIButton, _ passwordResetButton: UIButton, _ membershipSwitch: UISwitch, _ shmaIdSeperatorView: UIView, _ emailSeperatorView: UIView, _ nameSeperatorView: UIView, _ passwordSeperatorView: UIView, _ dobSeperatorView: UIView, _ addressLineOneSeperatorView: UIView, _ addressLineTwoSeperatorView: UIView, _ townSeperatorView: UIView, _ postcodeSeperatorView: UIView, _ coverView: UIView) {
        self.traitCollection = traitCollection
        self.loginRegistrationView = loginRegistrationView
        self.didSelectLogin = didSelectLogin
        self.didSelectExistingMemberRegistration = didSelectExistingMemberRegistration
        self.didSelectNewMemberRegistration = didSelectNewMemberRegistration
        self.mainLabel = mainLabel
        self.membershipLabel = membershipLabel
        self.shmaIdTextField = shmaIdTextField
        self.nameTextField = nameTextField
        self.emailTextField = emailTextField
        self.passwordTextField = passwordTextField
        self.dobTextField = dobTextField
        self.addressLineOneTextField = addressLineOneTextField
        self.addressLineTwoTextField = addressLineTwoTextField
        self.townTextField = townTextField
        self.postcodeTextField = postcodeTextField
        self.mobileNoTextField = mobileNoTextField
        self.loginRegisterButton = loginRegisterButton
        self.passwordResetButton = passwordResetButton
        self.membershipSwitch = membershipSwitch
        self.shmaIdSeperatorView = shmaIdSeperatorView
        self.emailSeperatorView = emailSeperatorView
        self.nameSeperatorView = nameSeperatorView
        self.passwordSeperatorView = passwordSeperatorView
        self.dobSeperatorView = dobSeperatorView
        self.addressLineOneSeperatorView = addressLineOneSeperatorView
        self.addressLineTwoSeperatorView = addressLineTwoSeperatorView
        self.townSeperatorView = townSeperatorView
        self.postcodeSeperatorView = postcodeSeperatorView
        self.coverView = coverView
    }

    // buttons
    func getLoginRegisterButtonFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    func getLoginRegisterButtonHeightConstraint() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return loginRegisterButton.heightAnchor.constraint(equalToConstant: 60)
        } else {
            return loginRegisterButton.heightAnchor.constraint(equalToConstant: 45)
        }
    }
    
    func getLoginRegisterButtonTopAnchor() -> NSLayoutConstraint {
        if didSelectNewMemberRegistration {
            return loginRegisterButton.topAnchor.constraint(equalTo: mobileNoTextField.bottomAnchor)
        } else {
            return loginRegisterButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor)
        }
    }
    
    func getPasswordResetButtonHeightConstraint() -> NSLayoutConstraint {
        if didSelectLogin {
            if traitCollection.isIpad {
                return passwordResetButton.heightAnchor.constraint(equalToConstant: 60)
            } else {
                return passwordResetButton.heightAnchor.constraint(equalToConstant: 45)
            }
        } else {
            return passwordResetButton.heightAnchor.constraint(equalToConstant: 0)
        }
    }
    
    func getLoginRegisterButtonTitle() -> String {
        if didSelectLogin {
            return "Login"
        } else if didSelectExistingMemberRegistration {
            return "Register"
        } else {
            if membershipSwitch.isOn {
                return "Register (£7 per month)"
            } else {
                return "Register (£4 per month)"
            }
        }
    }
    
    func determineVisibleItemsBasedOnLoginTypeSelected() {
        if didSelectLogin == true {
            membershipLabel.isHidden = true
            shmaIdTextField.isHidden = true
            membershipSwitch.isHidden = true
            passwordSeperatorView.isHidden = true
            shmaIdSeperatorView.isHidden = true
            nameTextField.isHidden = true
            nameSeperatorView.isHidden = true
            dobTextField.isHidden = true
            dobSeperatorView.isHidden = true
            addressLineOneTextField.isHidden = true
            addressLineOneSeperatorView.isHidden = true
            addressLineTwoTextField.isHidden = true
            addressLineTwoSeperatorView.isHidden = true
            townTextField.isHidden = true
            townSeperatorView.isHidden = true
            postcodeTextField.isHidden = true
            postcodeSeperatorView.isHidden = true
            mobileNoTextField.isHidden = true
        } else if didSelectExistingMemberRegistration == true {
            passwordResetButton.isHidden = true
            membershipLabel.isHidden = true
            membershipSwitch.isHidden = true
            nameTextField.isHidden = true
            passwordSeperatorView.isHidden = true
            nameSeperatorView.isHidden = true
            dobTextField.isHidden = true
            dobSeperatorView.isHidden = true
            addressLineOneTextField.isHidden = true
            addressLineOneSeperatorView.isHidden = true
            addressLineTwoTextField.isHidden = true
            addressLineTwoSeperatorView.isHidden = true
            townTextField.isHidden = true
            townSeperatorView.isHidden = true
            postcodeTextField.isHidden = true
            postcodeSeperatorView.isHidden = true
            mobileNoTextField.isHidden = true
            coverView.isHidden = true
        } else if didSelectNewMemberRegistration == true {
            passwordResetButton.isHidden = true
            shmaIdTextField.isHidden = true
            shmaIdSeperatorView.isHidden = true
        }
    }
    
    // label
    func getLabelHeightAnchor() -> NSLayoutConstraint {
        return mainLabel.heightAnchor.constraint(equalToConstant: 80)
    }
    
    func getLabelFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 26)
        } else {
            return UIFont.systemFont(ofSize: 16)
        }
    }
    
    func getMainLabelAttributedTextForEachDevice() -> NSAttributedString {
        if didSelectLogin {
            let title = "Log In?"
            let text = "Please use your credentials to log in."
            return getLabelAttributedString(title, text)
        } else if didSelectExistingMemberRegistration {
            let title = "Already a Member?"
            let text = "Register onto out online service using your SHMA ID."
             return getLabelAttributedString(title, text)
        } else {
            let title = "Thinking of Joining Us?"
            let text = "Please provide the following details to be part of SHMA."
            return getLabelAttributedString(title, text)
        }
    }
    
    private func getLabelAttributedString(_ title: String, _ text: String) -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString.getAttributedString(title: title, titleFont: UIFont.boldSystemFont(ofSize: 26), linesOfSpace: "\n\n", spaceFont: 4, message: text, messageFont: UIFont.systemFont(ofSize: 20))
        } else {
            return NSAttributedString.getAttributedString(title: title, titleFont: UIFont.boldSystemFont(ofSize: 20), linesOfSpace: "\n\n", spaceFont: 4, message: text, messageFont: UIFont.systemFont(ofSize: 14))
        }
    }
    
    func getMembershipLabelAttributedTextForEachDevice() -> NSAttributedString? {
        if didSelectNewMemberRegistration {
            return getMembershipLabelAttributedString("Family Membership?")
        } else {
            return nil
        }
    }
    
    private func getMembershipLabelAttributedString(_ text: String) -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString.getAttributedStringUsing(text: text, font: 22, spaceFont: nil, isBold: true)
        } else {
            return NSAttributedString.getAttributedStringUsing(text: text, font: 14, spaceFont: nil, isBold: true)
        }
    }
    
    // scrollview
    func getScrollViewContentSizeForNewMemberRegistration() -> CGSize {
        if didSelectNewMemberRegistration {
            if traitCollection.isIphone {
                if membershipSwitch.isOn {
                    return CGSize(width: loginRegistrationView.frame.width, height: 890)
                } else {
                    return CGSize(width: loginRegistrationView.frame.width, height: 590)
                }
            } else {
                // ipad portrait
                if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                    if membershipSwitch.isOn {
                        return CGSize(width: loginRegistrationView.frame.width, height: 1040)
                    } else {
                        return CGSize(width: loginRegistrationView.frame.width, height: 740)
                    }
                } else {
                    // ipad landscape
                    if membershipSwitch.isOn {
                        return CGSize(width: loginRegistrationView.frame.width, height: 1040)
                    } else {
                        return CGSize(width: loginRegistrationView.frame.width, height: 740)
                    }
                }
            }
        } else {
            return CGSize(width: loginRegistrationView.frame.width, height: 0)
        }
    }
    
    func determineIfSpouseChildTableViewIsHidden() -> Bool {
            if membershipSwitch.isOn {
                return false
            } else {
                return true
            }
    }
    
    func determineIfCoverViewIsHidden() -> Bool {
        if membershipSwitch.isOn {
            return true
        } else {
            return false
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
    
    func getShmaIdTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return shmaIdTextField.heightAnchor.constraint(equalToConstant: didSelectExistingMemberRegistration ? 60 : 0)
        } else {
            return shmaIdTextField.heightAnchor.constraint(equalToConstant: didSelectExistingMemberRegistration ? 45 : 0)
        }
    }
    
    func getEmailTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return emailTextField.heightAnchor.constraint(equalToConstant: 60)
        } else {
            return emailTextField.heightAnchor.constraint(equalToConstant: 45)
        }
    }
    
    func getPasswordTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return passwordTextField.heightAnchor.constraint(equalToConstant: 60)
        } else {
            return passwordTextField.heightAnchor.constraint(equalToConstant: 45)
        }
    }
    
    func getShmaIdTextFieldTopConstraintForEachDeviceBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if didSelectNewMemberRegistration {
            return shmaIdTextField.topAnchor.constraint(equalTo: membershipLabel.bottomAnchor)
        } else {
            return shmaIdTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor)
        }
    }
    
    func getNameTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return nameTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 60 : 0)
        } else {
            return nameTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 45 : 0)
        }
    }
    
    func getDobTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return dobTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 60 : 0)
        } else {
            return dobTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 45 : 0)
        }
    }
    
    func getAddressLineOneTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return addressLineOneTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 60 : 0)
        } else {
            return addressLineOneTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 45 : 0)
        }
    }
    
    func getAddressLineTwoTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return addressLineTwoTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 60 : 0)
        } else {
            return addressLineTwoTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 45 : 0)
        }
    }
    
    func getTownTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return townTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 60 : 0)
        } else {
            return townTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 45 : 0)
        }
    }
    
    func getPostcodeTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return postcodeTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 60 : 0)
        } else {
            return postcodeTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 45 : 0)
        }
    }
    
    func getMobileNoTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return mobileNoTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 60 : 0)
        } else {
            return mobileNoTextField.heightAnchor.constraint(equalToConstant: didSelectNewMemberRegistration ? 45 : 0)
        }
    }
    
    // login registration view
    func getLoginRegistrationViewHeightOrBottomConstraitForEachTypeAndDevice() -> NSLayoutConstraint? {
        if didSelectLogin {
            return getLoginViewHeightConstraitForDifferentOrientations()
        } else if didSelectExistingMemberRegistration {
            return getExistingMemberRegistrationViewHeightConstraitForDifferentOrientations()
        } else {
            return getNewMemberRegistrationViewBottomAnchor()
        }
    }
    
    private func getLoginViewHeightConstraitForDifferentOrientations() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return loginRegistrationView.heightAnchor.constraint(equalToConstant: 320)
        } else {
            return loginRegistrationView.heightAnchor.constraint(equalToConstant: 260)
        }
    }
    
    private func getExistingMemberRegistrationViewHeightConstraitForDifferentOrientations() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return loginRegistrationView.heightAnchor.constraint(equalToConstant: 320)
        } else {
            return loginRegistrationView.heightAnchor.constraint(equalToConstant: 261)
        }
    }
    
//    private func getNewMemberRegistrationViewHeightConstraitForSingleMembership() -> NSLayoutConstraint? {
//        if traitCollection.isIpad {
//            if membershipSwitch.isOn {
//                return getNewMemberRegistrationViewBottomAnchor()
//            } else {
//                return loginRegistrationView.heightAnchor.constraint(equalToConstant: 740)
//            }
//        } else if traitCollection.isIphonePortrait {
//            if membershipSwitch.isOn {
//                return getNewMemberRegistrationViewBottomAnchor()
//            } else {
//                return loginRegistrationView.heightAnchor.constraint(equalToConstant: 590)
//            }
//        } else {
//            return getNewMemberRegistrationViewBottomAnchor()
//        }
//    }
    
    private func getNewMemberRegistrationViewBottomAnchor() -> NSLayoutConstraint? {
        guard let superview = loginRegistrationView.superview else {
            return NSLayoutConstraint()
        }
        if didSelectNewMemberRegistration {
            return loginRegistrationView.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        } else {
            return nil
        }
    }
    
    func getNewMemberRegistrationViewCenterYAnchor() -> NSLayoutConstraint? {
        guard let superview = loginRegistrationView.superview else {
            return NSLayoutConstraint()
        }
        if !didSelectNewMemberRegistration {
            return loginRegistrationView.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        } else {
            return nil
        }
    }
    
    func getNewMemberRegistrationViewWidthAnchor() -> NSLayoutConstraint {
        guard let superview = loginRegistrationView.superview else {
            return NSLayoutConstraint()
        }
        if traitCollection.isIphonePortrait {
            return loginRegistrationView.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.95)
        } else {
            return loginRegistrationView.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.7)
        }
       
    }
    
    func getNewMemberRegistrationViewTopAnchor() -> NSLayoutConstraint? {
        guard let superview = loginRegistrationView.superview else {
            return NSLayoutConstraint()
        }
        if didSelectNewMemberRegistration {
            return loginRegistrationView.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 10)
        } else {
            return nil
        }
    }
    
    // alert
    func getAlertViewTitleForEachDevice(_ title: String) -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString.getAttributedStringUsing(text: title, font: 20, spaceFont: 4, isBold: true)
        } else {
            return NSAttributedString.getAttributedStringUsing(text: title, font: 16, spaceFont: nil, isBold: true)
        }
    }
    
    func getAlertViewTextForEachDevice(_ error: String) -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString.getAttributedStringUsing(text: error, font: 16, spaceFont: nil, isBold: false)
        } else {
            return NSAttributedString.getAttributedStringUsing(text: error, font: 13, spaceFont: nil, isBold: false)
        }
    }
}
