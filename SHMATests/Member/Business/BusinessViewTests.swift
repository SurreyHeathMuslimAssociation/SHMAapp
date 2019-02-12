//
//  BusinessViewTests.swift
//  SHMATests
//
//  Created by Umar Yaqub on 12/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import XCTest
@testable import SHMA

class BusinessViewTests: XCTestCase, BusinessDetailViewDelegate, BusinessViewDelegate {
    
    var businessView: BusinessView!
    var businessDetailView: BusinessDetailView!
    var traitCollection: UITraitCollection!
    var didFireDelegate: Bool!
    
    override func setUp() {
        super.setUp()
        
        // setting traits
        let iPadTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection(verticalSizeClass: .regular)])
        let iPhonePortraitTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .regular)])
        let iPhoneLandscapeTraits = UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection(verticalSizeClass: .compact)])
        traitCollection = iPadTraits
        
        businessDetailView = BusinessDetailView(frame: .zero, style: .plain)
        businessDetailView.businessDetailViewDelegate = self
        
        businessView = BusinessView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        businessView.businessViewDelegate = self
        businessView.businessViewModels = [BusinessViewModel]()
        
        let businessViewModel = BusinessViewModel(traitCollection)
        businessView.businessViewModels.append(businessViewModel)
        
        didFireDelegate = false
    }
    
    override func tearDown() {
        businessDetailView = nil
        businessView = nil
        traitCollection = nil
        didFireDelegate = nil
        super.tearDown()
    }
    
    func testDelegateIsFired() {
        businessDetailView.didTapGetDirections()
        XCTAssert(didFireDelegate)
    }
    
    func testSecondSutDelegateIsFired() {
        businessView.collectionView(businessView, didSelectItemAt: IndexPath(item: 0, section: 0))
        XCTAssert(didFireDelegate)
    }

    
    func didTapGetDirections() {
        didFireDelegate = true
        
    }
    
    func didTapCell(businessViewModel: BusinessViewModel) {
        didFireDelegate = true
    }

}
