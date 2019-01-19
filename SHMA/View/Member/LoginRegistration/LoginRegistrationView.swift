//
//  LoginRegistrationView.swift
//  SHMA
//
//  Created by Umar Yaqub on 09/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

protocol LoginRegistrationViewDelegate: class {
    func didPressLoginRegister()
    func didSwitchToFamilyMembership()
}

class LoginRegistrationView: UIView {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    let membershipLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let shmaIdTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "SHMA ID"
        tf.keyboardType = .numberPad
        return tf
    }()
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        return tf
    }()
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.autocapitalizationType = .none
        tf.keyboardType = .emailAddress
        return tf
    }()
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        return tf
    }()
    let dobTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "D.O.B"
        return tf
    }()
    let addressLineOneTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Address Line 1"
        return tf
    }()
    let addressLineTwoTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Address Line 2"
        return tf
    }()
    let townTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Town"
        return tf
    }()
    let postcodeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Postcode"
        return tf
    }()
    let mobileNoTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Mobile No."
        tf.keyboardType = .numberPad
        return tf
    }()
    let shmaIdSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return view
    }()
    let emailSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return view
    }()
    let nameSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return view
    }()
    let passwordSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return view
    }()
    let dobSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return view
    }()
    let addressLineOneSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return view
    }()
    let addressLineTwoSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return view
    }()
    let townSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return view
    }()
    let postcodeSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        return view
    }()
    lazy var membershipSwitch: UISwitch = {
        let s = UISwitch()
        s.addTarget(self, action: #selector(handleMembershipSwitch), for: .valueChanged)
        return s
    }()
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.rgb(red: 0, green: 0, blue: 205), for: .normal)
        button.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    let activityIndicatorView: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView()
        iv.style = .gray
        return iv
    }()
    let coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        sv.showsHorizontalScrollIndicator = false
        sv.isUserInteractionEnabled = true
        sv.keyboardDismissMode = .onDrag
        sv.bounces = false
        sv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleKeyboard)))
        return sv
    }()
    
    var spouseChildTableView: UITableView!
    let cellId = "cellId"
    let addChildCellId = "addChildCellId"
    let header = ["Spouse", "Child"]
    var childRows = [Int]()
    var didSelectSpouseChildTextField = false
    var childCells: [SpouseChildCell]?
    
    weak var delegate: LoginRegistrationViewDelegate?
    var loginRegistrationViewModel: LoginRegistrationViewModel!
    var didSelectLogin: Bool?
    var didSelectExistingMemberRegistration: Bool?
    var didSelectNewMemberRegistration: Bool?
    
    /// height anchor refrences for modifying *loginViewContainer*
    var labelHeightAnchor: NSLayoutConstraint?
    var shmaIdTextFieldTopAnchor: NSLayoutConstraint?
    var shmaIdTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var dobTextFieldHeightAnchor: NSLayoutConstraint?
    var addressLineOneTextFieldHeightAnchor: NSLayoutConstraint?
    var addressLineTwoTextFieldHeightAnchor: NSLayoutConstraint?
    var townTextFieldHeightAnchor: NSLayoutConstraint?
    var postcodeTextFieldHeightAnchor: NSLayoutConstraint?
    var mobileTextFieldHeightAnchor: NSLayoutConstraint?
    var loginRegisterButtonHeightAnchor: NSLayoutConstraint?
    var loginRegisterButtonTopAnchor: NSLayoutConstraint?
    
    required init(traitCollection: UITraitCollection, _ didSelectLogin: Bool, _ didSelectExistingMemberRegistration: Bool, _ didSelectNewMemberRegistration: Bool) {
        super.init(frame: .zero)
        backgroundColor = UIColor(white: 0.9, alpha: 0.5)
        layer.cornerRadius = 5
        clipsToBounds = true
        
        self.didSelectLogin = didSelectLogin
        self.didSelectExistingMemberRegistration = didSelectExistingMemberRegistration
        self.didSelectNewMemberRegistration = didSelectNewMemberRegistration
        
        loginRegistrationViewModel = LoginRegistrationViewModel(traitCollection, loginRegistrationView: self, didSelectLogin, didSelectExistingMemberRegistration, didSelectNewMemberRegistration, mainLabel, membershipLabel, shmaIdTextField, nameTextField, emailTextField, passwordTextField, dobTextField, addressLineOneTextField, addressLineTwoTextField, townTextField, postcodeTextField, mobileNoTextField, loginRegisterButton, membershipSwitch, shmaIdSeperatorView, emailSeperatorView, nameSeperatorView, passwordSeperatorView, dobSeperatorView, addressLineOneSeperatorView, addressLineTwoSeperatorView, townSeperatorView, postcodeSeperatorView)
        
        setupView()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        loginRegistrationViewModel.traitCollection = traitCollection
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
