//
//  LoginRegistrationView+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/01/2019.
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
   
    private func setupKeyboardNotifications() {
        if didSelectNewMemberRegistration == true {
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
            notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        }
    }
    
    private func setupSpouseChildTableView() {
        spouseChildTableView = UITableView(frame: .zero, style: .plain)
        spouseChildTableView?.isHidden = true
        guard let spouseChildTableView = spouseChildTableView else { return }
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
    }
    
    func setScrollViewContentSizeForNewMemberLogin() {
        scrollView.contentSize = loginRegistrationViewModel.getScrollViewContentSizeForNewMemberRegistration()
    }
    
    private func determineIfSpouseChildTableViewIsVisible() {
        spouseChildTableView.isHidden = loginRegistrationViewModel.determineIfSpouseChildTableViewIsHidden()
        coverView.isHidden = loginRegistrationViewModel.determineIfCoverViewIsHidden()
    }
    
    private func determineLoginRegisterButtonTitleAndWhichTextFieldsAreVisible() {
        loginRegisterButton.setTitle(loginRegistrationViewModel.getLoginRegisterButtonTitle(), for: .normal)
        loginRegistrationViewModel.determineVisibleItemsBasedOnLoginTypeSelected()
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
        
        activityIndicatorView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: centerYAnchor, centerXAnchor: centerXAnchor)
    }
    
    private func setupTextFieldLabelAndButtonTextAndFonts() {
        mainLabel.attributedText = loginRegistrationViewModel.getMainLabelAttributedTextForEachDevice()
        membershipLabel.attributedText = loginRegistrationViewModel.getMembershipLabelAttributedTextForEachDevice()
        loginRegisterButton.titleLabel?.font = loginRegistrationViewModel.getLoginRegisterButtonFontForEachDevice()
        shmaIdTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        nameTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        emailTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        passwordTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        dobTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        addressLineOneTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        addressLineTwoTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        townTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        postcodeTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
        mobileNoTextField.font = loginRegistrationViewModel.getTextFieldFontForEachDevice()
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
    
    @objc func handleMembershipSwitch() {
        loginRegisterButton.setTitle(loginRegistrationViewModel.getLoginRegisterButtonTitle(), for: .normal)
        setScrollViewContentSizeForNewMemberLogin()
        determineIfSpouseChildTableViewIsVisible()
        delegate?.didSwitchToFamilyMembership()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
    
    @objc func handleKeyboard() {
        endEditing(true)
    }
}
