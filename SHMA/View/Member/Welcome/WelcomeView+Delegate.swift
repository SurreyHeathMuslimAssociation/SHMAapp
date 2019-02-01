//
//  WelcomeView+Delegate.swift
//  SHMA
//
//  Created by Umar Yaqub on 28/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension WelcomeView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, WelcomeViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // updates page number on pageControl
        let pageNumber = Int(targetContentOffset.pointee.x / frame.width)
        pageControl.currentPage = pageNumber
        // only hides page control on welcome screen and not home
        if isNavBarHidden == true {
            // hides page control on last page
            if pageNumber == pageViewModel.count - 1 {
                pageControlBottomAnchor?.constant = 60
            } else {
                pageControlBottomAnchor?.constant = 0
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                // animates constraint change
                self.layoutIfNeeded()
            })
        }
    }
    
    func handleLoginReturn() {
        delegate?.sendUserToLogin()
    }
    
}
