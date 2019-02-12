//
//  TermsAndConditionsViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class TermsAndConditionsViewModel {
    
    let traitCollection: UITraitCollection
    let termsAndConditionsView: UIView
    
    init(_ traitCollection: UITraitCollection, termsAndConditionsView: UIView) {
        self.traitCollection = traitCollection
        self.termsAndConditionsView = termsAndConditionsView
    }
    
    func getAgreeButtonFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.boldSystemFont(ofSize: 22)
        } else {
            return UIFont.boldSystemFont(ofSize: 14)
        }
    }
    
    func getDisagreeButtonFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    //navBar
    func getNavigationBarTitleTextAttributes() -> [NSAttributedString.Key: UIFont] {
        if traitCollection.isIpad {
            return [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        } else {
            return [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        }
    }
    
    func getNavBarText() -> String {
        return "SHMA Terms And Conditions"
    }
}
