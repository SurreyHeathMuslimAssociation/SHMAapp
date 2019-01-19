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

/// Helper alert method
extension UIAlertController {
    static func showAlert(title: NSAttributedString, text: NSAttributedString, viewController: UIViewController) {
        let alert = self.init(title: "", message: "", preferredStyle: .alert)
        alert.setValue(title, forKey: "attributedTitle")
        alert.setValue(text, forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}

extension NSAttributedString {
    
    /// Gets the onboarding attributed string with desired fonts
    static func getAttributedStringUsing(text: String, font: CGFloat, spaceFont: CGFloat?, isBold: Bool) -> NSAttributedString {
        let attributedtext = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: (isBold ? UIFont.boldSystemFont(ofSize: font) : UIFont.systemFont(ofSize: font))])
        attributedtext.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: spaceFont ?? 0)]))
        return attributedtext
    }
    
    static func getAttributedString(title: String, titleFont: UIFont, linesOfSpace: String, spaceFont: CGFloat, message: String, messageFont: UIFont) -> NSAttributedString {
        let attributedtext = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: titleFont])
        attributedtext.append(NSAttributedString(string: linesOfSpace, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: spaceFont)]))
        attributedtext.append(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font: messageFont]))
        return attributedtext
    }
}
