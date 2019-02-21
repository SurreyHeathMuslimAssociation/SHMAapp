//
//  PrayerTimesCell.swift
//  SHMA
//
//  Created by Umar Yaqub on 18/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class PrayerTimesCell: UICollectionViewCell {
    
    let prayerTitlesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        //label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let prayerTimesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    let activityIndicatorView: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView(style: .gray)
        iv.startAnimating()
        return iv
    }()
    
    var prayerTimesViewModel: PrayerTimesViewModel? {
        didSet {
            prayerTimesLabel.font = prayerTimesViewModel?.getPrayerTimesLabelFontForEachDevice()
            prayerTitlesLabel.font = prayerTimesViewModel?.getPrayerTitlesLabelFontForEachDevice()
            prayerTimesLabel.textColor = prayerTimesViewModel?.getLabelTextColour()
        }
    }
    
    var detail: String? {
        didSet {
            prayerTimesLabel.text = detail
            activityIndicatorView.stopAnimating()
        }
    }
    var label: String? {
        didSet {
            prayerTitlesLabel.text = label
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(prayerTimesLabel)
        addSubview(prayerTitlesLabel)
        addSubview(activityIndicatorView)
        
        prayerTitlesLabel.anchor(top: topAnchor, left: leftAnchor, bottom: prayerTimesLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        prayerTimesLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 40, centerYAnchor: nil, centerXAnchor: nil)
        
        activityIndicatorView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: prayerTimesLabel.centerYAnchor, centerXAnchor: prayerTimesLabel.centerXAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
