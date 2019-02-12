//
//  BusinessCell.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class BusinessCell: UICollectionViewCell {
    
    let businessImageView: ImageClient = {
        let iv = ImageClient()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let businessNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    let activityIndicatorView: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView(style: .gray)
        return iv
    }()
    
    var businessViewModel: BusinessViewModel? {
        didSet {
            businessNameLabel.attributedText = businessViewModel?.getBusinessNameAttributedText()
            guard let urlString = businessViewModel?.business?.iconUrl else { return }
            businessImageView.getImageFromFirebase(using: urlString, indicator: activityIndicatorView)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(businessImageView)
        addSubview(businessNameLabel)
        addSubview(activityIndicatorView)
        
        businessImageView.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: centerXAnchor)
        businessImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
        businessImageView.heightAnchor.constraint(equalTo: businessImageView.widthAnchor, multiplier: 1).isActive = true
        
        businessNameLabel.anchor(top: businessImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        activityIndicatorView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: businessImageView.centerYAnchor, centerXAnchor: businessImageView.centerXAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
