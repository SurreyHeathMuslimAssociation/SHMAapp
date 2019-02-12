//
//  SpouseChildCell.swift
//  SHMA
//
//  Created by Umar Yaqub on 16/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

protocol SpouseChildCellDelegate: class {
    func didSelectTextField()
    func didUnselectTextField()
}

class SpouseChildCell: UITableViewCell, UITextFieldDelegate {
    
    weak var delegate: SpouseChildCellDelegate?
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Full Name*"
        tf.borderStyle = .roundedRect
        return tf
    }()
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.keyboardType = .emailAddress
        tf.borderStyle = .roundedRect
        return tf
    }()
    let dobTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "D.O.B*"
        tf.keyboardType = .numberPad
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldBottomAnchor: NSLayoutConstraint?
    var dobTextFieldTopAnchor: NSLayoutConstraint?
    var dobTextFieldBottomAnchor: NSLayoutConstraint?
    var dobTextFieldHeightAnchor: NSLayoutConstraint?
    var dobTextFieldCenterYAnchor: NSLayoutConstraint?
    
    var loginRegistrationViewModel: LoginRegistrationViewModel? {
        didSet {
            nameTextField.font = loginRegistrationViewModel?.getTextFieldFontForEachDevice()
            emailTextField.font = loginRegistrationViewModel?.getTextFieldFontForEachDevice()
            dobTextField.font = loginRegistrationViewModel?.getTextFieldFontForEachDevice()
        }
    }
    
    var isChildCell: Bool? {
        didSet {
            // resetting constraints
            emailTextFieldHeightAnchor?.isActive = false
            emailTextFieldBottomAnchor?.isActive = false
            dobTextFieldHeightAnchor?.isActive = false
            dobTextFieldCenterYAnchor?.isActive = false
            dobTextFieldTopAnchor?.isActive = false
            dobTextFieldBottomAnchor?.isActive = false
            if isChildCell == true {
                childCellConstraints()
            } else {
                spouseCellConstraints()
            }
        }
    }
    
    private func spouseCellConstraints() {
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalToConstant: 40)
        emailTextFieldHeightAnchor?.isActive = true
        
        emailTextFieldBottomAnchor = emailTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        emailTextFieldBottomAnchor?.priority = UILayoutPriority(rawValue: 999)
        emailTextFieldBottomAnchor?.isActive = true
        
        dobTextFieldHeightAnchor = dobTextField.heightAnchor.constraint(equalToConstant: 40)
        dobTextFieldHeightAnchor?.isActive = true
        
        dobTextFieldCenterYAnchor = dobTextField.centerYAnchor.constraint(equalTo: centerYAnchor)
        dobTextFieldCenterYAnchor?.isActive = true
    }
    
    private func childCellConstraints() {
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalToConstant: 0)
        emailTextFieldHeightAnchor?.priority = UILayoutPriority(rawValue: 999)
        emailTextFieldHeightAnchor?.isActive = true
        
        emailTextFieldBottomAnchor = emailTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        emailTextFieldBottomAnchor?.priority = UILayoutPriority(rawValue: 999)
        emailTextFieldBottomAnchor?.isActive = true
        
        dobTextFieldTopAnchor = dobTextField.topAnchor.constraint(equalTo: topAnchor, constant: 3)
        dobTextFieldTopAnchor?.isActive = true
        
        dobTextFieldBottomAnchor = dobTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        dobTextFieldBottomAnchor?.priority = UILayoutPriority(rawValue: 999)
        dobTextFieldBottomAnchor?.isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(dobTextField)
        
        setupTextFields()
    }
   
    
    private func setupTextFields() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        dobTextField.delegate = self
        
         dobTextField.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 120, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        nameTextField.anchor(top: topAnchor, left: leftAnchor, bottom: emailTextField.topAnchor, right: dobTextField.leftAnchor, paddingTop: 3, paddingLeft: 10, paddingBottom: 3, paddingRight: 5, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        emailTextField.anchor(top: nil, left: nameTextField.leftAnchor, bottom: nil, right: nameTextField.rightAnchor, paddingTop: 3, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Format Date of Birth dd-MM-yyyy
        if textField == dobTextField {
            if let text = dobTextField.text {
                // check the chars length dd --> 2 at the same time calculate the dd-MM --> 5
                if (text.count == 2) || (text.count == 5) {
                    //Handle backspace being pressed
                    if !(string == "") {
                        // append
                        dobTextField.text = text + "/"
                    }
                }
                // check the condition not exceed 9 chars
                return !(text.count > 9 && (string.count) > range.length)
            } else {
                return true
            }
        } else {
            return true
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didSelectTextField()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didUnselectTextField()
        endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didUnselectTextField()
        endEditing(true)
        return true
    }
}
