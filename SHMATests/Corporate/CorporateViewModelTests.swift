//
//  CorporateViewModelTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 27/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class CorporateViewModelTests: XCTestCase {

    var sut: CorporateViewModel!
    var traitCollection: UITraitCollection!
    var mainLabel: UILabel!
    var firstNameTextField: UITextField!
    var datePicker: UIDatePicker!
    var view: UIView!
    
    let iPadMainLabelFont = UIFont.systemFont(ofSize: 26)
    let iPhoneMainLabelFont = UIFont.systemFont(ofSize: 16)
    var fetchedShmaIds: [String]!
    var attributedString: NSAttributedString!
    var mutableAttributedString: NSMutableAttributedString!
    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        
        mainLabel = UILabel()
        firstNameTextField = UITextField()
        datePicker = UIDatePicker()
        view = UIView()
        sut = CorporateViewModel(traitCollection, mainLabel, firstNameTextField, datePicker, view)
        fetchedShmaIds = [String]()
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        mainLabel = nil
        firstNameTextField = nil
        datePicker = nil
        view = nil
        fetchedShmaIds = nil
        attributedString = nil
        mutableAttributedString = nil
        super.tearDown()
    }
    
    // mian label tests
    func testGetsCorrectMainLabelFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getMainLabelFontForEachDevice(), iPadMainLabelFont)
        } else {
            XCTAssertEqual(sut.getMainLabelFontForEachDevice(), iPhoneMainLabelFont)
        }
    }
    
    func testGetsCorrectMainLabelBottomAnchorWithPaddingForEverythingButiPhoneLandscape() {
        if !traitCollection.isIphoneLandscape {
            if traitCollection.isIpad {
                 XCTAssertEqual(sut.getMainLabelBottomAnchor()?.constant, mainLabel.bottomAnchor.constraint(equalTo: firstNameTextField.topAnchor, constant: -30).constant)
            } else {
                XCTAssertEqual(sut.getMainLabelBottomAnchor()?.constant, mainLabel.bottomAnchor.constraint(equalTo: firstNameTextField.topAnchor, constant: -10).constant)
            }
        }
    }
    
    func testGetsCorrectMainLabelWidthAnchorForDifferentOrientations() {
        if traitCollection.isIphoneLandscape {
            XCTAssertEqual(sut.getMainLabelWidthAnchor()?.constant, mainLabel.widthAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 1).constant)
        } else {
            XCTAssertEqual(sut.getMainLabelWidthAnchor()?.constant, mainLabel.widthAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 0.9).constant)
        }
    }
    
    func testGetsMainLabelRightAnchorForiPhoneLandscape() {
        if traitCollection.isIphoneLandscape {
            XCTAssertEqual(sut.getMainLabelRightAnchor()?.constant, mainLabel.rightAnchor.constraint(equalTo: datePicker.leftAnchor, constant: -5).constant)
        }
    }
    
    func testGetsMainLabelCenterXAnchorForEverythingButiPhoneLandscape() {
        if !traitCollection.isIphoneLandscape {
            XCTAssertEqual(sut.getMainLabelCenterXAnchor()?.constant, mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).constant)
        }
    }
    
    func testGetsMainLabelCenterYAnchorForiPhoneLandscape() {
        if traitCollection.isIphoneLandscape {
            XCTAssertEqual(sut.getMainLabelCenterYAnchor()?.constant, mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).constant)
        }
    }
    
    // datepicker tests
    func testGetsDatePickerWidthAnchorForDifferentOrientation() {
        if traitCollection.isIphoneLandscape {
            XCTAssertEqual(sut.getDatePickerWidthAnchor().constant, datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).constant)
        } else {
            XCTAssertEqual(sut.getDatePickerWidthAnchor().constant, datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65).constant)
        }
    }
    
    func testGetsDatePickerCenterXAnchorForDifferentOrientation() {
        if traitCollection.isIphoneLandscape {
            XCTAssertEqual(sut.getDatePickerCenterXAnchor().constant, datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80).constant)
        } else {
            XCTAssertEqual(sut.getDatePickerCenterXAnchor().constant, datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).constant)
        }
    }
    
    // surname textfield tests
    func testGetsSurnameTextFieldFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getlastNameTextFieldFontForEachDevice(), UIFont.systemFont(ofSize: 22))
        } else {
             XCTAssertEqual(sut.getlastNameTextFieldFontForEachDevice(), UIFont.systemFont(ofSize: 14))
        }
    }
    
    func testGetsSurnameTextFieldHeightForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getlastNameTextFieldHeightForEachDevice(), 45)
        } else {
            XCTAssertEqual(sut.getlastNameTextFieldHeightForEachDevice(), 35)
        }
    }
    
    func testGetsSurnameTextFieldBottomPaddingForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getlastNameTextFieldBottomPadding(), 10)
        } else {
            XCTAssertEqual(sut.getlastNameTextFieldBottomPadding(), 5)
        }
    }
    
    func testGetsCorrectEmptySurnameTextFieldAlertViewTitleForEachDevice() {
        if traitCollection.isIpad {
             attributedString = NSAttributedString.getAttributedStringUsing(text: "Attention", font: 20, spaceFont: 4, isBold: true)
            XCTAssertEqual(sut.getEmptyLastNameTextFieldAlertViewTitle(), attributedString)
        } else {
             attributedString = NSAttributedString.getAttributedStringUsing(text: "Attention", font: 16, spaceFont: nil, isBold: true)
            XCTAssertEqual(sut.getEmptyLastNameTextFieldAlertViewTitle(), attributedString)
        }
        
    }
    
    func testGetsCorrectEmptySurnameTextFieldAlertViewTextForEachDevice() {
        //XCTAssertEqual(sut.getEmptyLastNameTextFeildAlertViewText(), "Please ensure Surname is entered.")
        if traitCollection.isIpad {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Please ensure 'Surname' is entered.", font: 16, spaceFont: nil, isBold: false)
            XCTAssertEqual(sut.getEmptyLastNameTextFieldAlertViewText(), attributedString)
        } else {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Please ensure 'Surname' is entered.", font: 13, spaceFont: nil, isBold: false)
            XCTAssertEqual(sut.getEmptyLastNameTextFieldAlertViewText(), attributedString)
        }
    }
    
    // search button tests
    func testGetsSearchButtonFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getSearchButtonFontForEachDevice(), UIFont.systemFont(ofSize: 25))
        } else {
            XCTAssertEqual(sut.getSearchButtonFontForEachDevice(), UIFont.systemFont(ofSize: 16))
        }
    }
    
    func testGetsSearchButtonTopPaddingForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getSearchButtonTopPadding(), 10)
        } else {
            XCTAssertEqual(sut.getSearchButtonTopPadding(), 5)
        }
    }
    
    // navbar title attributes tests
    func testGetsNavigationBarTitleTextAttributesForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        } else {
             XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        }
    }
    
    // shma id's search alert tests
    func testGetsCorrectShmaIdsAlertTitleWhenMembersAreFoundForEachDevice() {
        fetchedShmaIds = ["111", "112", "113"]
        if traitCollection.isIpad {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Member Found", font: 20, spaceFont: 4, isBold: true)
            XCTAssertEqual(sut.getShmaIdsAlertTitle(fetchedShmaIds: fetchedShmaIds), attributedString)
        } else {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Member Found", font: 16, spaceFont: 2, isBold: true)
            XCTAssertEqual(sut.getShmaIdsAlertTitle(fetchedShmaIds: fetchedShmaIds), attributedString)
        }
    }
    
    func testGetsCorrectShmaIdsAlertTitleWhenMembersAreNotFoundForEachDevice() {
        if traitCollection.isIpad {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Member Not Found", font: 20, spaceFont: 4, isBold: true)
            XCTAssertEqual(sut.getShmaIdsAlertTitle(fetchedShmaIds: fetchedShmaIds), attributedString)
        } else {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Member Not Found", font: 16, spaceFont: 2, isBold: true)
            XCTAssertEqual(sut.getShmaIdsAlertTitle(fetchedShmaIds: fetchedShmaIds), attributedString)
        }
    }
    
    func testGetsEmptyShmaIdsAlertTextWhenMembersAreNotFound() {
        if traitCollection.isIpad {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Please re-enter the details.", font: 16, spaceFont: nil, isBold: false)
            XCTAssertEqual(sut.getShmaIdsAlertText(fetchedShmaIds: fetchedShmaIds), attributedString)
        } else {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Please re-enter the details.", font: 13, spaceFont: nil, isBold: false)
            XCTAssertEqual(sut.getShmaIdsAlertText(fetchedShmaIds: fetchedShmaIds), attributedString)
        }
    }
    
    func testGetsCorrectShmaIdsAlertTextWhenOnlyOneMembersIsFound() {
        fetchedShmaIds = ["111"]
        let text = "Their SHMA ID is: "
        let confirmationText = "\n Please ask them to confirm."
        mutableAttributedString = NSMutableAttributedString()
        if traitCollection.isIpad {
            mutableAttributedString.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            mutableAttributedString.append(NSAttributedString(string: fetchedShmaIds[0], attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]))
            mutableAttributedString.append(NSAttributedString(string: confirmationText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            XCTAssertEqual(sut.getShmaIdsAlertText(fetchedShmaIds: fetchedShmaIds), mutableAttributedString)
        } else {
            mutableAttributedString.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
            mutableAttributedString.append(NSAttributedString(string: fetchedShmaIds[0], attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)]))
            mutableAttributedString.append(NSAttributedString(string: confirmationText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
            XCTAssertEqual(sut.getShmaIdsAlertText(fetchedShmaIds: fetchedShmaIds), mutableAttributedString)
        }
    }
    
    func testGetsCorrectShmaIdsAlertTextWhenMultipleMembersAreFound() {
        fetchedShmaIds = ["111", "112", "113"]
        let text = "Their SHMA ID is one of the following: "
        let confirmationText = "\n Please ask them to confirm."
        mutableAttributedString = NSMutableAttributedString()
        if traitCollection.isIpad {
            mutableAttributedString.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            mutableAttributedString.append(NSAttributedString(string: "\(fetchedShmaIds ?? [""])", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]))
            mutableAttributedString.append(NSAttributedString(string: confirmationText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            XCTAssertEqual(sut.getShmaIdsAlertText(fetchedShmaIds: fetchedShmaIds), mutableAttributedString)
        } else {
            mutableAttributedString.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
            mutableAttributedString.append(NSAttributedString(string: "\(fetchedShmaIds ?? [""])", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)]))
            mutableAttributedString.append(NSAttributedString(string: confirmationText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
            XCTAssertEqual(sut.getShmaIdsAlertText(fetchedShmaIds: fetchedShmaIds), mutableAttributedString)
        }
    }
    
    // no internet connection alert tests
    func testGetsCorrectNoInternetConnectionAlertTitleForEachDevice() {
        if traitCollection.isIpad {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "No Internet Connection", font: 20, spaceFont: 4, isBold: true)
            XCTAssertEqual(sut.getNoNetworkAlertTitle(), attributedString)
        } else {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "No Internet Connection", font: 16, spaceFont: 2, isBold: true)
            XCTAssertEqual(sut.getNoNetworkAlertTitle(), attributedString)
        }
    }
    
    func testGetsCorrectNoInternetConnectionAlertTextForEachDevice() {
        if traitCollection.isIpad {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Please connect to the internet in order to search a member.", font: 16, spaceFont: nil, isBold: false)
            XCTAssertEqual(sut.getNoNetworkAlertText(), attributedString)
        } else {
            attributedString = NSAttributedString.getAttributedStringUsing(text: "Please connect to the internet in order to search a member.", font: 13, spaceFont: nil, isBold: false)
            XCTAssertEqual(sut.getNoNetworkAlertText(), attributedString)
        }
    }
}
