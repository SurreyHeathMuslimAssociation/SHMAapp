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
    var mainLabel: UILabel!
    var membershipLabel: UILabel!
    var shmaIdTextField: UITextField!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var dobTextField: UITextField!
    var addressLineOneTextField: UITextField!
    var addressLineTwoTextField: UITextField!
    var townTextField: UITextField!
    var postcodeTextField: UITextField!
    var mobileNoTextField: UITextField!
    var loginRegisterButton: UIButton!
    var passwordResetButton: UIButton!
    var attributedString: NSAttributedString!
    var membershipSwitch: UISwitch!
    var shmaIdSeperatorView: UIView!
    var emailSeperatorView: UIView!
    var nameSeperatorView: UIView!
    var passwordSeperatorView: UIView!
    var dobSeperatorView: UIView!
    var addressLineOneSeperatorView: UIView!
    var addressLineTwoSeperatorView: UIView!
    var townSeperatorView: UIView!
    var postcodeSeperatorView: UIView!
    var coverView: UIView!
    
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
        mainLabel = UILabel()
        membershipLabel = UILabel()
        shmaIdTextField = UITextField()
        nameTextField = UITextField()
        emailTextField = UITextField()
        passwordTextField = UITextField()
        dobTextField = UITextField()
        addressLineOneTextField = UITextField()
        addressLineTwoTextField = UITextField()
        townTextField = UITextField()
        postcodeTextField = UITextField()
        mobileNoTextField = UITextField()
        loginRegisterButton = UIButton()
        passwordResetButton = UIButton()
        membershipSwitch = UISwitch()
        shmaIdSeperatorView = UIView()
        emailSeperatorView = UIView()
        nameSeperatorView = UIView()
        passwordSeperatorView = UIView()
        dobSeperatorView = UIView()
        addressLineOneSeperatorView = UIView()
        addressLineTwoSeperatorView = UIView()
        townSeperatorView = UIView()
        postcodeSeperatorView = UIView()
        coverView = UIView()
        
        sut = LoginRegistrationViewModel(iPadTraits, loginRegistrationView: loginRegistrationView, didSelectLogin ?? false, didSelectExistingMemberRegistration ?? false, didSelectNewMemberRegistration ?? false, mainLabel, membershipLabel, shmaIdTextField, nameTextField, emailTextField, passwordTextField, dobTextField, addressLineOneTextField, addressLineTwoTextField, townTextField, postcodeTextField, mobileNoTextField, loginRegisterButton, passwordResetButton, membershipSwitch, shmaIdSeperatorView, emailSeperatorView, nameSeperatorView, passwordSeperatorView, dobSeperatorView, addressLineOneSeperatorView, addressLineTwoSeperatorView, townSeperatorView, postcodeSeperatorView, coverView)
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
        addressLineOneTextField = nil
        addressLineTwoTextField = nil
        townTextField = nil
        postcodeTextField = nil
        mobileNoTextField = nil
        loginRegisterButton = nil
        membershipSwitch = nil
        shmaIdSeperatorView = nil
        emailSeperatorView = nil
        nameSeperatorView = nil
        passwordSeperatorView = nil
        dobSeperatorView = nil
        addressLineOneSeperatorView = nil
        addressLineTwoSeperatorView = nil
        townSeperatorView = nil
        postcodeSeperatorView = nil
        passwordResetButton = nil
        coverView = nil
        super.tearDown()
    }
    
    //main label
    func testGetsMainLabelHeightAnchor() {
        XCTAssertEqual(sut.getLabelHeightAnchor().constant, mainLabel.heightAnchor.constraint(equalToConstant: 80).constant)
    }
    
    func testGetsLabelFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getLabelFontForEachDevice(), UIFont.systemFont(ofSize: 26))
        } else {
            XCTAssertEqual(sut.getLabelFontForEachDevice(), UIFont.systemFont(ofSize: 16))
        }
    }
    
    func testGetsLoginMainLabelAttributedTextForEachDevice() {
        if didSelectLogin == true {
            let title = "Log In?"
            let text = "Please use your credentials to log in."
            if traitCollection.isIpad {
                attributedString =  NSAttributedString.getAttributedString(title: title, titleFont: UIFont.boldSystemFont(ofSize: 26), linesOfSpace: "\n\n", spaceFont: 4, message: text, messageFont: UIFont.systemFont(ofSize: 20))
                XCTAssertEqual(sut.getMainLabelAttributedTextForEachDevice(), attributedString)
            } else {
                attributedString =  NSAttributedString.getAttributedString(title: title, titleFont: UIFont.boldSystemFont(ofSize: 20), linesOfSpace: "\n\n", spaceFont: 4, message: text, messageFont: UIFont.systemFont(ofSize: 14))
                XCTAssertEqual(sut.getMainLabelAttributedTextForEachDevice(), attributedString)
            }
        }
    }
    
    func testGetsExistingMemberMainLabelAttributedTextForEachDevice() {
        if didSelectExistingMemberRegistration == true {
            let title = "Already a Member?"
            let text = "Register onto out online service using your SHMA ID."
            if traitCollection.isIpad {
                attributedString =  NSAttributedString.getAttributedString(title: title, titleFont: UIFont.boldSystemFont(ofSize: 26), linesOfSpace: "\n\n", spaceFont: 4, message: text, messageFont: UIFont.systemFont(ofSize: 20))
                XCTAssertEqual(sut.getMainLabelAttributedTextForEachDevice(), attributedString)
            } else {
                attributedString =  NSAttributedString.getAttributedString(title: title, titleFont: UIFont.boldSystemFont(ofSize: 20), linesOfSpace: "\n\n", spaceFont: 4, message: text, messageFont: UIFont.systemFont(ofSize: 14))
                XCTAssertEqual(sut.getMainLabelAttributedTextForEachDevice(), attributedString)
            }
        }
    }
    
    func testGetsNewMemberMainLabelAttributedTextForEachDevice() {
        if didSelectNewMemberRegistration == true {
            let title = "Thinking of Joining Us?"
            let text = "Please provide the following details to be part of SHMA."
            if traitCollection.isIpad {
                attributedString =  NSAttributedString.getAttributedString(title: title, titleFont: UIFont.boldSystemFont(ofSize: 26), linesOfSpace: "\n\n", spaceFont: 4, message: text, messageFont: UIFont.systemFont(ofSize: 20))
                XCTAssertEqual(sut.getMainLabelAttributedTextForEachDevice(), attributedString)
            } else {
                attributedString =  NSAttributedString.getAttributedString(title: title, titleFont: UIFont.boldSystemFont(ofSize: 20), linesOfSpace: "\n\n", spaceFont: 4, message: text, messageFont: UIFont.systemFont(ofSize: 14))
                XCTAssertEqual(sut.getMainLabelAttributedTextForEachDevice(), attributedString)
            }
        }
    }
    
    func testGetsMembershipLabelAttributedTextForEachDevice() {
        if didSelectNewMemberRegistration == true {
            if traitCollection.isIpad {
                attributedString = NSAttributedString.getAttributedStringUsing(text: "Family Membership?", font: 22, spaceFont: nil, isBold: true)
                XCTAssertEqual(sut.getMembershipLabelAttributedTextForEachDevice(), attributedString)
            } else {
                attributedString = NSAttributedString.getAttributedStringUsing(text: "Family Membership?", font: 14, spaceFont: nil, isBold: true)
                XCTAssertEqual(sut.getMembershipLabelAttributedTextForEachDevice(), attributedString)
            }
        }
    }
    
    //scrollview contentsize
    func testGetsScrollViewContentSizeForNewMemberRegistration() {
        if didSelectNewMemberRegistration == true {
            if traitCollection.isIphone {
                if membershipSwitch.isOn {
                    XCTAssertEqual(sut.getScrollViewContentSizeForNewMemberRegistration(), CGSize(width: loginRegistrationView.frame.width, height: 790))
                } else {
                    XCTAssertEqual(sut.getScrollViewContentSizeForNewMemberRegistration(), CGSize(width: loginRegistrationView.frame.width, height: 590))
                }
            } else {
                // ipad portrait
                if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
                    if membershipSwitch.isOn {
                        XCTAssertEqual(sut.getScrollViewContentSizeForNewMemberRegistration(), CGSize(width: loginRegistrationView.frame.width, height: 945))
                    } else {
                        XCTAssertEqual(sut.getScrollViewContentSizeForNewMemberRegistration(), CGSize(width: loginRegistrationView.frame.width, height: 740))
                    }
                } else {
                    if membershipSwitch.isOn {
                        XCTAssertEqual(sut.getScrollViewContentSizeForNewMemberRegistration(), CGSize(width: loginRegistrationView.frame.width, height: 945))
                    } else {
                        XCTAssertEqual(sut.getScrollViewContentSizeForNewMemberRegistration(), CGSize(width: loginRegistrationView.frame.width, height: 796))
                    }
                }
            }
        } else {
            XCTAssertEqual(sut.getScrollViewContentSizeForNewMemberRegistration(), CGSize(width: loginRegistrationView.frame.width, height: 0))
        }
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
            if traitCollection.isIpad {
                XCTAssertEqual(sut.getShmaIdTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, shmaIdTextField.heightAnchor.constraint(equalToConstant: 60).constant)
            } else {
                XCTAssertEqual(sut.getShmaIdTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, shmaIdTextField.heightAnchor.constraint(equalToConstant: 45).constant)
            }
        } else {
            XCTAssertEqual(sut.getShmaIdTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, shmaIdTextField.heightAnchor.constraint(equalToConstant: 0).constant)
        }
    }
    
    func testGetsCorrectNameTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            if traitCollection.isIpad {
                XCTAssertEqual(sut.getNameTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, nameTextField.heightAnchor.constraint(equalToConstant: 60).constant)
            } else {
                XCTAssertEqual(sut.getNameTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, nameTextField.heightAnchor.constraint(equalToConstant: 45).constant)
            }
        } else {
            XCTAssertEqual(sut.getNameTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, nameTextField.heightAnchor.constraint(equalToConstant: 0).constant)
        }
    }
    
    func testGetsCorrectEmailTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getEmailTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, emailTextField.heightAnchor.constraint(equalToConstant: 60).constant)
        } else {
            XCTAssertEqual(sut.getEmailTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, emailTextField.heightAnchor.constraint(equalToConstant: 45).constant)
        }
    }
    
    func testGetsCorrectPasswordTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getPasswordTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, passwordTextField.heightAnchor.constraint(equalToConstant: 60).constant)
        } else {
            XCTAssertEqual(sut.getPasswordTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, passwordTextField.heightAnchor.constraint(equalToConstant: 45).constant)
        }
    }
    
    func testGetsCorrectDobTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            if traitCollection.isIpad {
                XCTAssertEqual(sut.getDobTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, dobTextField.heightAnchor.constraint(equalToConstant: 60).constant)
            } else {
                XCTAssertEqual(sut.getDobTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, dobTextField.heightAnchor.constraint(equalToConstant: 45).constant)
            }
        } else {
            XCTAssertEqual(sut.getDobTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, dobTextField.heightAnchor.constraint(equalToConstant: 0).constant)
        }
    }
    
    func testGetsCorrectAddressLineOneTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            if traitCollection.isIpad {
                XCTAssertEqual(sut.getAddressLineOneTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, addressLineOneTextField.heightAnchor.constraint(equalToConstant: 60).constant)
            } else {
                XCTAssertEqual(sut.getAddressLineOneTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, addressLineOneTextField.heightAnchor.constraint(equalToConstant: 45).constant)
            }
        } else {
            XCTAssertEqual(sut.getAddressLineOneTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, addressLineOneTextField.heightAnchor.constraint(equalToConstant: 0).constant)
        }
    }
    
    func testGetsCorrectAddressLineTwoTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            if traitCollection.isIpad {
                XCTAssertEqual(sut.getAddressLineTwoTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, addressLineTwoTextField.heightAnchor.constraint(equalToConstant: 60).constant)
            } else {
                XCTAssertEqual(sut.getAddressLineTwoTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, addressLineTwoTextField.heightAnchor.constraint(equalToConstant: 45).constant)
            }
        } else {
            XCTAssertEqual(sut.getAddressLineTwoTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, addressLineTwoTextField.heightAnchor.constraint(equalToConstant: 0).constant)
        }
    }
    
    func testGetsCorrectTownTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            if traitCollection.isIpad {
                XCTAssertEqual(sut.getTownTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, townTextField.heightAnchor.constraint(equalToConstant: 60).constant)
            } else {
                XCTAssertEqual(sut.getTownTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, townTextField.heightAnchor.constraint(equalToConstant: 45).constant)
            }
        } else {
            XCTAssertEqual(sut.getTownTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, townTextField.heightAnchor.constraint(equalToConstant: 0).constant)
        }
    }
    
    func testGetsCorrectPostcodeTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            if traitCollection.isIpad {
                XCTAssertEqual(sut.getPostcodeTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, postcodeTextField.heightAnchor.constraint(equalToConstant: 60).constant)
            } else {
                XCTAssertEqual(sut.getPostcodeTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, postcodeTextField.heightAnchor.constraint(equalToConstant: 45).constant)
            }
        } else {
            XCTAssertEqual(sut.getPostcodeTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, addressLineOneTextField.heightAnchor.constraint(equalToConstant: 0).constant)
        }
    }
    
    func testGetsCorrectMobileNoTextFieldHeightConstraintBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            if traitCollection.isIpad {
                XCTAssertEqual(sut.getMobileNoTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, mobileNoTextField.heightAnchor.constraint(equalToConstant: 60).constant)
            } else {
                XCTAssertEqual(sut.getMobileNoTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, mobileNoTextField.heightAnchor.constraint(equalToConstant: 45).constant)
            }
        } else {
            XCTAssertEqual(sut.getMobileNoTextFieldHeightConstraintForEachDeviceBasedOnLoginTypeSelected().constant, mobileNoTextField.heightAnchor.constraint(equalToConstant: 0).constant)
        }
    }
    
    //login register button
    func testGetsCorrectLoginRegisterButtonHeightConstraintBasedOnLoginTypeSelected() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getLoginRegisterButtonHeightConstraint().constant, 60)
        } else {
            XCTAssertEqual(sut.getLoginRegisterButtonHeightConstraint().constant, 45)
        }
    }
    
    func testGetsCorrectLoginRegisterButtonTopAnchorBasedOnLoginTypeSelected() {
        if didSelectNewMemberRegistration == true {
            XCTAssertEqual(sut.getLoginRegisterButtonTopAnchor().constant, loginRegisterButton.topAnchor.constraint(equalTo: mobileNoTextField.bottomAnchor).constant)
        } else {
            XCTAssertEqual(sut.getLoginRegisterButtonTopAnchor().constant, loginRegisterButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).constant)
        }
    }
    
    func testGetsCorrectLoginRegisterButtonTitleBasedOnLoginTypeSelected() {
        if didSelectLogin == true {
            XCTAssertEqual(sut.getLoginRegisterButtonTitle(), "Login")
        } else if didSelectExistingMemberRegistration == true {
            XCTAssertEqual(sut.getLoginRegisterButtonTitle(), "Register")
        } else {
            if membershipSwitch.isOn {
                XCTAssertEqual(sut.getLoginRegisterButtonTitle(), "Register (£7 per month)")
            } else {
                XCTAssertEqual(sut.getLoginRegisterButtonTitle(), "Register (£4 per month)")
            }
        }
    }
    
    //login registration view
    func testGetsCorrectLoginRegistrationViewHeightConstraitForLoginType() {
        if didSelectLogin == true {
            if traitCollection.isIpad {
                XCTAssertEqual(sut.getLoginRegistrationViewHeightOrBottomConstraitForEachTypeAndDevice()?.constant, loginRegistrationView.heightAnchor.constraint(equalToConstant: 320).constant)
            } else {
                XCTAssertEqual(sut.getLoginRegistrationViewHeightOrBottomConstraitForEachTypeAndDevice()?.constant, loginRegistrationView.heightAnchor.constraint(equalToConstant: 260).constant)
            }
        }
    }
    
    func testGetsCorrectLoginRegistrationViewHeightConstraitForExistingRegistrationType() {
        if didSelectExistingMemberRegistration == true {
            if traitCollection.isIpad {
                XCTAssertEqual(sut.getLoginRegistrationViewHeightOrBottomConstraitForEachTypeAndDevice()?.constant, loginRegistrationView.heightAnchor.constraint(equalToConstant: 320).constant)
            } else {
                XCTAssertEqual(sut.getLoginRegistrationViewHeightOrBottomConstraitForEachTypeAndDevice()?.constant, loginRegistrationView.heightAnchor.constraint(equalToConstant: 261).constant)
            }
        }
    }
    
    
    // alerts
    func testGetsEmptyTextFieldsAlertViewTitleForEachDevice() {
        if traitCollection.isIpad {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Attention", font: 20, spaceFont: 4, isBold: true)
            XCTAssertEqual(sut.getAlertViewTitleForEachDevice("Attention"), attributedString)
        } else {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Attention", font: 16, spaceFont: nil, isBold: true)
            XCTAssertEqual(sut.getAlertViewTitleForEachDevice("Attention"), attributedString)
        }
    }
    
    func testGetsEmptyTextFieldsAlertViewTextForEachDevice() {
        if traitCollection.isIpad {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Please ensure all fields are filled in.", font: 16, spaceFont: nil, isBold: false)
            XCTAssertEqual(sut.getAlertViewTextForEachDevice("Please ensure all fields are filled in."), attributedString)
        } else {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Please ensure all fields are filled in.", font: 13, spaceFont: nil, isBold: false)
            XCTAssertEqual(sut.getAlertViewTextForEachDevice("Please ensure all fields are filled in."), attributedString)
        }
    }
}
