//
//  HomeController.swift
//  SHMA
//
//  Created by Umar Yaqub on 22/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeController: UIViewController {
    
    var shmaCardView: SHMACardView!
    var shmaCardViewTopAnchor: NSLayoutConstraint?
    var shmaCardViewWidthAnchor: NSLayoutConstraint?
    var shmaCardViewHeightAnchor: NSLayoutConstraint?
    var shmaCardViewCenterYAnchor: NSLayoutConstraint?
    var shmaCardViewRightAnchor: NSLayoutConstraint?
    var firebaseDatabaseManager: FirebaseDatabaseManager!
    var member: Member!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        firebaseDatabaseManager = FirebaseDatabaseManager(session: Database.database())
        
        guard let navBarHeight = navigationController?.navigationBar.frame.height else { return }
        guard let tabBarHeight = tabBarController?.tabBar.frame.height else { return }
        
        shmaCardView = SHMACardView(traitCollection: traitCollection, navBarHeight, tabBarHeight)
        view.addSubview(shmaCardView)
        shmaCardView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        navigationItem.title = member.fullName
        setupShmaCardView()
        fetchAssociationDetails()
        fetchMemberDetails()
    }
    
    private func setupShmaCardView() {
        shmaCardViewTopAnchor?.isActive = false
        shmaCardViewWidthAnchor?.isActive = false
        shmaCardViewCenterYAnchor?.isActive = false
        shmaCardViewRightAnchor?.isActive = false
        shmaCardViewHeightAnchor?.isActive = false
        
        shmaCardViewTopAnchor = shmaCardView.shmaCardViewModel.getShmaCardViewTopAnchor()
        shmaCardViewTopAnchor?.isActive = true
        
        shmaCardViewWidthAnchor = shmaCardView.shmaCardViewModel.getShmaCardViewWidthAnchor()
        shmaCardViewWidthAnchor?.isActive = true
        
        shmaCardViewRightAnchor = shmaCardView.shmaCardViewModel.getShmaCardViewRightAnchor()
        shmaCardViewRightAnchor?.isActive = true
        
        shmaCardViewHeightAnchor = shmaCardView.shmaCardViewModel.getShmaCardViewHeightAnchor()
        shmaCardViewHeightAnchor?.isActive = true
        
        shmaCardViewCenterYAnchor = shmaCardView.shmaCardViewModel.getShmaCardViewCenterYAnchor()
        shmaCardViewCenterYAnchor?.isActive = true
    }
    
    private func fetchAssociationDetails() {
        firebaseDatabaseManager.fetchAssociationDetails { (association) in
            self.shmaCardView.association = association
        }
    }
    
    private func fetchMemberDetails() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        firebaseDatabaseManager.fetchMemberDetails(uid) { (member) in
            self.shmaCardView.member = member
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        shmaCardView.traitCollectionDidChange(previousTraitCollection)
        setupShmaCardView()
    }
}
