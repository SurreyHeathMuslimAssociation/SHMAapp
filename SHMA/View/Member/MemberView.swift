//
//  MemberView.swift
//  SHMA
//
//  Created by Umar Yaqub on 08/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

protocol MemberViewDelegate: class {
    func didPressLogin()
    func didPressExistingRegistration()
    func didPressNewRegistration()
}

class  MemberView: UIView {
    
    var memberViewModel: MemberViewModel!
    weak var delegate: MemberViewDelegate?
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Please select your preferred destination."
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        button.setTitleColor(UIColor.rgb(red: 0, green: 0, blue: 205), for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    @objc private func handleLogin() {
        delegate?.didPressLogin()
    }
    
    lazy var existingMemberRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Existing Member Registration", for: .normal)
        button.backgroundColor = UIColor(white: 0.7, alpha: 0.5)
        button.setTitleColor(UIColor.rgb(red: 0, green: 0, blue: 205), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExistingMemberRegistration), for: .touchUpInside)
        return button
    }()
    @objc private func handleExistingMemberRegistration() {
        delegate?.didPressExistingRegistration()
    }
    
    lazy var newMemberRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Member Registration", for: .normal)
        button.backgroundColor = UIColor(white: 0.6, alpha: 0.5)
        button.setTitleColor(UIColor.rgb(red: 0, green: 0, blue: 205), for: .normal)
        button.addTarget(self, action: #selector(handleNewMemberRegistration), for: .touchUpInside)
        return button
    }()
    @objc private func handleNewMemberRegistration() {
        delegate?.didPressNewRegistration()
    }
    
    required init(traitCollection: UITraitCollection) {
        super.init(frame: .zero)
        backgroundColor = .white
        
        memberViewModel = MemberViewModel(traitCollection, self)

        setupLabelAndButtons()
    }
    
    private func setupLabelAndButtons() {
        let buttonStackView = UIStackView(arrangedSubviews: [loginButton, existingMemberRegistrationButton, newMemberRegistrationButton])
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = memberViewModel.getButtonCornerRadiusAndSpacingForEachDevice()
        
        addSubview(buttonStackView)
        addSubview(label)
        
        buttonStackView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: memberViewModel.getButtonStackViewWidthForEachDevice(), height: memberViewModel.getButtonStackViewHeightForEachDevice(), centerYAnchor: centerYAnchor, centerXAnchor: centerXAnchor)
        
        loginButton.layer.cornerRadius = memberViewModel.getButtonCornerRadiusAndSpacingForEachDevice()
        existingMemberRegistrationButton.layer.cornerRadius = memberViewModel.getButtonCornerRadiusAndSpacingForEachDevice()
        newMemberRegistrationButton.layer.cornerRadius = memberViewModel.getButtonCornerRadiusAndSpacingForEachDevice()
        
        loginButton.titleLabel?.font = memberViewModel.getButtonFontForEachDevice()
        existingMemberRegistrationButton.titleLabel?.font = memberViewModel.getButtonFontForEachDevice()
        newMemberRegistrationButton.titleLabel?.font = memberViewModel.getButtonFontForEachDevice()
        
        label.anchor(top: nil, left: leftAnchor, bottom: buttonStackView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 25, paddingRight: 0, width: 0, height: 40, centerYAnchor: nil, centerXAnchor: nil)
        
        label.font = memberViewModel.getMainLabelFontForEachDevice()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        memberViewModel.traitCollection = traitCollection
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
