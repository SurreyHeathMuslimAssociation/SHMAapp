//
//  PrayerTimesView.swift
//  SHMA
//
//  Created by Umar Yaqub on 18/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class PrayerTimesView: UICollectionView {
    
    let cellId = "cellId"
    var prayerTitles: [String]!
    var prayerTimes: [String]!
    var prayerTimesViewModel: PrayerTimesViewModel!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        bounces = false
        
        // set delegate and datasource
        delegate = self
        dataSource = self
        
        // register cell
        register(PrayerTimesCell.self, forCellWithReuseIdentifier: cellId)
        
        prayerTimesViewModel = PrayerTimesViewModel()
        
        prayerTitles = [String]()
        prayerTimes = [String]()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        prayerTimesViewModel.traitCollection = traitCollection
    }
}
