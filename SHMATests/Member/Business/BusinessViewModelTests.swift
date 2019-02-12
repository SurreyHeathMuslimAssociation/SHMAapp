//
//  BusinessViewModelTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 12/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class BusinessViewModelTests: XCTestCase {
    
    var sut: BusinessViewModel!
    var traitCollection: UITraitCollection!
    var businessView: UICollectionView!
    var business: Business?
    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        businessView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        
        sut = BusinessViewModel(traitCollection)
        sut.businessView = businessView
    }
    
    override func tearDown() {
        traitCollection = nil
        sut = nil
        businessView = nil
        super.tearDown()
    }
    

    
    func testGetsBusinessNameAttributedText() {
        guard let name = business?.information.result.name else { return  }
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getBusinessNameAttributedText(), NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]))
        } else {
            XCTAssertEqual(sut.getBusinessNameAttributedText(), NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        }
    }
    
    func testGetsNavigationBarTitleTextAttributes() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        } else {
            XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        }
    }
    
    func testGetsBusinessCollectionViewCellSize() {
        if traitCollection.isIpad {
            let width = (businessView.frame.width - 3) / 3
            XCTAssertEqual(sut.getBusinessCollectionViewCellSize(), CGSize(width: width, height: width))
        } else {
            let width = (businessView.frame.width - 2) / 3
            XCTAssertEqual(sut.getBusinessCollectionViewCellSize(), CGSize(width: width, height: width))
        }
    }
    
    func testGetsLabelAndTextViewFontForEachDevice() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getLabelAndTextViewFontForEachDevice(), UIFont.systemFont(ofSize: 22))
        } else {
            XCTAssertEqual(sut.getLabelAndTextViewFontForEachDevice(), UIFont.systemFont(ofSize: 14))
        }
    }
    
    func testGetsLabelTextColour() {
        XCTAssertEqual(sut.getLabelTextColour(), UIColor.lightGray)
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
    
    func testGetsMemberDetailTextViewLeftPadding() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getMemberDetailTextViewLeftPadding(), 40)
        } else {
            XCTAssertEqual(sut.getMemberDetailTextViewLeftPadding(), 20)
        }
    }
    
    func testGetsBusinessDetailViewHeaderHeight() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getBusinessDetailViewHeaderHeight(), 300)
        } else {
            XCTAssertEqual(sut.getBusinessDetailViewHeaderHeight(), 200)
        }
    }
    
    func testGetsBusinessDetailViewFooterHeight() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getBusinessDetailViewFooterHeight(), 150)
        } else {
            XCTAssertEqual(sut.getBusinessDetailViewFooterHeight(), 100)
        }
    }
    
}
