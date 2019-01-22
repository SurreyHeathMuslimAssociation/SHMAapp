//
//  PasswordResetView.swift
//  SHMA
//
//  Created by Umar Yaqub on 21/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

protocol PasswordResetViewDelegate: class {
    func didTapPasswordReset(_ email: String)
}

class PasswordResetView: UIView {
    
    weak var delegate: PasswordResetViewDelegate?
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.autocapitalizationType = .none
        tf.keyboardType = .emailAddress
        return tf
    }()
    lazy var resetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.rgb(red: 0, green: 0, blue: 205), for: .normal)
        button.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        button.setTitle("Reset Password", for: .normal)
        button.addTarget(self, action: #selector(handlePasswordReset), for: .touchUpInside)
        return button
    }()
    @objc private func handlePasswordReset() {
        let email = emailTextField.text ?? ""
        delegate?.didTapPasswordReset(email)
        emailTextField.text = nil
    }
    
    var passwordResetViewModel: PasswordResetViewModel!
    var mainLabelHeightAnchor: NSLayoutConstraint?
    var emailtextFieldHeightAnchor: NSLayoutConstraint?
    var resetPasswordButtonHeightAnchor: NSLayoutConstraint?
    
    required init(traitCollection: UITraitCollection) {
        super.init(frame: .zero)
        backgroundColor = UIColor(white: 0.9, alpha: 0.5)
        layer.cornerRadius = 5
        clipsToBounds = true
        
        passwordResetViewModel = PasswordResetViewModel(traitCollection, self, mainLabel, emailTextField, resetPasswordButton)
        
        addSubview(mainLabel)
        addSubview(emailTextField)
        addSubview(resetPasswordButton)
        
        setupView()
    }
    
    private func setupView() {
        mainLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        mainLabelHeightAnchor = passwordResetViewModel.getMainLabelHeightConstraintForEachDevice()
        mainLabelHeightAnchor?.isActive = true
        mainLabel.attributedText = passwordResetViewModel.getMainLabelAttributedTextForEachDevice()
        
        emailTextField.anchor(top: mainLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        emailtextFieldHeightAnchor = passwordResetViewModel.getEmailTextFieldHeightConstraintForEachDevice()
        emailtextFieldHeightAnchor?.isActive = true
        emailTextField.font = passwordResetViewModel.getButtonAndTextFeildFontForEachDevice()
        
        resetPasswordButton.anchor(top: emailTextField.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        resetPasswordButtonHeightAnchor = passwordResetViewModel.getResetPasswordButtonHeightConstraintForEachDevice()
        resetPasswordButtonHeightAnchor?.isActive = true
        resetPasswordButton.titleLabel?.font = passwordResetViewModel.getButtonAndTextFeildFontForEachDevice()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
