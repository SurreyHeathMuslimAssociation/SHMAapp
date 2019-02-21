//
//  FuneralContactsCell.swift
//  SHMA
//
//  Created by Umar Yaqub on 17/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class FuneralContactsCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    let phoneNoTextView: UITextView = {
        let tv = UITextView()
        tv.dataDetectorTypes = [.link, .phoneNumber]
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    var funeralContactViewModel: FuneralContactViewModel? {
        didSet {
            nameLabel.attributedText = funeralContactViewModel?.getNameAttributedString()
            phoneNoTextView.attributedText = funeralContactViewModel?.getPhoneNoAttributedString()
            phoneNoTextView.textAlignment = .center
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(phoneNoTextView)
        
        nameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: phoneNoTextView.topAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        phoneNoTextView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 50, centerYAnchor: nil, centerXAnchor: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
