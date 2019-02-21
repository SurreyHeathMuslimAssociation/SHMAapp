//
//  PrayerTimesView+Delegate.swift
//  SHMA
//
//  Created by Umar Yaqub on 18/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension PrayerTimesView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if traitCollection.isIpad {
            let width = (frame.width - 2) / 2
            return CGSize(width: width, height: width)
        } else {
            if indexPath.item < 9 {
                let width = (frame.width - 3) / 3
                return CGSize(width: width, height: width)
            } else {
                let width = frame.width
                return CGSize(width: width, height: 70)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
