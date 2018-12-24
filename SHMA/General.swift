//
//  General.swift
//  SHMA
//
//  Created by Umar Yaqub on 20/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension UIColor {
    /// UIColor helper function
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    /**
     Helper constraints method.
     
     This method takes in the following properties and pins a view to the desired location.
     Certain properties are optional as the user doesn't need to define all of them.
     
     - Parameters:
     - top: Top constraint
     - left: Left constraint
     - bottom: Bottom constraint
     - right: Right constraint
     - paddingTop: Top Padding
     - paddingLeft: Ledt Padding
     - paddingBottom: Bottom Padding
     - paddingRight: Right Padding
     - width: Width of the object
     - height: Height of the object
     - centerYAnchor: Vertical center constraint of the object
     - centerXAnchor: Horizontal center constraint of the object
     */
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, centerYAnchor: NSLayoutYAxisAnchor?, centerXAnchor: NSLayoutXAxisAnchor?) {
        // set constraints
        if let centerY = centerYAnchor {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        if let centerX = centerXAnchor {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        // set width/height
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        // activates autolayout constraint
        translatesAutoresizingMaskIntoConstraints = false
    }
}

/// Helper device type extension
extension UITraitCollection {
    var isIpad: Bool {
        return horizontalSizeClass == .regular && verticalSizeClass == .regular
    }
    var isIphoneLandscape: Bool {
        return verticalSizeClass == .compact
    }
    var isIphonePortrait: Bool {
        return horizontalSizeClass == .compact && verticalSizeClass == .regular
    }
    var isIphone: Bool {
        return isIphoneLandscape || isIphonePortrait
    }
}
