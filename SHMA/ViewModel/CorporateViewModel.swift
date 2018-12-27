//
//  CorporateViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 26/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class CorporateViewModel {
    
    var traitCollection: UITraitCollection
    let mainLabel: UILabel
    let firstNameTextField: UITextField
    let datePicker: UIDatePicker
    let view: UIView
    
    init(_ traitCollection: UITraitCollection, _ mainLabel: UILabel, _ firstNameTextField: UITextField, _ datePicker: UIDatePicker, _ view: UIView) {
        self.traitCollection = traitCollection
        self.mainLabel = mainLabel
        self.firstNameTextField = firstNameTextField
        self.datePicker = datePicker
        self.view = view
    }
    
    // mianLabel
    func getMainLabelFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 26)
        } else {
            return UIFont.systemFont(ofSize: 18)
        }
    }
    
    func getMainLabelBottomAnchor() -> NSLayoutConstraint? {
        if !traitCollection.isIphoneLandscape {
            if traitCollection.isIpad {
                return mainLabel.bottomAnchor.constraint(equalTo: firstNameTextField.topAnchor, constant: -30)
            } else {
                return mainLabel.bottomAnchor.constraint(equalTo: firstNameTextField.topAnchor, constant: -10)
            }
        } else {
            return nil
        }
    }
    
    func getMainLabelWidthAnchor() -> NSLayoutConstraint {
        if traitCollection.isIphoneLandscape {
            return mainLabel.widthAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 0.9)
        } else {
            return mainLabel.widthAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 1)
        }
    }
    
    func getMainLabelRightAnchor() -> NSLayoutConstraint? {
        if traitCollection.isIphoneLandscape {
            return mainLabel.rightAnchor.constraint(equalTo: datePicker.leftAnchor, constant: -5)
        } else {
            return nil
        }
    }
    
    func getMainLabelCenterXAnchor() -> NSLayoutConstraint? {
        if !traitCollection.isIphoneLandscape {
            return mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        } else {
            return nil
        }
    }
    
    func getMainLabelCenterYAnchor() -> NSLayoutConstraint? {
        if traitCollection.isIphoneLandscape {
            return mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        } else {
            return nil
        }
    }
    
    // datePicker
    func getDatePickerWidthAnchor() -> NSLayoutConstraint {
        if traitCollection.isIphoneLandscape {
            return datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
        } else {
            return datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65)
        }
    }
    
    func getDatePickerCenterXAnchor() -> NSLayoutConstraint {
        if traitCollection.isIphoneLandscape {
            return datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80)
        } else {
            return datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
    }
    
    // firstNametextField
    func getFirstNameTextFieldFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    func getFirstNameTextFieldHeightForEachDevice() -> CGFloat {
        if traitCollection.isIpad {
            return 45
        } else {
            return 35
        }
    }
    
    func getFirstNameTextFieldBottomPadding() -> CGFloat {
        if traitCollection.isIpad {
            return 10
        } else {
            return 5
        }
    }
    
    // searchButton
    func getSearchButtonFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 25)
        } else {
            return UIFont.systemFont(ofSize: 16)
        }
    }
    
    func getSearchButtonTopPadding() -> CGFloat {
        if traitCollection.isIpad {
            return 10
        } else {
            return 5
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
}
