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
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView()
        iv.style = .gray
        return iv
    }()
    
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
    var memberCounty: String!
    var memberPostcode: String!
    var memberMobileNo: String!
    var membershipType: String!
    var memberStatus: String!
    var wasCellLeftEmpty = false
    var wasChild19 = false
    
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
        guard let image = UIImage(named: "NavLogo") else { return } //Your logo url here
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    func setupView() {
        loginRegistrationView = LoginRegistrationView(traitCollection: traitCollection, didSelectLogin ?? false, didSelectExistingMemberRegistration ?? false, didSelectNewMemberRegistration ?? false)
        loginRegistrationView.delegate = self
        
        view.addSubview(loginRegistrationView)
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: view.centerYAnchor, centerXAnchor: view.centerXAnchor)
        
        loginRegistrationView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: view.centerXAnchor)
        loginRegistrationViewTopAnchor = loginRegistrationView.loginRegistrationViewModel.getNewMemberRegistrationViewTopAnchor()
        loginRegistrationViewTopAnchor?.isActive = true
        
        setupLoginRegistrationViewWidthAndCenterYAnchors()
        setupLoginRegistrationViewHeightOrBottomAnchor()
    }
    
    private func setupTermsAndConditionsNotification() {
        let acceptedNotification = Notification.Name(rawValue: "register")
        NotificationCenter.default.addObserver(self, selector: #selector(termsAgreedHandleMemberRegisteration), name: acceptedNotification, object: nil)
        
        let rejectedNotification = Notification.Name(rawValue: "registerationCancelled")
        NotificationCenter.default.addObserver(self, selector: #selector(termsDisagreed), name: rejectedNotification, object: nil)
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
