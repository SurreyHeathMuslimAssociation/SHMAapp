//
//  PasswordResetViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 21/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class PasswordResetViewModel {
    
    let traitCollection: UITraitCollection
    let passwordResetView: UIView
    let mainLabel: UILabel
    let emailTextField: UITextField
    let resetPasswordButton: UIButton
    
    init(_ traitCollection: UITraitCollection, _ passwordResetView: UIView, _ mainLabel: UILabel, _ emailTextField: UITextField, _ resetPasswordButton: UIButton) {
        self.traitCollection = traitCollection
        self.passwordResetView = passwordResetView
        self.mainLabel = mainLabel
        self.emailTextField = emailTextField
        self.resetPasswordButton = resetPasswordButton
    }
    
    func getMainLabelAttributedTextForEachDevice() -> NSAttributedString {
        let title = "Forgotten you Password?"
        let text = "Please provide your email address."
        return getLabelAttributedString(title, text)
    }
    private func getLabelAttributedString(_ title: String, _ text: String) -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString.getAttributedString(title: title, titleFont: UIFont.boldSystemFont(ofSize: 26), linesOfSpace: "\n\n", spaceFont: 4, message: text, messageFont: UIFont.systemFont(ofSize: 20))
        } else {
            return NSAttributedString.getAttributedString(title: title, titleFont: UIFont.boldSystemFont(ofSize: 20), linesOfSpace: "\n\n", spaceFont: 4, message: text, messageFont: UIFont.systemFont(ofSize: 14))
        }
    }
    
    func getPasswordResetViewHeightConstraintForEachDevice() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return passwordResetView.heightAnchor.constraint(equalToConstant: 220)
        } else {
            return passwordResetView.heightAnchor.constraint(equalToConstant: 170)
        }
    }
    
    func getMainLabelHeightConstraintForEachDevice() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return mainLabel.heightAnchor.constraint(equalToConstant: 100)
        } else {
            return mainLabel.heightAnchor.constraint(equalToConstant: 80)
        }
    }

    func getEmailTextFieldHeightConstraintForEachDevice() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return emailTextField.heightAnchor.constraint(equalToConstant: 60)
        } else {
            return emailTextField.heightAnchor.constraint(equalToConstant: 45)
        }
    }
    
    func getResetPasswordButtonHeightConstraintForEachDevice() -> NSLayoutConstraint {
        if traitCollection.isIpad {
            return resetPasswordButton.heightAnchor.constraint(equalToConstant: 60)
        } else {
            return resetPasswordButton.heightAnchor.constraint(equalToConstant: 45)
        }
    }
    
    func getButtonAndTextFeildFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    func getPasswordResetViewWidthAnchor() -> NSLayoutConstraint {
        guard let superview = passwordResetView.superview else {
            return NSLayoutConstraint()
        }
        if traitCollection.isIphonePortrait {
            return passwordResetView.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.95)
        } else {
            return passwordResetView.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.7)
        }
    }
    
    // alert
    func getAlertViewTitleForEachDevice(_ title: String) -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString.getAttributedStringUsing(text: title, font: 20, spaceFont: 4, isBold: true)
        } else {
            return NSAttributedString.getAttributedStringUsing(text: title, font: 16, spaceFont: nil, isBold: true)
        }
    }
    
    func getAlertViewTextForEachDevice(_ error: String) -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString.getAttributedStringUsing(text: error, font: 16, spaceFont: nil, isBold: false)
        } else {
            return NSAttributedString.getAttributedStringUsing(text: error, font: 13, spaceFont: nil, isBold: false)
        }
    }
}
