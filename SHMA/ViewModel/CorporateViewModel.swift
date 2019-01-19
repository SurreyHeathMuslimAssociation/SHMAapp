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
    let lastNameTextField: UITextField
    let datePicker: UIDatePicker
    let view: UIView
    
    init(_ traitCollection: UITraitCollection, _ mainLabel: UILabel, _ lastNameTextField: UITextField, _ datePicker: UIDatePicker, _ view: UIView) {
        self.traitCollection = traitCollection
        self.mainLabel = mainLabel
        self.lastNameTextField = lastNameTextField
        self.datePicker = datePicker
        self.view = view
    }
    
    // mianLabel
    func getMainLabelFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 26)
        } else {
            return UIFont.systemFont(ofSize: 16)
        }
    }
    
    func getMainLabelBottomAnchor() -> NSLayoutConstraint? {
        if !traitCollection.isIphoneLandscape {
            if traitCollection.isIpad {
                return mainLabel.bottomAnchor.constraint(equalTo: lastNameTextField.topAnchor, constant: -30)
            } else {
                return mainLabel.bottomAnchor.constraint(equalTo: lastNameTextField.topAnchor, constant: -10)
            }
        } else {
            return nil
        }
    }
    
    func getMainLabelWidthAnchor() -> NSLayoutConstraint? {
        if !traitCollection.isIphoneLandscape {
            return mainLabel.widthAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 1)
        } else {
            return nil
        }
    }
    
    func getMainLabelRightAnchor() -> NSLayoutConstraint? {
        if traitCollection.isIphoneLandscape {
            return mainLabel.rightAnchor.constraint(equalTo: datePicker.leftAnchor, constant: -5)
        } else {
            return nil
        }
    }
    
    func getMainLabelLeftAnchor() -> NSLayoutConstraint? {
        if traitCollection.isIphoneLandscape {
            return mainLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5)
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
            return datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        } else {
            return datePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
        }
    }
    
    func getDatePickerCenterXAnchor() -> NSLayoutConstraint {
        if traitCollection.isIphoneLandscape {
            return datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 115)
        } else {
            return datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        }
    }
    
    // lastNameTextField
    func getlastNameTextFieldFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    func getlastNameTextFieldHeightForEachDevice() -> CGFloat {
        if traitCollection.isIpad {
            return 45
        } else {
            return 35
        }
    }
    
    func getlastNameTextFieldBottomPadding() -> CGFloat {
        if traitCollection.isIpad {
            return 10
        } else {
            return 5
        }
    }
    
    func getEmptyLastNameTextFieldAlertViewTitle() -> NSAttributedString {
        let title = "Attention"
        if traitCollection.isIpad {
            return NSAttributedString.getAttributedStringUsing(text: title, font: 20, spaceFont: 4, isBold: true)
        } else {
            return NSAttributedString.getAttributedStringUsing(text: title, font: 16, spaceFont: nil, isBold: true)
        }
    }
  
    func getEmptyLastNameTextFieldAlertViewText() -> NSAttributedString {
        let text = "Please ensure 'Surname' is entered."
        if traitCollection.isIpad {
            return NSAttributedString.getAttributedStringUsing(text: text, font: 16, spaceFont: nil, isBold: false)
        } else {
             return NSAttributedString.getAttributedStringUsing(text: text, font: 13, spaceFont: nil, isBold: false)
        }
    }
    
    // searchButton
    func getSearchButtonFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
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
    
    // shma id alert
    func getShmaIdsAlertTitle(fetchedShmaIds: [String]) -> NSAttributedString {
        if fetchedShmaIds.isEmpty {
            let title = "Member Not Found"
            if traitCollection.isIpad {
                return NSAttributedString.getAttributedStringUsing(text: title, font: 20, spaceFont: nil, isBold: true)
            } else {
                return NSAttributedString.getAttributedStringUsing(text: title, font: 16, spaceFont: nil, isBold: true)
            }
        } else {
            let title = "Member Found"
            if traitCollection.isIpad {
                return NSAttributedString.getAttributedStringUsing(text: title, font: 20, spaceFont: 4, isBold: true)
            } else {
                return NSAttributedString.getAttributedStringUsing(text: title, font: 16, spaceFont: 2, isBold: true)
            }
        }
    }
    
    func getShmaIdsAlertText(fetchedShmaIds: [String]) -> NSAttributedString {
        if fetchedShmaIds.isEmpty {
            let text = "Please re-enter the details."
            if traitCollection.isIpad {
                return NSAttributedString.getAttributedStringUsing(text: text, font: 16, spaceFont: nil, isBold: false)
            } else {
                return NSAttributedString.getAttributedStringUsing(text: text, font: 13, spaceFont: nil, isBold: false)
            }
        } else {
            let confirmationText = "\n Please ask them to confirm."
            if fetchedShmaIds.count < 2 {
                let text = "Their SHMA ID is: "
                return getOneShmaIdFoundText(fetchedShmaId: fetchedShmaIds[0], text: text, confirmationText: confirmationText)
            } else {
                let text = "Their SHMA ID is one of the following: "
                return getMultipleShmaIdsFoundText(fetchedShmaIds: fetchedShmaIds, text: text, confirmationText: confirmationText)
            }
        }
    }
    
    private func getOneShmaIdFoundText(fetchedShmaId: String, text: String, confirmationText: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        if traitCollection.isIpad {
            attributedString.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            attributedString.append(NSAttributedString(string: fetchedShmaId, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]))
            attributedString.append(NSAttributedString(string: confirmationText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            return attributedString
        } else {
            attributedString.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
            attributedString.append(NSAttributedString(string: fetchedShmaId, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)]))
            attributedString.append(NSAttributedString(string: confirmationText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
            return attributedString
        }
    }
    
    private func getMultipleShmaIdsFoundText(fetchedShmaIds: [String], text: String, confirmationText: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        if traitCollection.isIpad {
            attributedString.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            attributedString.append(NSAttributedString(string: "\(fetchedShmaIds)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]))
            attributedString.append(NSAttributedString(string: confirmationText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            return attributedString
        } else {
            attributedString.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
            attributedString.append(NSAttributedString(string: "\(fetchedShmaIds)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)]))
            attributedString.append(NSAttributedString(string: confirmationText, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
            return attributedString
        }
    }
    
    // no network alert
    func getNoNetworkAlertTitle() -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString.getAttributedStringUsing(text: "No Internet Connection", font: 20, spaceFont: 4, isBold: true)
        } else {
            return NSAttributedString.getAttributedStringUsing(text: "No Internet Connection", font: 16, spaceFont: 2, isBold: true)
        }
    }
    
    func getNoNetworkAlertText() -> NSAttributedString {
        if traitCollection.isIpad {
            return NSAttributedString.getAttributedStringUsing(text: "Please connect to the internet in order to search a member.", font: 16, spaceFont: nil, isBold: false)
        } else {
            return NSAttributedString.getAttributedStringUsing(text: "Please connect to the internet in order to search a member.", font: 13, spaceFont: nil, isBold: false)
        }
    }
}
