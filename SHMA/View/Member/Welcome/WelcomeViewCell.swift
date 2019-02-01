//
//  WelcomeViewCell.swift
//  SHMA
//
//  Created by Umar Yaqub on 28/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

protocol WelcomeViewCellDelegate: class {
    func handleLoginReturn()
}

class WelcomeViewCell: UICollectionViewCell {
    
    weak var delegate: WelcomeViewCellDelegate?
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var returnToLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Return to Login", for: .normal)
        button.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        button.setTitleColor(UIColor.rgb(red: 0, green: 0, blue: 205), for: .normal)
        button.addTarget(self, action: #selector(handleLoginReturn), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    @objc private func handleLoginReturn() {
        delegate?.handleLoginReturn()
    }
    
    var pageViewModel: PageViewModel? {
        didSet {
            guard let pageViewModel = pageViewModel else { return }
            mainLabel.attributedText = pageViewModel.getMainLabelAttributedText()
            returnToLoginButton.titleLabel?.font = pageViewModel.getButtonFontForEachDevice()
            returnToLoginButton.layer.cornerRadius = pageViewModel.getButtonCornerRadiusForEachDevice()
            returnToLoginButton.widthAnchor.constraint(equalToConstant: pageViewModel.getButtonWidthForEachDevice()).isActive = true
            returnToLoginButton.heightAnchor.constraint(equalToConstant: pageViewModel.getButtonHeightForEachDevice()).isActive = true
            returnToLoginButton.isHidden = pageViewModel.getButtonIsHiddenStatus()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(mainLabel)
        addSubview(returnToLoginButton)
        
        mainLabel.anchor(top: topAnchor, left: leftAnchor, bottom: returnToLoginButton.topAnchor, right: rightAnchor, paddingTop: 30, paddingLeft: 10, paddingBottom: 15, paddingRight: 10, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        returnToLoginButton.anchor(top: nil, left: nil, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: centerXAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
