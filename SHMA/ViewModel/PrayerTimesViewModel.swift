//
//  PrayerTimesViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 18/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class PrayerTimesViewModel {
    
    var traitCollection: UITraitCollection!
 
    func getPrayerTimesLabelFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 35)
        } else {
            return UIFont.systemFont(ofSize: 25)
        }
    }
    
    func getPrayerTitlesLabelFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    func getLabelTextColour() -> UIColor {
        return .lightGray
    }
    
}
