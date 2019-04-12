//
//  BusinessDetailHeader.swift
//  SHMA
//
//  Created by Umar Yaqub on 11/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class BusinessDetailHeader: UITableViewHeaderFooterView {
    
    let businessImageView: ImageClient = {
        let iv = ImageClient()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let activityIndicatorView: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView(style: .gray)
        return iv
    }()
    let discountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.isHidden = true
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .red
        label.textColor = .white
        return label
    }()
    
    var businessViewModel: BusinessViewModel? {
        didSet {
            guard let iconUrl = businessViewModel?.business?.iconUrl else { return }
            businessImageView.getImageFromFirebase(using: iconUrl, indicator: activityIndicatorView)
            discountLabel.attributedText = businessViewModel?.getDiscountLabelAttributedString()
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(businessImageView)
        addSubview(activityIndicatorView)
        addSubview(discountLabel)
        
        businessImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        activityIndicatorView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: centerYAnchor, centerXAnchor: centerXAnchor)
        
        discountLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
