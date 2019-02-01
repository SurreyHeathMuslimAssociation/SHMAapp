//
//  LoginRegistrationView+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension LoginRegistrationView {
    
    func setupTextFieldLabelAndButtonTextAndFonts() {
        mainLabel.attributedText = loginRegistrationViewModel.getMainLabelAttributedTextForEachDevice()
        membershipLabel.attributedText = loginRegistrationViewModel.getMembershipLabelAttributedTextForEachDevice()
        loginRegisterButton.titleLabel?.font = loginRegistrationViewModel.getLoginRegisterButtonFontForEachDevice()
        passswordResetButton.titleLabel?.font = loginRegistrationViewModel.getLoginRegisterButtonFontForEachDevice()
        shmaIdTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        nameTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        emailTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        passwordTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        dobTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        addressLineOneTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        addressLineTwoTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        townTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        countyTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        postcodeTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        mobileNoTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
    }
    
    func setupKeyboardNotifications() {
        if didSelectNewMemberRegistration == true {
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
            notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        }
    }
    
    func setScrollViewContentSizeForNewMemberLogin() {
        scrollView.contentSize = loginRegistrationViewModel.getScrollViewContentSizeForNewMemberRegistration()
    }
    
    func determineIfSpouseChildTableViewIsVisible() {
        spouseChildTableView.isHidden = loginRegistrationViewModel.determineIfSpouseChildTableViewIsHidden()
        coverView.isHidden = loginRegistrationViewModel.determineIfCoverViewIsHidden()
    }
    
    func determineLoginRegisterButtonTitleAndWhichTextFieldsAreVisible() {
        loginRegisterButton.setTitle(loginRegistrationViewModel.getLoginRegisterButtonTitle(), for: .normal)
        loginRegistrationViewModel.determineVisibleItemsBasedOnLoginTypeSelected()
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardScreenEndFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = convert(keyboardScreenEndFrame, from: window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
            // animate table view back to starting position
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.superview?.frame.origin.y = 0
            })
        } else {
            if membershipSwitch.isOn {
                if didSelectSpouseChildTextField {
                    // animate table view above keyboard
                    // setting superview origin to 0 before adding keyboard height
                    // so it doesnt add previous value and double the y value
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                        self.superview?.frame.origin.y = 0
                        self.superview?.frame.origin.y -= keyboardViewEndFrame.height
                    })
                } else {
                    // animate table view back to starting position
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                        self.superview?.frame.origin.y = 0
                    })
                    scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
                }
            } else {
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 210, right: 0)
            }
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc func handleLoginRegister() {
        delegate?.didPressLoginRegister()
    }
    
    @objc func handlePasswordReset() {
        delegate?.didPressPasswordReset()
    }
    
    @objc func handleMembershipSwitch() {
        loginRegisterButton.setTitle(loginRegistrationViewModel.getLoginRegisterButtonTitle(), for: .normal)
        setScrollViewContentSizeForNewMemberLogin()
        determineIfSpouseChildTableViewIsVisible()
        delegate?.didSwitchToFamilyMembership()
    }
    
    @objc func handleKeyboard() {
        endEditing(true)
    }
}
