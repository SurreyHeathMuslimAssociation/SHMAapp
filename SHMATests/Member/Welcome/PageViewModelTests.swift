//
//  PageViewModelTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 30/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class PageViewModelTests: XCTestCase {
    
    var sut: PageViewModel!
    var traitCollection: UITraitCollection!
    var member: Member!
    var page: Page!
    var isNavBarHidden: Bool!
    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        isNavBarHidden = true
        
        do {
            let value = ["firstName": "firstname", "lastName": "lastname", "membershipType": "Single", "status": "Applied", "shmaId": 123] as [String : Any]
            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
            let member = try JSONDecoder().decode(Member.self, from: jsonData)
            self.member = member
        } catch {
            print(error)
        }
        let message = "Just few more steps to go:\n\n✔ Verfiy your account via the link in your email\n✔ Setup your monthly standing order to the following account:\n\nSurrey Heath Muslim Association\n(Registered Charity Number 1126441)\nAl Rayan Bank, 77-79 Edgware Road, London. W2 2HZ\nSort Code: 30-00-83\nAccount Number: 01222601\n\nThe payment reference must be: SHMA-\(member.shmaId ?? 0)"
        page = Page(title: "", message: message, type: .payment)
        sut = PageViewModel(page: page, deviceTraitCollection: traitCollection, member, isNavBarHidden)
    }
    
    override func tearDown() {
        sut = nil
        traitCollection = nil
        member = nil
        page = nil
        isNavBarHidden = nil
        super.tearDown()
    }
    
    func testGetsMainLabelAttributedText() {
        let attributedText = NSMutableAttributedString()
        let message = page.message as NSString
        if traitCollection.isIpad {
            attributedText.append(NSAttributedString(string: "\(page.title)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)]))
            attributedText.append(NSAttributedString(string: member.fullName, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40)]))
            attributedText.append(NSAttributedString(string: "\n\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]))
            attributedText.append(getMessageStringWithAttributes(message, fontSize: 30))
            XCTAssertEqual(sut.getMainLabelAttributedText(), attributedText)
        } else {
            attributedText.append(NSAttributedString(string: "\(page.title)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]))
            attributedText.append(NSAttributedString(string: member.fullName, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]))
            attributedText.append(NSAttributedString(string: "\n\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8)]))
            attributedText.append(getMessageStringWithAttributes(message, fontSize: 18))
            XCTAssertEqual(sut.getMainLabelAttributedText(), attributedText)
        }
    }
    
    private func getMessageStringWithAttributes(_ message: NSString, fontSize: CGFloat) -> NSAttributedString {
        let messageAT = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
        messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)], range: message.range(of: "Surrey Heath Muslim Association"))
        messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)], range: message.range(of: "£7"))
        messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)], range: message.range(of: "£4"))
        messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)], range: message.range(of: "30-00-83"))
        messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)], range: message.range(of: "01222601"))
        messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)], range: message.range(of: "SHMA-\(member.shmaId ?? 0)"))
        return messageAT
    }
    
    func testGetsButtonIsHiddenStatus() {
        if isNavBarHidden {
            if member.status == "Applied" {
                if page.type == .payment {
                    XCTAssertEqual(sut.getButtonIsHiddenStatus(), false)
                } else {
                    XCTAssertEqual(sut.getButtonIsHiddenStatus(), true)
                }
            } else {
                XCTAssertEqual(sut.getButtonIsHiddenStatus(), false)
            }
        } else {
            XCTAssertEqual(sut.getButtonIsHiddenStatus(), true)
        }
    }
    
    func testGetsButtonFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getButtonFontForEachDevice(), UIFont.systemFont(ofSize: 22))
        } else {
            XCTAssertEqual(sut.getButtonFontForEachDevice(), UIFont.systemFont(ofSize: 14))
        }
    }
    
    func testGetsButtonWidthForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getButtonWidthForEachDevice(), 520)
        } else {
            XCTAssertEqual(sut.getButtonWidthForEachDevice(), 260)
        }
    }
    
    func testGetsButtonHeightForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getButtonHeightForEachDevice(), 85)
        } else {
            XCTAssertEqual(sut.getButtonHeightForEachDevice(), 45)
        }
    }
    
    func testGetsButtonCornerRadiusForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getButtonCornerRadiusForEachDevice(), 10)
        } else {
            XCTAssertEqual(sut.getButtonCornerRadiusForEachDevice(), 5)
        }
    }
}


