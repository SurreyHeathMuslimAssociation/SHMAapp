//
//  PrayerTimesView+Datasource.swift
//  SHMA
//
//  Created by Umar Yaqub on 18/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension PrayerTimesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prayerTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PrayerTimesCell
        cell.prayerTimesViewModel = prayerTimesViewModel
        cell.label = prayerTitles[indexPath.item]
        if prayerTimes.isEmpty == false {
            cell.detail = prayerTimes[indexPath.item]
        }
        return cell
    }
}
