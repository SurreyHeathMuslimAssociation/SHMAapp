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
    let businessNameAndDiscountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let activityIndicatorView: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView(style: .gray)
        return iv
    }()
    
    var businessViewModel: BusinessViewModel? {
        didSet {
            businessNameAndDiscountLabel.attributedText = businessViewModel?.getBusinessNameAttributedText()
            guard let urlString = businessViewModel?.business?.iconUrl else { return }
            businessImageView.getImageFromFirebase(using: urlString, indicator: activityIndicatorView)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(businessImageView)
        addSubview(businessNameAndDiscountLabel)
        addSubview(activityIndicatorView)
        
        businessImageView.anchor(top: topAnchor, left: leftAnchor, bottom: businessNameAndDiscountLabel.topAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: centerXAnchor)
        
        businessNameAndDiscountLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 3, paddingBottom: 3, paddingRight: 3, width: 0, height: 45, centerYAnchor: nil, centerXAnchor: nil)
        
        activityIndicatorView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: businessImageView.centerYAnchor, centerXAnchor: businessImageView.centerXAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
