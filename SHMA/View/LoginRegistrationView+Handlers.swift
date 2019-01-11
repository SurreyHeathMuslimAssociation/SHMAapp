//
//  LoginRegistrationView+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension LoginRegistrationView: UITextFieldDelegate {

    func setupView() {
        addSubview(scrollView)
        scrollView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        scrollView.addSubview(shmaIdSeperatorView)
        scrollView.addSubview(shmaIdTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(emailSeperatorView)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(passwordSeperatorView)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(nameSeperatorView)
        scrollView.addSubview(dobTextField)
        scrollView.addSubview(dobSeperatorView)
        scrollView.addSubview(addressTextField)
        scrollView.addSubview(addressSeperatorView)
        scrollView.addSubview(townTextField)
        scrollView.addSubview(townSeperatorView)
        scrollView.addSubview(postcodeTextField)
        scrollView.addSubview(postcodeSeperatorView)
        scrollView.addSubview(mobileNoTextField)
        scrollView.addSubview(activityIndicatorView)
        scrollView.addSubview(loginRegisterButton)
        
        shmaIdTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        dobTextField.delegate = self
        addressTextField.delegate = self
        townTextField.delegate = self
        postcodeTextField.delegate = self
        mobileNoTextField.delegate = self
        
        determineLoginRegisterButtonTitle()
        setupTextFields()
        setupTextFieldHeightAnchors()
        setupButtonsAndActivityIndicator()
        setupTextFieldAndButtonFonts()
    }
    
    private func determineLoginRegisterButtonTitle() {
        if didSelectLogin == true {
            loginRegisterButton.setTitle("Login", for: .normal)
        } else {
            loginRegisterButton.setTitle("Register", for: .normal)
        }
    }
    
    private func setupTextFields() {
        shmaIdTextField.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        shmaIdSeperatorView.anchor(top: shmaIdTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        nameTextField.anchor(top: shmaIdTextField.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        nameSeperatorView.anchor(top: nameTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        emailTextField.anchor(top: nameSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        emailSeperatorView.anchor(top: emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        passwordTextField.anchor(top: emailSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        passwordSeperatorView.anchor(top: passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        dobTextField.anchor(top: passwordSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        dobSeperatorView.anchor(top: dobTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        addressTextField.anchor(top: dobSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        addressSeperatorView.anchor(top: addressTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        townTextField.anchor(top: addressSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        townSeperatorView.anchor(top: townTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        postcodeTextField.anchor(top: townSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        postcodeSeperatorView.anchor(top: postcodeTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        mobileNoTextField.anchor(top: postcodeSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
    }
    
    private func setupTextFieldHeightAnchors() {
        shmaIdTextFieldHeightAnchor = loginRegistrationViewModel.getShmaIdTextFieldHeightConstraintBasedOnLoginTypeSelected()
        shmaIdTextFieldHeightAnchor?.isActive = true
        
        nameTextFieldHeightAnchor = loginRegistrationViewModel.getNameTextFieldHeightConstraintBasedOnLoginTypeSelected()
        nameTextFieldHeightAnchor?.isActive = true
        
        emailTextFieldHeightAnchor = loginRegistrationViewModel.getEmailTextFieldHeightConstraintBasedOnLoginTypeSelected()
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor = loginRegistrationViewModel.getPasswordTextFieldHeightConstraintBasedOnLoginTypeSelected()
        passwordTextFieldHeightAnchor?.isActive = true
        
        dobTextFieldHeightAnchor = loginRegistrationViewModel.getDobTextFieldHeightConstraintBasedOnLoginTypeSelected()
        dobTextFieldHeightAnchor?.isActive = true
        
        addressTextFieldHeightAnchor = loginRegistrationViewModel.getAddressTextFieldHeightConstraintBasedOnLoginTypeSelected()
        addressTextFieldHeightAnchor?.isActive = true
        
        townTextFieldHeightAnchor = loginRegistrationViewModel.getTownTextFieldHeightConstraintBasedOnLoginTypeSelected()
        townTextFieldHeightAnchor?.isActive = true
        
        postcodeTextFieldHeightAnchor = loginRegistrationViewModel.getPostcodeTextFieldHeightConstraintBasedOnLoginTypeSelected()
        postcodeTextFieldHeightAnchor?.isActive = true
        
        mobileTextFieldHeightAnchor = loginRegistrationViewModel.getMobileNoTextFieldHeightConstraintBasedOnLoginTypeSelected()
        mobileTextFieldHeightAnchor?.isActive = true
        
        loginRegisterButtonHeightAnchor = loginRegistrationViewModel.getLoginRegisterButtonHeightConstraintBasedOnLoginTypeSelected()
        loginRegisterButtonHeightAnchor?.isActive = true
    }
    
    private func setupButtonsAndActivityIndicator() {
        loginRegisterButton.anchor(top: mobileNoTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        activityIndicatorView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: centerYAnchor, centerXAnchor: centerXAnchor)
    }
    
    private func setupTextFieldAndButtonFonts() {
        loginRegisterButton.titleLabel?.font = loginRegistrationViewModel.getLoginRegisterButtonFontForEachDevice()
        shmaIdTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        nameTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        emailTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        passwordTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        dobTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        addressTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        townTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        postcodeTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        mobileNoTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
    }
    
    @objc func handleLoginRegister() {
        delegate?.didPressLoginRegister()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
}
