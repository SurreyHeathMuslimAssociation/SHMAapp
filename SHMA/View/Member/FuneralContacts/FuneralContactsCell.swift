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
        tv.backgroundColor = .clear
        return tv
    }()
    let funeralContactImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "FuneralArch")
        return iv
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
        
        addSubview(funeralContactImageView)
        funeralContactImageView.addSubview(nameLabel)
         funeralContactImageView.addSubview(phoneNoTextView)
        
        nameLabel.anchor(top: topAnchor, left: funeralContactImageView.leftAnchor, bottom: phoneNoTextView.topAnchor, right: funeralContactImageView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        funeralContactImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        phoneNoTextView.anchor(top: nil, left: funeralContactImageView.leftAnchor, bottom: bottomAnchor, right: funeralContactImageView.rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 50, centerYAnchor: nil, centerXAnchor: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
