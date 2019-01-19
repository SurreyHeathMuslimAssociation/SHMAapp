//
//  MemberController.swift
//  SHMA
//
//  Created by Umar Yaqub on 22/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class MemberController: UIViewController {
    
    var memberView: MemberView!
    var memberViewHeightAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        memberView = MemberView(traitCollection: traitCollection)
        memberView.delegate = self
        view.addSubview(memberView)
        memberView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, centerYAnchor: view.centerYAnchor, centerXAnchor: nil)
        
        setupMemberViewHeight()
        setupNavBar()
    }
    
    private func setupMemberViewHeight() {
        memberViewHeightAnchor?.isActive = false
        memberViewHeightAnchor = memberView.memberViewModel.getMemberViewHeightForEachDevice()
        memberViewHeightAnchor?.isActive = true
    }
    
    private func setupNavBar() {
        guard let navController = navigationController else { return }
        
        guard let image = UIImage(named: "NavLogo") else { return } //Your logo url here
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - (image.size.width) / 2
        let bannerY = bannerHeight / 2 - (image.size.height) / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        memberView.traitCollectionDidChange(traitCollection)
        setupMemberViewHeight()
    }
}

