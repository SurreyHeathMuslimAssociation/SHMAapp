//
//  WelcomeView.swift
//  SHMA
//
//  Created by Umar Yaqub on 23/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

protocol WelcomeViewDelegate: class {
    func sendUserToLogin()
}

class WelcomeView: UIView {
    
    weak var delegate: WelcomeViewDelegate?
    
    let cellId = "cellId"

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.alwaysBounceHorizontal = false
        cv.keyboardDismissMode = .onDrag
        cv.bounces = false
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .yellow
        pc.isHidden = true
        pc.isUserInteractionEnabled = false
        return pc
    }()
    
    var welcomeViewModel: WelcomeViewModel!
    var pageViewModel: [PageViewModel]!
    var pages: [Page]!
    /// *pageControl* bottom anchor used to hide the page control on the last page
    var pageControlBottomAnchor: NSLayoutConstraint?
    var isNavBarHidden: Bool?
    
    required init(traitCollection: UITraitCollection, _ member: Member, _ isNavBarHidden: Bool) {
        super.init(frame: .zero)
        backgroundColor = .white
        self.isNavBarHidden = isNavBarHidden
        welcomeViewModel = WelcomeViewModel(traitCollection, member)
        
        setupPageControlAndCollectionView()
        registerCells()
        setupPages(traitCollection, member)
    }
    
    private func setupPageControlAndCollectionView() {
        addSubview(collectionView)
        addSubview(pageControl)
        
        pageControl.anchor(top: nil, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40, centerYAnchor: nil, centerXAnchor: nil)
        pageControlBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: bottomAnchor)
        pageControlBottomAnchor?.isActive = true
        
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
    }
    
    private func registerCells() {
        collectionView.register(WelcomeViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func setupPages(_ traitCollection: UITraitCollection, _ member: Member) {
        pages = [Page]()
        let welcomePage = Page(title: welcomeViewModel.getWelcomePageTitle(), message: welcomeViewModel.getWelcomePageMessage(), type: .welcome)
        pages.append(welcomePage)
        // new member signup (status == applied) has extra pages
        // unhides page control
        if member.status == "Applied" {
            let detailsPage = Page(title: "", message: welcomeViewModel.getDetailPageMessage(), type: .detail)
            let paymentPage = Page(title: "", message: welcomeViewModel.getPaymentPageMessage(), type: .payment)
            pages.append(detailsPage)
            pages.append(paymentPage)
            pageControl.isHidden = false
        }
        // setup pageview model with new pages
        pageViewModel = pages.map({PageViewModel(page: $0, deviceTraitCollection: traitCollection, member, isNavBarHidden ?? false)})
        pageControl.numberOfPages = pageViewModel.count
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
