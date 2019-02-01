//
//  AddSpouseChildCell.swift
//  SHMA
//
//  Created by Umar Yaqub on 16/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

protocol AddSpouseChildCellDelegate: class {
    func didTapAddChild()
}

class AddSpouseChildCell: UITableViewCell, SpouseChildTableViewDelegate {
    
    weak var delegate: AddSpouseChildCellDelegate?
    
    lazy var addChildButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.rgb(red: 0, green: 0, blue: 205), for: .normal)
        button.setTitle("Add Child", for: .normal)
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(handleAddChild), for: .touchUpInside)
        return button
    }()
    @objc private func handleAddChild() {
        delegate?.didTapAddChild()
    }
    
    var loginRegisterViewModel: LoginRegistrationViewModel? {
        didSet {
            addChildButton.titleLabel?.font = loginRegisterViewModel?.getLoginRegisterButtonFontForEachDevice()
        }
    }
    
    func enableAddChildButton() {
        addChildButton.setTitle("Add Child", for: .normal)
        addChildButton.isEnabled = true
    }
    
    func disableAddChildButton() {
        addChildButton.setTitle("Maximum Children Added!", for: .normal)
        addChildButton.isEnabled = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(addChildButton)
        addChildButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 170, height: 50, centerYAnchor: centerYAnchor, centerXAnchor: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
