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
            infoTextViewBottomAnchor = infoTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
            infoTextViewBottomAnchor?.isActive = true
            getDirectionsButtonTopAnchor?.isActive = false
        }
    }
    
    var businessViewModel: BusinessViewModel? {
        didSet {
            getDirectionsButton.isHidden = false
            infoTextViewBottomAnchor?.isActive = false
            getDirectionsButtonTopAnchor = getDirectionsButton.topAnchor.constraint(equalTo: topAnchor, constant: 5)
            getDirectionsButtonTopAnchor?.isActive = true
        }
    }
    
    var infoTextViewBottomAnchor: NSLayoutConstraint?
    var getDirectionsButtonTopAnchor: NSLayoutConstraint?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addSubview(containerView)
        containerView.addSubview(infoTextView)
        containerView.addSubview(getDirectionsButton)
        
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        infoTextView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        getDirectionsButton.anchor(top: nil, left: nil, bottom: containerView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 0, centerYAnchor: nil, centerXAnchor: containerView.centerXAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
