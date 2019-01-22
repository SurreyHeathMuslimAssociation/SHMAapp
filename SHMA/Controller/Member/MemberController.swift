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
        guard let image = UIImage(named: "NavLogo") else { return } //Your logo url here
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        memberView.traitCollectionDidChange(traitCollection)
        setupMemberViewHeight()
    }
}

