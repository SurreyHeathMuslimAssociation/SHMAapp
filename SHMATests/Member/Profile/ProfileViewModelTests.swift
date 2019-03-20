//
//  ProfileViewModelTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 04/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class ProfileViewModelTests: XCTestCase {
    
    var sut: ProfileViewModel!
    var traitCollection: UITraitCollection!
    var member: Member!
    var association: Association!

    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        
        setupMember()
        setupAssociation()

        sut = ProfileViewModel(traitCollection, member)
        sut.association = association
        
    }
    
    private func setupMember() {
        do {
            let value = ["firstName": "firstname", "lastName": "lastname", "membershipType": "Single", "status": "Applied", "shmaId": 123] as [String : Any]
            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
            let member = try JSONDecoder().decode(Member.self, from: jsonData)
            self.member = member
        } catch {
            print(error)
        }
    }
    
    private func setupAssociation() {
        do {
            let value = ["name": "Surrey Heath Muslim Association", "alias": "SHMA", "generalEmail": "test@gmail.com", "committeeEmail": "test@gmail.com", "web": "www.shma.org", "postalAddress": "1 New Lane"]
            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
            let association = try JSONDecoder().decode(Association.self, from: jsonData)
            self.association = association
        } catch {
            print(error)
        }
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        member = nil
        super.tearDown()
    }
    
    func testGetsLabelAndTextFeildFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getLabelAndTextViewFontForEachDevice(), UIFont.systemFont(ofSize: 22))
        } else {
            XCTAssertEqual(sut.getLabelAndTextViewFontForEachDevice(), UIFont.systemFont(ofSize: 14))
        }
    }
    
    func testGetsLabelTextColour() {
        XCTAssertEqual(sut.getLabelTextColour(), UIColor.lightGray)
    }
    
    func testIsTextFieldUserInteractionEnabled() {
        XCTAssertEqual(sut.isTextFieldUserInteractionEnabled(), false)
    }
    
    func testGetsNavigationBarTitleTextAttributes() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        } else {
            XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        }
    }
    
    func testGetsNavigationBarTitle() {
        XCTAssertEqual(sut.getNavigationBarTitle(), "SHMA ID: \(member.shmaId ?? 0)")
    }
    
    func testGetsFooterTextViewText() {
        let lineOne = "If you have any queries please contact us on\n \(association?.committeeEmail ?? "")"
        let lineTwo = "\n\nAlternatively you can post to us on the following address:"
        let address = association?.postalAddress.replacingOccurrences(of: ", ", with: "\n") ?? ""
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: lineOne, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)])
            attributedText.append(NSAttributedString(string: lineTwo, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)]))
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]))
            attributedText.append(NSAttributedString(string: "\(address)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)]))
            XCTAssertEqual(sut.getFooterTextViewText(), attributedText)
        } else {
            let attributedText = NSMutableAttributedString(string: lineOne, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
            attributedText.append(NSAttributedString(string: lineTwo, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 6)]))
            attributedText.append(NSAttributedString(string: "\(address)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            XCTAssertEqual(sut.getFooterTextViewText(), attributedText)
        }
    }
    
    func testGetsTableViewCellHeightForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getTableViewCellHeightForEachDevice(), 80)
        } else {
            XCTAssertEqual(sut.getTableViewCellHeightForEachDevice(), 60)
        }
    }
    
    func testGetsTableViewFooterHeightForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getTableViewFooterHeightForEachDevice(), 250)
        } else {
            XCTAssertEqual(sut.getTableViewFooterHeightForEachDevice(), 200)
        }
    }
    
    func testGetsMemberDetailLabelLeftPadding() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getMemberDetailLabelLeftPadding(), 15)
        } else {
            XCTAssertEqual(sut.getMemberDetailLabelLeftPadding(), 10)
        }
    }
    
    func testGetsMemberDetailLabelWidth() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getMemberDetailLabelWidth(), 180)
        } else {
            XCTAssertEqual(sut.getMemberDetailLabelWidth(), 120)
        }
    }
    
    func testGetsMemberDetailTextFieldLeftPadding() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getMemberDetailTextViewLeftPadding(), 40)
        } else {
            XCTAssertEqual(sut.getMemberDetailTextViewLeftPadding(), 20)
        }
    }
    
    func testGetsInfoTextViewTopPadding() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getInfoTextViewTopPadding(), 30)
        } else {
            XCTAssertEqual(sut.getInfoTextViewTopPadding(), 0)
        }
    }
}
