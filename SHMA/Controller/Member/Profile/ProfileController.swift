//
//  ProfileController.swift
//  SHMA
//
//  Created by Umar Yaqub on 22/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseAuth
import NotificationBannerSwift

class ProfileController: UIViewController {
    
    var firebaseAuthManager: FirebaseAuthManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        firebaseAuthManager = FirebaseAuthManager(session: Auth.auth())
        setupLogOutButton()
    }
    
    private func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogOut(sender:)))
    }
    @objc func handleLogOut(sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "LogOut", message: "Are you sure?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            self.firebaseAuthManager.signOut(completion: { (success, err) in
                if let err = err {
                    let code = AuthErrorCode(rawValue: err._code)
                    self.showNotification(with: "Error", text: code?.errorMessage ?? "", .danger)
                    return
                }
                self.dismissTabBar()
            })
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // for ipad
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.barButtonItem = sender
        }
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func dismissTabBar() {
        dismiss(animated: true, completion: nil)
        tabBarController?.view.removeFromSuperview()
        // send to first vc
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: InitialController())
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        
    }
    
    private func showNotification(with title: String, text: String, _ bannerStyle: BannerStyle) {
        let errorIv = UIImageView(image: UIImage(named: "Error"))
        let successIv = UIImageView(image: UIImage(named: "Success"))
        var banner: NotificationBanner!
        if bannerStyle == .danger {
            banner = NotificationBanner(title: title, subtitle: text, leftView: nil, rightView: errorIv, style: bannerStyle, colors: nil)
        } else {
            banner = NotificationBanner(title: title, subtitle: text, leftView: successIv, rightView: nil, style: bannerStyle, colors: nil)
        }
        banner.show()
    }
}
