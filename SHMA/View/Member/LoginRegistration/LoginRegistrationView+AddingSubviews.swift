//
//  LoginRegistrationView+AddingSubviews.swift
//  SHMA
//
//  Created by Umar Yaqub on 21/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension LoginRegistrationView {
    
    func setupView() {
        addSubview(scrollView)
        scrollView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        scrollView.addSubview(mainLabel)
        scrollView.addSubview(membershipLabel)
        scrollView.addSubview(membershipSwitch)
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
        scrollView.addSubview(addressLineOneTextField)
        scrollView.addSubview(addressLineTwoTextField)
        scrollView.addSubview(addressLineOneSeperatorView)
        scrollView.addSubview(addressLineTwoSeperatorView)
        scrollView.addSubview(townTextField)
        scrollView.addSubview(townSeperatorView)
        scrollView.addSubview(postcodeTextField)
        scrollView.addSubview(postcodeSeperatorView)
        scrollView.addSubview(mobileNoTextField)
        scrollView.addSubview(loginRegisterButton)
        scrollView.addSubview(passswordResetButton)
        scrollView.addSubview(activityIndicatorView)
        
        setupKeyboardNotifications()
        setTextFieldDelegates()
        setScrollViewContentSizeForNewMemberLogin()
        determineLoginRegisterButtonTitleAndWhichTextFieldsAreVisible()
        setupLabelAndSwitch()
        setupTextFieldsSwitchAndLabel()
        setupButtonsDimViewAndActivityIndicator()
        setupTextFieldLabelAndButtonTextAndFonts()
        setupSpouseChildTableView()
    }
    
    private func setupSpouseChildTableView() {
        spouseChildTableView = UITableView(frame: .zero, style: .plain)
        spouseChildTableView.isHidden = true
        spouseChildTableView.delegate = self
        spouseChildTableView.dataSource = self
        spouseChildTableView.register(SpouseChildCell.self, forCellReuseIdentifier: cellId)
        spouseChildTableView.register(AddSpouseChildCell.self, forCellReuseIdentifier: addChildCellId)
        scrollView.addSubview(spouseChildTableView)
        childCells = [SpouseChildCell]()
        spouseChildTableView.tableFooterView = UIView()
        spouseChildTableView.anchor(top: loginRegisterButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300, centerYAnchor: nil, centerXAnchor: nil)
        
        scrollView.addSubview(coverView)
        coverView.anchor(top: loginRegisterButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300, centerYAnchor: nil, centerXAnchor: nil)
        scrollView.sendSubviewToBack(coverView)
    }
    
    private func setupLabelAndSwitch() {
        mainLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        labelHeightAnchor = loginRegistrationViewModel.getLabelHeightAnchor()
        labelHeightAnchor?.isActive = true
        
        membershipLabel.anchor(top: mainLabel.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: membershipSwitch.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60, centerYAnchor: nil, centerXAnchor: nil)
        
        membershipSwitch.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 0, height: 0, centerYAnchor: membershipLabel.centerYAnchor, centerXAnchor: nil)
    }
    
    private func setupTextFieldsSwitchAndLabel() {
        shmaIdTextField.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        shmaIdTextFieldTopAnchor = loginRegistrationViewModel.getShmaIdTextFieldTopConstraintForEachDeviceBasedOnLoginTypeSelected()
        shmaIdTextFieldTopAnchor?.isActive = true
        shmaIdTextFieldHeightAnchor = loginRegistrationViewModel.getShmaIdTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected()
        shmaIdTextFieldHeightAnchor?.isActive = true
        
        shmaIdSeperatorView.anchor(top: shmaIdTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        nameTextField.anchor(top: shmaIdSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        nameTextFieldHeightAnchor = loginRegistrationViewModel.getNameTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected()
        nameTextFieldHeightAnchor?.isActive = true
        
        nameSeperatorView.anchor(top: nameTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        emailTextField.anchor(top: nameSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        emailTextFieldHeightAnchor = loginRegistrationViewModel.getEmailTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected()
        emailTextFieldHeightAnchor?.isActive = true
        
        emailSeperatorView.anchor(top: emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        passwordTextField.anchor(top: emailSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        passwordTextFieldHeightAnchor = loginRegistrationViewModel.getPasswordTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected()
        passwordTextFieldHeightAnchor?.isActive = true
        
        passwordSeperatorView.anchor(top: passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        dobTextField.anchor(top: passwordSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        dobTextFieldHeightAnchor = loginRegistrationViewModel.getDobTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected()
        dobTextFieldHeightAnchor?.isActive = true
        
        dobSeperatorView.anchor(top: dobTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        addressLineOneTextField.anchor(top: dobSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        addressLineOneTextFieldHeightAnchor = loginRegistrationViewModel.getAddressLineOneTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected()
        addressLineOneTextFieldHeightAnchor?.isActive = true
        
        addressLineOneSeperatorView.anchor(top: addressLineOneTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        addressLineTwoTextField.anchor(top: addressLineOneSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        addressLineTwoTextFieldHeightAnchor = loginRegistrationViewModel.getAddressLineTwoTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected()
        addressLineTwoTextFieldHeightAnchor?.isActive = true
        
        addressLineTwoSeperatorView.anchor(top: addressLineTwoTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        townTextField.anchor(top: addressLineTwoSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        townTextFieldHeightAnchor = loginRegistrationViewModel.getTownTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected()
        townTextFieldHeightAnchor?.isActive = true
        
        townSeperatorView.anchor(top: townTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        postcodeTextField.anchor(top: townSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        postcodeTextFieldHeightAnchor = loginRegistrationViewModel.getPostcodeTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected()
        postcodeTextFieldHeightAnchor?.isActive = true
        
        postcodeSeperatorView.anchor(top: postcodeTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5, centerYAnchor: nil, centerXAnchor: nil)
        
        mobileNoTextField.anchor(top: postcodeSeperatorView.bottomAnchor, left: shmaIdTextField.leftAnchor, bottom: nil, right: shmaIdTextField.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        mobileTextFieldHeightAnchor = loginRegistrationViewModel.getMobileNoTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected()
        mobileTextFieldHeightAnchor?.isActive = true
    }
    
    
    private func setupButtonsDimViewAndActivityIndicator() {
        loginRegisterButton.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        loginRegisterButtonTopAnchor = loginRegistrationViewModel.getLoginRegisterButtonTopAnchor()
        loginRegisterButtonTopAnchor?.isActive = true
        loginRegisterButtonHeightAnchor = loginRegistrationViewModel.getLoginRegisterButtonHeightConstraint()
        loginRegisterButtonHeightAnchor?.isActive = true
        
        passswordResetButton.anchor(top: loginRegisterButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: centerXAnchor)
        passswordResetButton.widthAnchor.constraint(equalTo: loginRegisterButton.widthAnchor, multiplier: 0.5).isActive = true
        passwordResetButtonHeightAnchor = loginRegistrationViewModel.getPasswordResetButtonHeightConstraint()
        passwordResetButtonHeightAnchor?.isActive = true
        
        activityIndicatorView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: centerYAnchor, centerXAnchor: centerXAnchor)
    }
    
}
