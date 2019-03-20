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
    var association: Association?
    
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
        let lineOne = "If you have any queries please contact us on\n \(association?.committeeEmail ?? "")"
        let lineTwo = "\n\nAlternatively you can post to us on the following address:"
        let address = association?.postalAddress.replacingOccurrences(of: ", ", with: "\n") ?? ""
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: lineOne, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)])
            attributedText.append(NSAttributedString(string: lineTwo, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)]))
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]))
            attributedText.append(NSAttributedString(string: "\(address)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26)]))
            return attributedText
        } else {
            let attributedText = NSMutableAttributedString(string: lineOne, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
            attributedText.append(NSAttributedString(string: lineTwo, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 6)]))
            attributedText.append(NSAttributedString(string: "\(address)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
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
            return 250
        } else {
            return 200
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
            return 0
        }
    }
}

