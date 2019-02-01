//
//  PasswordResetController+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 21/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import FirebaseAuth

extension PasswordResetController: PasswordResetViewDelegate, UITextFieldDelegate {
    
    func didTapPasswordReset(_ email: String) {
        // send reset email
        firebaseAuthManager.sendPasswordReset(with: email) { (err) in
            if let err = err {
                let code = AuthErrorCode(rawValue: err._code)
                self.showNotification(with: "Error", text: code?.errorMessage ?? "", .danger)
                return
            }
            self.showNotification(with: "Success", text: "Email sent to \(email), please check you email.", .success)
        }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
