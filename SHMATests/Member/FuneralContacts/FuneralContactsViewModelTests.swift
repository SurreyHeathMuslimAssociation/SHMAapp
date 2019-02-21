//
//  FuneralContactsViewModelTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 19/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class FuneralContactsViewModelTests: XCTestCase {
    
    var sut: FuneralContactViewModel!
    var traitCollection: UITraitCollection!
    var funeralContactsView: UICollectionView!
    var funeralContact: FuneralContact!
    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        //let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        funeralContactsView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        funeralContact = FuneralContact(name: "Test Contact", phoneNo: "12345")
        
        sut = FuneralContactViewModel(traitCollection)
        sut.funeralContact = funeralContact
        sut.funeralContactsView = funeralContactsView
    }
    
    override func tearDown() {
        traitCollection = nil
        sut = nil
        funeralContact = nil
        funeralContactsView = nil
        super.tearDown()
    }
    
    func testGetsNavigationBarTitleTextAttributes() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        } else {
            XCTAssertEqual(sut.getNavigationBarTitleTextAttributes(), [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        }
    }
    
    func testGetsNameAttributedString() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getNameAttributedString(), NSAttributedString(string: funeralContact?.name ?? "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)]))
        } else {
            XCTAssertEqual(sut.getNameAttributedString(), NSAttributedString(string: funeralContact?.name ?? "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
        }
    }
    
    func testGetsPhoneNoAttributedString() {
        if traitCollection.isIpad {
            XCTAssertEqual(sut.getPhoneNoAttributedString(), NSAttributedString(string: funeralContact?.phoneNo ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]))
        } else {
            XCTAssertEqual(sut.getPhoneNoAttributedString(), NSAttributedString(string: funeralContact?.phoneNo ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        }
    }
    
    func testGetsCollectionViewCellSize() {
        if traitCollection.isIpad {
            let width = (funeralContactsView.frame.width - 3) / 3
            XCTAssertEqual(sut.getCollectionViewCellSize(), CGSize(width: width, height: width))
        } else {
            let width = (funeralContactsView.frame.width - 2) / 3
            XCTAssertEqual(sut.getCollectionViewCellSize(), CGSize(width: width, height: width))
        }
    }
}

