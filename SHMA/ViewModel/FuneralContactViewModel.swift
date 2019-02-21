//
//  FuneralContactViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 17/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class FuneralContactViewModel {
    
    let traitCollection: UITraitCollection
    var funeralContactsView: UICollectionView?
    var funeralContact: FuneralContact?
    
    init(_ traitCollection: UITraitCollection) {
        self.traitCollection = traitCollection
    }
    
    //navBar
    func getNavigationBarTitleTextAttributes() -> [NSAttributedString.Key: UIFont] {
        if traitCollection.isIpad {
            return [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        } else {
            return [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        }
    }
    
    func getNameAttributedString() -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString(string: funeralContact?.name ?? "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)])
        } else {
            return NSAttributedString(string: funeralContact?.name ?? "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        }
    }
    
    func getPhoneNoAttributedString() -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString(string: funeralContact?.phoneNo ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)])
        } else {
            return NSAttributedString(string: funeralContact?.phoneNo ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        }
    }
    
    func getCollectionViewCellSize() -> CGSize {
        guard let funeralContactsView = funeralContactsView else { return CGSize() }
        if traitCollection.isIpad {
            let width = (funeralContactsView.frame.width - 3) / 3
            return CGSize(width: width, height: width)
        } else {
            let width = (funeralContactsView.frame.width - 2) / 3
            return CGSize(width: width, height: width)
        }
    }
}
