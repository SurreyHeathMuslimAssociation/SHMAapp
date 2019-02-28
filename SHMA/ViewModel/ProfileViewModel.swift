//
//  ProfileViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 04/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class ProfileViewModel {
    
    let traitCollection: UITraitCollection
    let member: Member
    
    init(_ traitCollection: UITraitCollection, _ member: Member) {
        self.traitCollection = traitCollection
        self.member = member
    }
    
    func getLabelAndTextViewFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    func getLabelTextColour() -> UIColor {
        return .lightGray
    }
    
    func isTextFieldUserInteractionEnabled() -> Bool {
        return false
    }
    
    //navBar
    func getNavigationBarTitleTextAttributes() -> [NSAttributedString.Key: UIFont] {
        if traitCollection.isIpad {
            return [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        } else {
            return [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        }
    }
    
    func getNavigationBarTitle() -> String {
        return "SHMA ID: \(member.shmaId ?? 0)"
    }
    
    func getFooterTextViewText() -> NSAttributedString {
        if traitCollection.isIpad {
            let attributedText = NSAttributedString(string: "If you have any queries please contact us on\nenquiries@shma-uk.org", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)])
            return attributedText
        } else {
            let attributedText = NSAttributedString(string: "If you have any queries please contact us on \nenquiries@shma-uk.org", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
            return attributedText
        }
    }
    
    func getTableViewCellHeightForEachDevice() -> CGFloat {
        if traitCollection.isIpad {
            return 80
        } else {
            return 60
        }
    }
    
    func getTableViewFooterHeightForEachDevice() -> CGFloat {
        if traitCollection.isIpad {
            return 150
        } else {
            return 100
        }
    }
    
    func getMemberDetailLabelLeftPadding() -> CGFloat {
        if traitCollection.isIpad {
            return 15
        } else {
            return 10
        }
    }
    
    func getMemberDetailLabelWidth() -> CGFloat {
        if traitCollection.isIpad {
            return 180
        } else {
            return 120
        }
    }
    
    func getMemberDetailTextViewLeftPadding() -> CGFloat {
        if traitCollection.isIpad {
            return 40
        } else {
            return 20
        }
    }
    
    func getInfoTextViewTopPadding() -> CGFloat {
        if traitCollection.isIpad {
            return 30
        } else {
            return 20
        }
    }
}

