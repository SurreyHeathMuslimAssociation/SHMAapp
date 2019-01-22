//
//  PasswordResetController.swift
//  SHMA
//
//  Created by Umar Yaqub on 21/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordResetController: UIViewController {
    
    var passwordResetView: PasswordResetView!
    var passwordResetViewHeightAnchor: NSLayoutConstraint?
    var passwordResetViewWidthAnchor: NSLayoutConstraint?
    var firebaseAuthManager: FirebaseAuthManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        passwordResetView = PasswordResetView(traitCollection: traitCollection)
        firebaseAuthManager = FirebaseAuthManager(session: Auth.auth())
        
        setupPasswordResetView()
        setupNavBar()
    }
    
    private func setupPasswordResetView() {
        view.addSubview(passwordResetView)
        passwordResetView.delegate = self
        passwordResetView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: view.centerYAnchor, centerXAnchor: view.centerXAnchor)
        passwordResetViewHeightAnchor = passwordResetView.passwordResetViewModel.getPasswordResetViewHeightConstraintForEachDevice()
        passwordResetViewHeightAnchor?.isActive = true
        passwordResetViewWidthAnchor = passwordResetView.passwordResetViewModel.getPasswordResetViewWidthAnchor()
        passwordResetViewWidthAnchor?.isActive = true
    }
    
    private func setupNavBar() {
        guard let image = UIImage(named: "NavLogo") else { return } //Your logo url here
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}
