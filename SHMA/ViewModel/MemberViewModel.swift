//
//  MemberViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 08/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class MemberViewModel {
    
    var traitCollection: UITraitCollection
    let memberView: UIView
    
    init(_ traitCollection: UITraitCollection, _ memberView: UIView) {
        self.traitCollection = traitCollection
        self.memberView = memberView
    }
    
    // mianLabel
    func getMainLabelFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 26)
        } else {
            return UIFont.systemFont(ofSize: 16)
        }
    }
    
    // buttons
    func getButtonFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    func getButtonStackViewWidthForEachDevice() -> CGFloat {
        if traitCollection.isIpad {
            return 520
        } else {
            return 260
        }
    }
    
    func getButtonStackViewHeightForEachDevice() -> CGFloat {
        if traitCollection.isIpad {
            return 255
        } else {
            return 135
        }
    }
    
    func getButtonCornerRadiusAndSpacingForEachDevice() -> CGFloat {
        if traitCollection.isIpad {
            return 10
        } else {
            return 5
        }
    }
    
    // member view
    func getMemberViewHeight() -> NSLayoutConstraint {
        guard let superviewHeight = memberView.superview?.heightAnchor else {
            return NSLayoutConstraint()
            
        }
        if traitCollection.isIphoneLandscape {
            return memberView.heightAnchor.constraint(equalTo: superviewHeight, multiplier: 0.53)
        } else {
            return memberView.heightAnchor.constraint(equalTo: superviewHeight, multiplier: 0.25)
        }
    }
    
    //navBar
    func getNavigationBarTitleTextAttributesForEachDevice() -> [NSAttributedString.Key: UIFont] {
        if traitCollection.isIpad {
            return [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        } else {
            return [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        }
    }
}
