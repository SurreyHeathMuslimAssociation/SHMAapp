//
//  BusinessViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 09/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class BusinessViewModel {
    
    let traitCollection: UITraitCollection
    var businessView: UICollectionView!
    var business: Business?
    
    init(_ traitCollection: UITraitCollection) {
        self.traitCollection = traitCollection
    }
    
    func getBusinessNameAttributedText() -> NSAttributedString {
        guard let name = business?.information.result.name else { return NSAttributedString() }
        let discount = business?.discount ?? ""
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 6)]))
            attributedText.append(NSAttributedString(string: "\(discount) off", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            return attributedText
        } else {
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 6)]))
            attributedText.append(NSAttributedString(string: "\(discount) off", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]))
            return attributedText
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
    
    func getBusinessCollectionViewCellSize() -> CGSize {
        if traitCollection.isIpad {
            let width = (businessView.frame.width - 3) / 3
            return CGSize(width: width, height: width)
        } else {
            let width = (businessView.frame.width - 2) / 3
            return CGSize(width: width, height: width)
        }
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
    
    func getBusinessDetailViewHeaderHeight() -> CGFloat {
        if traitCollection.isIpad {
            return 300
        } else {
            return 200
        }
    }
    
    func getBusinessDetailViewFooterHeight() -> CGFloat {
        if traitCollection.isIpad {
            return 150
        } else {
            return 100
        }
    }
    
    func getDiscountLabelAttributedString() -> NSAttributedString {
        let discount = business?.discount ?? ""
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: discount, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 50)])
            attributedText.append(NSAttributedString(string: " off!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34)]))
            return attributedText
        } else {
            let attributedText = NSMutableAttributedString(string: discount, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40)])
            attributedText.append(NSAttributedString(string: "  off!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)]))
            return attributedText
        }
    }
    
}
