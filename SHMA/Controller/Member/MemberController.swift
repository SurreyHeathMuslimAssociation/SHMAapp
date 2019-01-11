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
        
        navigationItem.title = "SHMA Member"
        navigationController?.navigationBar.titleTextAttributes = memberView.memberViewModel.getNavigationBarTitleTextAttributesForEachDevice()
        
        setupMemberViewHeight()
    }
    
    private func setupMemberViewHeight() {
        memberViewHeightAnchor?.isActive = false
        memberViewHeightAnchor = memberView.memberViewModel.getMemberViewHeight()
        memberViewHeightAnchor?.isActive = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        memberView.traitCollectionDidChange(traitCollection)
        setupMemberViewHeight()
    }
}
