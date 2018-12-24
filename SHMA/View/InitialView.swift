//
//  InitialView.swift
//  SHMA
//
//  Created by Umar Yaqub on 22/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

protocol InitialViewDelegate: class {
    func didPressCorporate()
    func didPressMember()
}

class InitialView: UIView {
    
    var initialViewModel: InitialViewModel!
    var buttonStackView: UIStackView!
    weak var delegate: InitialViewDelegate?
    
    lazy var corporateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Corporate", for: .normal)
        button.setTitleColor(UIColor.rgb(red: 0, green: 0, blue: 205), for: .normal)
        button.backgroundColor = UIColor(white: 0.6, alpha: 0.5)
        button.addTarget(self, action: #selector(handleCorporate), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleCorporate() {
        delegate?.didPressCorporate()
    }
    
    let shmaLogoIV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "Logo")
        return iv
    }()
    
    lazy var memberButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Member", for: .normal)
        button.setTitleColor(UIColor.rgb(red: 0, green: 0, blue: 205), for: .normal)
        button.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        button.addTarget(self, action: #selector(handleMember), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleMember() {
        delegate?.didPressMember()
    }

    required init(traitCollection: UITraitCollection) {
        super.init(frame: .zero)
        
        buttonStackView = UIStackView(arrangedSubviews: [memberButton, corporateButton])
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        
        initialViewModel = InitialViewModel(traitCollection, buttonStackView, shmaLogoIV, view: self)
        
        buttonStackView.spacing = initialViewModel.getButtonCornerRadiusAndSpacing()
        corporateButton.titleLabel?.font = initialViewModel.getButtonFont()
        memberButton.titleLabel?.font = initialViewModel.getButtonFont()
        
        addSubview(buttonStackView)
        addSubview(shmaLogoIV)
        setupImageViewAndButtons()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        buttonStackView = UIStackView(arrangedSubviews: [memberButton, corporateButton])
//        buttonStackView.axis = .vertical
//        buttonStackView.spacing = 5
//        buttonStackView.distribution = .fillEqually
//        print(self.traitCollection.isIphonePortrait)
//        initialViewModel = InitialViewModel(super.traitCollection, buttonStackView, shmaLogoIV, view: self)
//
//        addSubview(buttonStackView)
//        addSubview(shmaLogoIV)
//        setupImageViewAndButtons()
//    }
    
    
    private func setupImageViewAndButtons() {
        shmaLogoIV.anchor(top: nil, left: nil, bottom: buttonStackView.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: initialViewModel.getSHMALogoImageViewWidth(), height: initialViewModel.getSHMALogoImageViewHeight(), centerYAnchor: nil, centerXAnchor: centerXAnchor)
        
        buttonStackView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: initialViewModel.getButtonStackViewHeight(), centerYAnchor: nil, centerXAnchor: centerXAnchor)
        buttonStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 45).isActive = true
        buttonStackView.widthAnchor.constraint(equalTo: shmaLogoIV.widthAnchor).isActive = true
        
        corporateButton.layer.cornerRadius = initialViewModel.getButtonCornerRadiusAndSpacing()
        memberButton.layer.cornerRadius = initialViewModel.getButtonCornerRadiusAndSpacing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
