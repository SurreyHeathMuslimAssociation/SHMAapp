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
    let iPhoneMainLabelFont = UIFont.systemFont(ofSize: 18)
    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPhonePortraitTraits
        
        mainLabel = UILabel()
        firstNameTextField = UITextField()
        datePicker = UIDatePicker()
        view = UIView()
        sut = CorporateViewModel(traitCollection, mainLabel, firstNameTextField, datePicker, view)
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        mainLabel = nil
        firstNameTextField = nil
        datePicker = nil
        view = nil
        super.tearDown()
    }
    
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
            XCTAssertEqual(sut.getMainLabelWidthAnchor().constant, mainLabel.widthAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 1).constant)
        } else {
            XCTAssertEqual(sut.getMainLabelWidthAnchor().constant, mainLabel.widthAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 0.9).constant)
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
    
    func testGetsFirstNameTextFieldFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getFirstNameTextFieldFontForEachDevice(), UIFont.systemFont(ofSize: 22))
        } else {
             XCTAssertEqual(sut.getFirstNameTextFieldFontForEachDevice(), UIFont.systemFont(ofSize: 14))
        }
    }
    
    func testGetsFirstNameTextFieldHeightForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getFirstNameTextFieldHeightForEachDevice(), 45)
        } else {
            XCTAssertEqual(sut.getFirstNameTextFieldHeightForEachDevice(), 35)
        }
    }
    
    func testGetsFirstNameTextFieldBottomPaddingForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getFirstNameTextFieldBottomPadding(), 10)
        } else {
            XCTAssertEqual(sut.getFirstNameTextFieldBottomPadding(), 5)
        }
    }
    
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
    
    func testGetsNavigationBarTitleTextAttributesForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        } else {
             XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        }
    }
}
