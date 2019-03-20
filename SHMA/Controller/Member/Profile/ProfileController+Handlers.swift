//
//  ProfileController+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 02/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import FirebaseAuth

extension ProfileController {
    
    func fetchAssociationDetailsAndSetupMember() {
        firebaseDatabaseManager.fetchAssociationDetails { (association) in
            self.profileViewModel.association = association
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
