//
//  LoginRegistrationViewModel.swift
//  SHMATests
//
//  Created by Umar Yaqub on 11/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class LoginRegistrationViewModelTests: XCTestCase {
    
    var sut: LoginRegistrationViewModel!
    var traitCollection: UITraitCollection!
    var loginRegistrationView: UIView!
    var didSelectLogin: Bool?
    var didSelectExistingMemberRegistration: Bool?
    var didSelectNewMemberRegistration: Bool?
    var shmaIdTextField: UITextField!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var dobTextField: UITextField!
    var addressTextField: UITextField!
    var townTextField: UITextField!
    var postcodeTextField: UITextField!
    var mobileNoTextField: UITextField!
    var loginRegisterButton: UIButton!
    
    let iPadLoginRegisterButtonAndTextFieldFont = UIFont.systemFont(ofSize: 22)
    let iPhoneLoginRegisterButtonAndTextFieldFont = UIFont.systemFont(ofSize: 14)
    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        loginRegistrationView = UIView()
        didSelectLogin = true
        shmaIdTextField = UITextField()
        nameTextField = UITextField()
        emailTextField = UITextField()
        passwordTextField = UITextField()
        dobTextField = UITextField()
        addressTextField = UITextField()
        townTextField = UITextField()
        postcodeTextField = UITextField()
        mobileNoTextField = UITextField()
        loginRegisterButton = UIButton()
        
        sut = LoginRegistrationViewModel(traitCollection, loginRegistrationView: loginRegistrationView, didSelectLogin ?? false, didSelectExistingMemberRegistration ?? false, didSelectNewMemberRegistration ?? false, shmaIdTextField, nameTextField, emailTextField, passwordTextField, dobTextField, addressTextField, townTextField, postcodeTextField, mobileNoTextField, loginRegisterButton)
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        loginRegistrationView = nil
        didSelectLogin = nil
        didSelectExistingMemberRegistration = nil
        didSelectNewMemberRegistration = nil
        shmaIdTextField = nil
        nameTextField = nil
        emailTextField = nil
        passwordTextField = nil
        dobTextField = nil
        addressTextField = nil
        townTextField = nil
        postcodeTextField = nil
        mobileNoTextField = nil
        loginRegisterButton = nil
        super.tearDown()
    }
    
    // button and textfield fonts
    func testGetsCorrectLoginRegisterButtonFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getLoginRegisterButtonFontForEachDevice(), iPadLoginRegisterButtonAndTextFieldFont)
        } else {
            XCTAssertEqual(sut.getLoginRegisterButtonFontForEachDevice(), iPhoneLoginRegisterButtonAndTextFieldFont)
        }
    }
    
    func testGetsCorrectTextFieldFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getTextFieldFontForEachDevice(), iPadLoginRegisterButtonAndTextFieldFont)
        } else {
            XCTAssertEqual(sut.getTextFieldFontForEachDevice(), iPhoneLoginRegisterButtonAndTextFieldFont)
        }
    }
    
    // textfields
    func testGetsCorrectShmaIdTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectExistingMemberRegistration == true {
            XCTAssertEqual(sut.getShmaIdTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, shmaIdTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/4).constant)
        } else {
            XCTAssertEqual(sut.getShmaIdTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, shmaIdTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0).constant)
        }
    }
    
    func testGetsCorrectNameTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            XCTAssertEqual(sut.getNameTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, nameTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/9).constant)
        } else {
            XCTAssertEqual(sut.getNameTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, nameTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0).constant)
        }
    }
    
    func testGetsCorrectEmailTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectLogin == true {
            XCTAssertEqual(sut.getEmailTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, emailTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/3).constant)
        } else if didSelectExistingMemberRegistration == true {
            XCTAssertEqual(sut.getEmailTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, emailTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/4).constant)
        } else {
            XCTAssertEqual(sut.getEmailTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, emailTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/9).constant)
        }
    }
    
    func testGetsCorrectPasswordTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectLogin == true {
            XCTAssertEqual(sut.getPasswordTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, passwordTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/3).constant)
        } else if didSelectExistingMemberRegistration == true {
            XCTAssertEqual(sut.getPasswordTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, passwordTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/4).constant)
        } else {
            XCTAssertEqual(sut.getPasswordTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, passwordTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/9).constant)
        }
    }
    
    func testGetsCorrectDobTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            XCTAssertEqual(sut.getDobTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, dobTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/9).constant)
        } else {
            XCTAssertEqual(sut.getDobTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, dobTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0).constant)
        }
    }
    
    func testGetsCorrectAddressTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            XCTAssertEqual(sut.getAddressTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, addressTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/9).constant)
        } else {
            XCTAssertEqual(sut.getAddressTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, addressTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0).constant)
        }
    }
    
    func testGetsCorrectTownTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            XCTAssertEqual(sut.getTownTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, townTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/9).constant)
        } else {
            XCTAssertEqual(sut.getTownTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, townTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0).constant)
        }
    }
    
    func testGetsCorrectPostcodeTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            XCTAssertEqual(sut.getPostcodeTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, postcodeTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/9).constant)
        } else {
            XCTAssertEqual(sut.getPostcodeTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, postcodeTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0).constant)
        }
    }
    
    func testGetsCorrectMobileNoTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            XCTAssertEqual(sut.getMobileNoTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, mobileNoTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/9).constant)
        } else {
            XCTAssertEqual(sut.getMobileNoTextFieldHeightConstraintBasedOnLoginTypeSelected().constant, mobileNoTextField.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0).constant)
        }
    }
    
    //login register button
    func testGetsCorrectLoginRegisterButtonHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectLogin == true {
            XCTAssertEqual(sut.getLoginRegisterButtonHeightConstraintBasedOnLoginTypeSelected().constant, loginRegisterButton.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/3).constant)
        } else if didSelectExistingMemberRegistration == true {
            XCTAssertEqual(sut.getLoginRegisterButtonHeightConstraintBasedOnLoginTypeSelected().constant, loginRegisterButton.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/4).constant)
        } else {
            XCTAssertEqual(sut.getLoginRegisterButtonHeightConstraintBasedOnLoginTypeSelected().constant, loginRegisterButton.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 1/9).constant)
        }
    }
    
    //login registration view
    func testGetsCorrectLoginRegistrationViewHeightConstraitForLoginType() {
        if didSelectLogin == true {
            if traitCollection.isIphoneLandscape {
                XCTAssertEqual(sut.getLoginRegistrationViewHeightConstraitForEachTypeAndDevice().constant, loginRegistrationView.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0.35).constant)
            } else {
                XCTAssertEqual(sut.getLoginRegistrationViewHeightConstraitForEachTypeAndDevice().constant, loginRegistrationView.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0.25).constant)
            }
        }
    }
    
    func testGetsCorrectLoginRegistrationViewHeightConstraitForExistingRegistrationType() {
        if didSelectExistingMemberRegistration == true {
            if traitCollection.isIphoneLandscape {
                XCTAssertEqual(sut.getLoginRegistrationViewHeightConstraitForEachTypeAndDevice().constant, loginRegistrationView.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0.4).constant)
            } else {
                XCTAssertEqual(sut.getLoginRegistrationViewHeightConstraitForEachTypeAndDevice().constant, loginRegistrationView.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0.3).constant)
            }
        }
    }
    
    func testGetsCorrectLoginRegistrationViewHeightConstraitForNewRegistrationType() {
        if didSelectNewMemberRegistration == true {
            if traitCollection.isIphoneLandscape {
                XCTAssertEqual(sut.getLoginRegistrationViewHeightConstraitForEachTypeAndDevice().constant, loginRegistrationView.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0.8).constant)
            } else {
                XCTAssertEqual(sut.getLoginRegistrationViewHeightConstraitForEachTypeAndDevice().constant, loginRegistrationView.heightAnchor.constraint(equalTo: loginRegistrationView.heightAnchor, multiplier: 0.65).constant)
            }
        }
    }
}
