//
//  WelcomeController.swift
//  SHMA
//
//  Created by Umar Yaqub on 23/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomeController: UIViewController, WelcomeViewDelegate {
    
    var member: Member!
    var welcomeView: WelcomeView!
    var firebaseAuthManager: FirebaseAuthManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Welcome"
        
        firebaseAuthManager = FirebaseAuthManager(session: Auth.auth())
        
        let isNavBarHidden = navigationController?.navigationBar.isHidden ?? false
        welcomeView = WelcomeView(traitCollection: traitCollection, member, isNavBarHidden)
        welcomeView.delegate = self
        view.addSubview(welcomeView)
        welcomeView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        navigationController?.navigationBar.titleTextAttributes = welcomeView.welcomeViewModel.getNavigationBarTitleTextAttributes()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // ensures collection view scrolls correctly page to page in landscape
        let offset = welcomeView.collectionView.contentOffset
        let width = welcomeView.collectionView.bounds.size.width
        
        let index = round(offset.x / width)
        let newOffset = CGPoint(x: index * size.width, y: offset.y)
        
        welcomeView.collectionView.setContentOffset(newOffset, animated: false)
        coordinator.animate(alongsideTransition: { (context) in
            self.welcomeView.collectionView.setContentOffset(newOffset, animated: false)
        })
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let flowLayout = welcomeView.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    func sendUserToLogin() {
        dismiss(animated: true, completion: nil)
        if let presentingVC = presentingViewController as? UINavigationController {
            presentingVC.popViewController(animated: true)
            let loginController = LoginRegistrationController()
            loginController.didSelectLogin = true
            presentingVC.pushViewController(loginController, animated: true)
            
        }
    }
}
