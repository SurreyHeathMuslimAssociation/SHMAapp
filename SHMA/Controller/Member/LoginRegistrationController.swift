//
//  LoginRegistrationController.swift
//  SHMA
//
//  Created by Umar Yaqub on 09/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class LoginRegistrationController: UIViewController {
    
    var loginRegistrationView: LoginRegistrationView!
    var loginRegistrationViewHeightAnchor: NSLayoutConstraint?
    
    var didSelectLogin: Bool? {
        didSet {
            navigationItem.title = "Login"
        }
    }
    var didSelectExistingMemberRegistration: Bool? {
        didSet {
            navigationItem.title = "Existing Member Registration"
        }
    }
    var didSelectNewMemberRegistration: Bool? {
        didSet {
            navigationItem.title = "New Member Registration"
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        sv.keyboardDismissMode = .onDrag
        sv.contentSize = CGSize(width: view.frame.width, height: UIScreen.main.bounds.height+loginRegistrationView.frame.height)
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
        setupView()
    }
    
    private func setupView() {
        loginRegistrationView = LoginRegistrationView(traitCollection: traitCollection, didSelectLogin ?? false, didSelectExistingMemberRegistration ?? false, didSelectNewMemberRegistration ?? false)
        loginRegistrationView.delegate = self
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        scrollView.addSubview(loginRegistrationView)
        loginRegistrationView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, centerYAnchor: view.centerYAnchor, centerXAnchor: nil)
        
        setupLoginRegistrationViewHeight()
    }
    
    private func setupLoginRegistrationViewHeight() {
        loginRegistrationViewHeightAnchor?.isActive = false
        loginRegistrationViewHeightAnchor = loginRegistrationView.loginRegistrationViewModel.getLoginRegistrationViewHeightConstraitForEachTypeAndDevice()
        loginRegistrationViewHeightAnchor?.isActive = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        loginRegistrationView.traitCollectionDidChange(traitCollection)
        setupLoginRegistrationViewHeight()
    }
}
