//
//  SHMACardViewModelTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 30/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class SHMACardViewModelTests: XCTestCase {
    
    var sut: SHMACardViewModel!
    var traitCollection: UITraitCollection!
    var shmaCardView: UIView!
    var member: Member!
    var association: Association!
    
    let iPadMainLabelFont = UIFont.systemFont(ofSize: 26)
    let iPhoneMainLabelFont = UIFont.systemFont(ofSize: 16)
    let iPadButtonFont = UIFont.systemFont(ofSize: 22)
    let iPhoneButtonFont = UIFont.systemFont(ofSize: 14)
    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        shmaCardView = UIView()
        
        setupMember()
        setupAssociation()
        
        sut = SHMACardViewModel(traitCollection, shmaCardView, 60, 50)
        sut.member = member
        sut.association = association
        
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        shmaCardView = nil
        member = nil
        association = nil
        super.tearDown()
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
            let value = ["name": "Surrey Heath Muslim Association", "alias": "SHMA", "email": "test@gmail.com", "web": "www.shma.org"]
            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
            let association = try JSONDecoder().decode(Association.self, from: jsonData)
            self.association = association
        } catch {
            print(error)
        }
    }
    
    func testGetsShmaCardLogoWidth() {
        XCTAssertEqual(sut.getShmaCardLogoWidth(), 50)
    }
    
    func testGetsShmaCardLogoHeight() {
        XCTAssertEqual(sut.getShmaCardLogoHeight(), 70)
    }
    
    func testGetsCorrectShmaCardViewHeightAnchorValue() {
        if traitCollection.isIphonePortrait {
            XCTAssertEqual(sut.getShmaCardViewHeightAnchor().constant, 220)
        } else {
            XCTAssertEqual(sut.getShmaCardViewHeightAnchor().constant, 215)
        }
    }
    
    func testGetsCorrectShmaCardViewWidthAnchorValue() {
        if !traitCollection.isIphonePortrait {
            XCTAssertEqual(sut.getShmaCardViewWidthAnchor()?.constant, 330)
        }
    }
    
    func testGetsMembershipNumberLabelHeight() {
        XCTAssertEqual(sut.getMembershipNumberLabelHeight(), 30)
    }
    
    func testGetsContactInfoLabelHeight() {
        XCTAssertEqual(sut.getContactInfoLabelHeight(), 35)
    }
    
    func testGetsDateAndTimeLabelHeight() {
        XCTAssertEqual(sut.getDateAndTimeLabelHeight(), 25)
    }
    
    func testGetsDateAndTimeLabelWidth() {
        XCTAssertEqual(sut.getDateAndTimeLabelWidth(), 100)
    }
    
    func testGetsShmaLogoTextLabelText() {
        let name = association.name
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getShmaLogoTextLabelText(), NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 40) ?? UIFont.systemFont(ofSize: 40)]))
        } else {
            XCTAssertEqual(sut.getShmaLogoTextLabelText(), NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 30) ?? UIFont.systemFont(ofSize: 30)]))
        }
    }
    
    func testGetsShmaContactInfoLabelText() {
        let email = association.email
        let web = association.web
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: "Web: \(web)\n", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 18) ?? UIFont.systemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string: "E-mail: \(email)", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 18) ?? UIFont.systemFont(ofSize: 18)]))
            XCTAssertEqual(sut.getShmaContactInfoLabelText(), attributedText)
        } else {
            let attributedText = NSMutableAttributedString(string: "Web: \(web)\n", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 14) ?? UIFont.systemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string: "E-mail: \(email)", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 14) ?? UIFont.systemFont(ofSize: 14)]))
            XCTAssertEqual(sut.getShmaContactInfoLabelText(), attributedText)
        }
    }
    
    func testGetsDateAndTimeLabelText() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getDateAndTimeLabelText(), NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 18) ?? UIFont.systemFont(ofSize: 18)]))
        } else {
            XCTAssertEqual(sut.getDateAndTimeLabelText(), NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 14) ?? UIFont.systemFont(ofSize: 14)]))
        }
    }
    
    func testGetsShmaMemberMembershipNumberText() {
        let shmaId = member.shmaId
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: "Membership Number:  ", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 22) ?? UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.yellow])
            attributedText.append(NSAttributedString(string: "0\(shmaId ?? 0)A", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 22) ?? UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 218, green: 165, blue: 32)]))
            XCTAssertEqual(sut.getShmaMemberMembershipNumberText(), attributedText)
        } else {
            let attributedText = NSMutableAttributedString(string: "Membership Number:  ", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 16) ?? UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.yellow])
            attributedText.append(NSAttributedString(string: "0\(shmaId ?? 0)A", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 20) ?? UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 218, green: 165, blue: 32)]))
            XCTAssertEqual(sut.getShmaMemberMembershipNumberText(), attributedText)
        }
    }
    
    func testGetsNavigationBarTitleTextAttributes() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        } else {
            XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        }
    }
}

