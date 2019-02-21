//
//  ProfileFooter.swift
//  SHMA
//
//  Created by Umar Yaqub on 04/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

protocol ProfileFooterDelegate: class {
    func didTapGetDirections()
}
class ProfileFooter: UITableViewHeaderFooterView {
    
    weak var delegate: ProfileFooterDelegate?
    
    let infoTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.dataDetectorTypes = .all
        return tv
    }()
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    lazy var getDirectionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Directions", for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(handleGetDirections), for: .touchUpInside)
        return button
    }()
    @objc private func handleGetDirections() {
        delegate?.didTapGetDirections()
    }
    
    var profileViewModel: ProfileViewModel? {
        didSet {
            guard let profileViewModel = profileViewModel else { return }
            infoTextView.attributedText = profileViewModel.getFooterTextViewText()
            infoTextView.textAlignment = .center
            infoTextViewTopAnchor = infoTextView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: profileViewModel.getInfoTextViewTopPadding())
            infoTextViewTopAnchor?.isActive = true
        }
    }
    
    var businessViewModel: BusinessViewModel? {
        didSet {
            getDirectionsButton.isHidden = false
        }
    }
    
    var infoTextViewTopAnchor: NSLayoutConstraint?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addSubview(containerView)
        containerView.addSubview(infoTextView)
        containerView.addSubview(getDirectionsButton)
        
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        infoTextView.anchor(top: nil, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        getDirectionsButton.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 40, centerYAnchor: containerView.centerYAnchor, centerXAnchor: containerView.centerXAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
