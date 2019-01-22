//
//  PasswordResetViewModelTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 21/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class PasswordResetViewModelTests: XCTestCase {
    
    var sut: PasswordResetViewModel!
    var traitCollection: UITraitCollection!
    var passwordResetView: UIView!
    var mainLabel: UILabel!
    var emailTextField: UITextField!
    var resetPasswordButton: UIButton!
    var attributedText: NSAttributedString!
    
    override func setUp() {
        super.setUp()
        
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        passwordResetView = UIView()
        mainLabel = UILabel()
        emailTextField = UITextField()
        resetPasswordButton = UIButton()
        
        sut = PasswordResetViewModel(traitCollection, passwordResetView, mainLabel, emailTextField, resetPasswordButton)
    }
    
    override func tearDown() {
        traitCollection = nil
        passwordResetView = nil
        mainLabel = nil
        emailTextField = nil
        resetPasswordButton = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetsMainLabelAttributedTextForEachDevice() {
        let title = "Forgotten you Password?"
        let text = "Please provide your email address."
        if traitCollection.isIpad {
            attributedText = NSAttributedString.getAttributedString(title: title, titleFont: UIFont.boldSystemFont(ofSize: 26), linesOfSpace: "\n\n", spaceFont: 4, message: text, messageFont: UIFont.systemFont(ofSize: 20))
            XCTAssertEqual(sut.getMainLabelAttributedTextForEachDevice(), attributedText)
        } else {
            attributedText = NSAttributedString.getAttributedString(title: title, titleFont: UIFont.boldSystemFont(ofSize: 20), linesOfSpace: "\n\n", spaceFont: 4, message: text, messageFont: UIFont.systemFont(ofSize: 14))
            XCTAssertEqual(sut.getMainLabelAttributedTextForEachDevice(), attributedText)
        }
    }
    
    func testGetsPasswordResetViewHeightConstraintForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getPasswordResetViewHeightConstraintForEachDevice().constant, passwordResetView.heightAnchor.constraint(equalToConstant: 220).constant)
        } else {
            XCTAssertEqual(sut.getPasswordResetViewHeightConstraintForEachDevice().constant, passwordResetView.heightAnchor.constraint(equalToConstant: 170).constant)
        }
    }
    
    func testGetsMainLabelHeightConstraintForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getMainLabelHeightConstraintForEachDevice().constant, mainLabel.heightAnchor.constraint(equalToConstant: 100).constant)
        } else {
            XCTAssertEqual(sut.getMainLabelHeightConstraintForEachDevice().constant, mainLabel.heightAnchor.constraint(equalToConstant: 80).constant)
        }
    }
    
    func testGetsEmailTextFieldHeightConstraintForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getEmailTextFieldHeightConstraintForEachDevice().constant, emailTextField.heightAnchor.constraint(equalToConstant: 60).constant)
        } else {
            XCTAssertEqual(sut.getEmailTextFieldHeightConstraintForEachDevice().constant, emailTextField.heightAnchor.constraint(equalToConstant: 45).constant)
        }
    }
    
    func testGetsResetPasswordButtonHeightConstraintForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getResetPasswordButtonHeightConstraintForEachDevice().constant, resetPasswordButton.heightAnchor.constraint(equalToConstant: 60).constant)
        } else {
            XCTAssertEqual(sut.getResetPasswordButtonHeightConstraintForEachDevice().constant, resetPasswordButton.heightAnchor.constraint(equalToConstant: 45).constant)
        }
    }
    
    func testGetsButtonAndTextFeildFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getButtonAndTextFeildFontForEachDevice(), UIFont.systemFont(ofSize: 22))
        } else {
            XCTAssertEqual(sut.getButtonAndTextFeildFontForEachDevice(), UIFont.systemFont(ofSize: 14))
        }
    }
    
    // alerts
    func testGetsEmptyTextFieldsAlertViewTitleForEachDevice() {
        if traitCollection.isIpad {
            attributedText = NSAttributedString.getAttributedStringUsing(text: "Attention", font: 20, spaceFont: 4, isBold: true)
            XCTAssertEqual(sut.getAlertViewTitleForEachDevice("Attention"), attributedText)
        } else {
            attributedText = NSAttributedString.getAttributedStringUsing(text: "Attention", font: 16, spaceFont: nil, isBold: true)
            XCTAssertEqual(sut.getAlertViewTitleForEachDevice("Attention"), attributedText)
        }
    }
    
    func testGetsEmptyTextFieldsAlertViewTextForEachDevice() {
        if traitCollection.isIpad {
            attributedText = NSAttributedString.getAttributedStringUsing(text: "Please ensure all fields are filled in.", font: 16, spaceFont: nil, isBold: false)
            XCTAssertEqual(sut.getAlertViewTextForEachDevice("Please ensure all fields are filled in."), attributedText)
        } else {
            attributedText = NSAttributedString.getAttributedStringUsing(text: "Please ensure all fields are filled in.", font: 13, spaceFont: nil, isBold: false)
            XCTAssertEqual(sut.getAlertViewTextForEachDevice("Please ensure all fields are filled in."), attributedText)
        }
    }
}
