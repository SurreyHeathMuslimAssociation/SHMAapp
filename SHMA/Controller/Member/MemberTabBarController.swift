//
//  MemberTabBarController.swift
//  SHMA
//
//  Created by Umar Yaqub on 22/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MemberTabBarController: UITabBarController {
    
    var firebaseDatabaseManager: FirebaseDatabaseManager!
    var homeNavController: UINavigationController!
    var profileNavController: UINavigationController!
    var businessNavController: UINavigationController!
    var funeralContactsNavController: UINavigationController!
    var isNavAndTabBarHidden: Bool?
    var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        firebaseDatabaseManager = FirebaseDatabaseManager(session: Database.database())
        
        activityIndicatorView = UIActivityIndicatorView(style: .gray)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: view.centerYAnchor, centerXAnchor: view.centerXAnchor)
        
        fetchMemberDetails()
    }
    
    private func fetchMemberDetails() {
        guard let currentUser = Auth.auth().currentUser else { return }
        activityIndicatorView.startAnimating()
        firebaseDatabaseManager.fetchMemberDetails(currentUser.uid) { (member) in
            if member.status == "Approved", currentUser.isEmailVerified {
                let homeController = HomeController()
                homeController.member = member
                self.homeNavController = UINavigationController(rootViewController: homeController)
            } else {
                let welcomeController = WelcomeController()
                welcomeController.member = member
                self.homeNavController = UINavigationController(rootViewController: welcomeController)
                self.tabBar.isHidden = self.isNavAndTabBarHidden ?? false
                self.homeNavController.navigationBar.isHidden = self.isNavAndTabBarHidden ?? false
            }
            self.homeNavController.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "Home"), selectedImage: #imageLiteral(resourceName: "Home"))
            self.setupTabBar(member)
        }
    }
    
    private func setupTabBar(_ member: Member) {
        let profileController = ProfileController(style: .grouped)
        profileController.member = member
        self.profileNavController = UINavigationController(rootViewController: profileController)
        self.profileNavController.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "Profile"), selectedImage: #imageLiteral(resourceName: "Profile"))
        
        let businessController = BusinessController()
        businessController.isBusinessDetailAvailable = true
        self.businessNavController = UINavigationController(rootViewController: businessController)
        self.businessNavController.tabBarItem = UITabBarItem(title: "Business", image: #imageLiteral(resourceName: "Business"), selectedImage: #imageLiteral(resourceName: "Business"))
        
        let funeralController = FuneralContactsController()
        self.funeralContactsNavController = UINavigationController(rootViewController: funeralController)
        self.funeralContactsNavController.tabBarItem = UITabBarItem(title: "Funeral", image: #imageLiteral(resourceName: "Funeral"), selectedImage: #imageLiteral(resourceName: "Funeral"))
        
        self.viewControllers = [self.homeNavController, self.businessNavController, self.funeralContactsNavController, self.profileNavController]
        self.activityIndicatorView.stopAnimating()
    }
}
