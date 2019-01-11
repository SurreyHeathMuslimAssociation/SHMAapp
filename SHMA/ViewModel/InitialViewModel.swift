//
//  InitialViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 22/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class InitialViewModel {
    
    let traitCollection: UITraitCollection
    let buttonStackView: UIStackView
    let shmaLogoIV: UIImageView
    let view: UIView
    
    init(_ traitCollection: UITraitCollection, _ buttonStackView: UIStackView, _ shmaLogoIV: UIImageView, view: UIView) {
        self.traitCollection = traitCollection
        self.buttonStackView = buttonStackView
        self.shmaLogoIV = shmaLogoIV
        self.view = view
    }
    
    func getSHMALogoImageViewHeight() -> CGFloat {
        if traitCollection.isIpad {
            return 298
        } else {
            return 149
        }
    }
    
    func getSHMALogoImageViewWidth() -> CGFloat {
        if traitCollection.isIpad {
            return 520
        } else {
            return 260
        }
    }
    
    func getButtonStackViewHeight() -> CGFloat {
        if traitCollection.isIpad {
            return 170
        } else {
            return 90
        }
    }
    
    func getButtonCornerRadiusAndSpacing() -> CGFloat {
        if traitCollection.isIpad {
            return 10
        } else {
            return 5
        }
    }
    
    func getButtonFont() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
   
}
