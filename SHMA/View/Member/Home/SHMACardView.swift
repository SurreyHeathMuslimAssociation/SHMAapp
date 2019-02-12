//
//  SHMACardView.swift
//  SHMA
//
//  Created by Umar Yaqub on 22/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class SHMACardView: UIView {
    
    let shmaLogoIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "CardLogo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let logoUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    let shmaLogoTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .yellow
        return label
    }()
    let membershipNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    let contactInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    let dateAndTimeLabel: UILabel = {
        let label = UILabel()
        //label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    let activityIndicatorView: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView(style: .whiteLarge)
        return iv
    }()
    
    var shmaCardViewModel: SHMACardViewModel!
    
    var association: Association? {
        didSet {
            shmaCardViewModel.association = association
            shmaLogoTextLabel.attributedText = shmaCardViewModel.getShmaLogoTextLabelText()
            contactInfoLabel.attributedText = shmaCardViewModel.getShmaContactInfoLabelText()
            dateAndTimeLabel.attributedText = shmaCardViewModel.getDateAndTimeLabelText()
        }
    }
    
    var member: Member? {
        didSet {
            shmaCardViewModel.member = member
            membershipNumberLabel.attributedText = shmaCardViewModel.getShmaMemberMembershipNumberText()
        }
    }
    
    required init(traitCollection: UITraitCollection, _ navBarHeight: CGFloat, _ tabBarHeight: CGFloat) {
        super.init(frame: .zero)
        
        backgroundColor = .black
        layer.cornerRadius = 5
        clipsToBounds = true
        
        addSubview(shmaLogoIV)
        addSubview(logoUnderLine)
        addSubview(shmaLogoTextLabel)
        addSubview(membershipNumberLabel)
        addSubview(contactInfoLabel)
        addSubview(dateAndTimeLabel)
        
        shmaCardViewModel = SHMACardViewModel(traitCollection, self, tabBarHeight, navBarHeight)
        
        setupLogoTextAndIV()
        setupMembershipLabelAndNumber()
        setupContactAndDateAndTimeLabel()
    }
    
    private func setupLogoTextAndIV() {
        shmaLogoIV.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: shmaCardViewModel.getShmaCardLogoWidth(), height: shmaCardViewModel.getShmaCardLogoHeight(), centerYAnchor: nil, centerXAnchor: nil)
        
        logoUnderLine.anchor(top: shmaLogoIV.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 7, paddingLeft: 12, paddingBottom: 0, paddingRight: 12, width: 0, height: 1.7, centerYAnchor: nil, centerXAnchor: nil)
        
        shmaLogoTextLabel.anchor(top: topAnchor, left: shmaLogoIV.rightAnchor, bottom: logoUnderLine.topAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 11, paddingBottom: -10, paddingRight: 20, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
    }
    
    private func setupMembershipLabelAndNumber() {
        membershipNumberLabel.anchor(top: nil, left: leftAnchor, bottom: contactInfoLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: shmaCardViewModel.getMembershipNumberLabelHeight(), centerYAnchor: nil, centerXAnchor: nil)

    }
    
    private func setupContactAndDateAndTimeLabel() {
        contactInfoLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: dateAndTimeLabel.leftAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: shmaCardViewModel.getContactInfoLabelHeight(), centerYAnchor: nil, centerXAnchor: nil)
        
        dateAndTimeLabel.anchor(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 5, width: shmaCardViewModel.getDateAndTimeLabelWidth(), height: shmaCardViewModel.getDateAndTimeLabelHeight(), centerYAnchor: nil, centerXAnchor: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        shmaCardViewModel.traitCollection = traitCollection
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
