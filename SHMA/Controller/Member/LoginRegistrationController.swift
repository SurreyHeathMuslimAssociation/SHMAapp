//
//  LoginRegistrationController.swift
//  SHMA
//
//  Created by Umar Yaqub on 09/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginRegistrationController: UIViewController {
    
    var loginRegistrationView: LoginRegistrationView!
    var loginRegistrationViewHeightOrBottomAnchor: NSLayoutConstraint?
    var loginRegistrationViewCenterYAnchor: NSLayoutConstraint?
    var loginRegistrationViewWidthAnchor: NSLayoutConstraint?
    var loginRegistrationViewTopAnchor: NSLayoutConstraint?
    var firebaseAuthManager: FirebaseAuthManager!
    var firebaseDatabaseManager: FirebaseDatabaseManager!
    // user details
    var family: [Family]?
    var memberName: String!
    var memberEmail: String!
    var memberPassword: String!
    var memberDob: String!
    var memberAddressLineOne: String!
    var memberAddressLineTwo: String!
    var memberTown: String!
    var memberPostcode: String!
    var memberMobileNo: String!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
        setupNavBar()
        setupView()
        setupFirebaseAuthAndDatabaseManagers()
        setupTermsAndConditionsNotification()
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
    
    private func setupView() {
        loginRegistrationView = LoginRegistrationView(traitCollection: traitCollection, didSelectLogin ?? false, didSelectExistingMemberRegistration ?? false, didSelectNewMemberRegistration ?? false)
        loginRegistrationView.delegate = self
        
        view.addSubview(loginRegistrationView)
        loginRegistrationView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: view.centerXAnchor)
        loginRegistrationViewTopAnchor = loginRegistrationView.loginRegistrationViewModel.getNewMemberRegistrationViewTopAnchor()
        loginRegistrationViewTopAnchor?.isActive = true
        
        setupLoginRegistrationViewWidthAndCenterYAnchors()
        setupLoginRegistrationViewHeightOrBottomAnchor()
    }
    
    private func setupTermsAndConditionsNotification() {
        let name = Notification.Name(rawValue: "register")
        NotificationCenter.default.addObserver(self, selector: #selector(termsAgreedHandleMemberRegisteration), name: name, object: nil)
    }
    
    private func setupLoginRegistrationViewWidthAndCenterYAnchors() {
        loginRegistrationViewWidthAnchor?.isActive = false
        loginRegistrationViewWidthAnchor = loginRegistrationView.loginRegistrationViewModel.getNewMemberRegistrationViewWidthAnchor()
        loginRegistrationViewWidthAnchor?.isActive = true
        
        loginRegistrationViewCenterYAnchor?.isActive = false
        loginRegistrationViewCenterYAnchor = loginRegistrationView.loginRegistrationViewModel.getNewMemberRegistrationViewCenterYAnchor()
        loginRegistrationViewCenterYAnchor?.isActive = true
        
    }
    
    func setupLoginRegistrationViewHeightOrBottomAnchor() {
        loginRegistrationViewHeightOrBottomAnchor?.isActive = false
        loginRegistrationViewHeightOrBottomAnchor = loginRegistrationView.loginRegistrationViewModel.getLoginRegistrationViewHeightOrBottomConstraitForEachTypeAndDevice()
        loginRegistrationViewHeightOrBottomAnchor?.isActive = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        loginRegistrationView.traitCollectionDidChange(traitCollection)
        setupLoginRegistrationViewWidthAndCenterYAnchors()
        setupLoginRegistrationViewHeightOrBottomAnchor()
    }    

    override func viewDidLayoutSubviews() {
        // change scrollview content size with ipad portrait/landscape mode
        loginRegistrationView.setScrollViewContentSizeForNewMemberLogin()
    }
    
    private func setupFirebaseAuthAndDatabaseManagers() {
        firebaseAuthManager = FirebaseAuthManager(session: Auth.auth())
        firebaseDatabaseManager = FirebaseDatabaseManager(session: Database.database())
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
