//
//  SHMACardViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 26/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class SHMACardViewModel {
    
    var traitCollection: UITraitCollection
    let shmaCardView: UIView
    let tabBarHeight: CGFloat
    let navBarHeight: CGFloat
    var association: Association!
    var member: Member!
    
    init(_ traitCollection: UITraitCollection, _ shmaCardView: UIView, _ tabBarHeight: CGFloat, _ navBarHeight: CGFloat) {
        self.traitCollection = traitCollection
        self.shmaCardView = shmaCardView
        self.tabBarHeight = tabBarHeight
        self.navBarHeight = navBarHeight
    }
    
    func getShmaCardLogoWidth() -> CGFloat {
        return 50
    }
    
    func getShmaCardLogoHeight() -> CGFloat {
        return 70
    }
    
    func getShmaCardViewTopAnchor() -> NSLayoutConstraint? {
        guard let superview = shmaCardView.superview else {
            return NSLayoutConstraint()
        }
        if traitCollection.isIphonePortrait {
            return shmaCardView.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: 10)
        } else {
            return nil
        }
    }
    
    func getShmaCardViewRightAnchor() -> NSLayoutConstraint? {
        guard let superview = shmaCardView.superview else {
            return NSLayoutConstraint()
        }
        if traitCollection.isIphonePortrait {
            return shmaCardView.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -10)
        } else {
            return nil
        }
    }
    
    func getShmaCardViewHeightAnchor() -> NSLayoutConstraint {
        if traitCollection.isIphonePortrait {
            return shmaCardView.heightAnchor.constraint(equalToConstant: 220)
        } else {
            return shmaCardView.heightAnchor.constraint(equalToConstant: 215)
        }
    }
    
    func getShmaCardViewWidthAnchor() -> NSLayoutConstraint? {
        if !traitCollection.isIphonePortrait {
            return shmaCardView.widthAnchor.constraint(equalToConstant: 330)
        } else {
            return nil
        }
    }
    
    func getShmaCardViewCenterYAnchor() -> NSLayoutConstraint? {
        guard let superview = shmaCardView.superview else {
            return NSLayoutConstraint()
        }
        if !traitCollection.isIphonePortrait {
            return shmaCardView.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: -(tabBarHeight - navBarHeight)/2)
        } else {
            return nil
        }
    }
    
    // labels
    func getShmaLogoTextLabelText() -> NSAttributedString {
        let name = association.name
        if traitCollection.isIpad {
            return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 40) ?? UIFont.systemFont(ofSize: 40)])
        } else {
            return NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 30) ?? UIFont.systemFont(ofSize: 30)])
        }
    }
    
    func getShmaContactInfoLabelText() -> NSAttributedString {
        let email = association.generalEmail
        let web = association.web
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: "Web: \(web)\n", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 18) ?? UIFont.systemFont(ofSize: 18)])
            attributedText.append(NSAttributedString(string: "E-mail: \(email)", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 18) ?? UIFont.systemFont(ofSize: 18)]))
            return attributedText
        } else {
            let attributedText = NSMutableAttributedString(string: "Web: \(web)\n", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 14) ?? UIFont.systemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string: "E-mail: \(email)", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 14) ?? UIFont.systemFont(ofSize: 14)]))
            return attributedText
        }
    }
    
    func getDateAndTimeLabelText() -> NSAttributedString {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        if traitCollection.isIpad {
            return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 18) ?? UIFont.systemFont(ofSize: 18)])
        } else {
            return NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 14) ?? UIFont.systemFont(ofSize: 14)])
        }
    }
    
    func getShmaMemberMembershipNumberText() -> NSAttributedString {
        let shmaId = member.shmaId
        if traitCollection.isIpad {
            let attributedText = NSMutableAttributedString(string: "Membership Number:  ", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 22) ?? UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.yellow])
            attributedText.append(NSAttributedString(string: "0\(shmaId ?? 0)A", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 22) ?? UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 218, green: 165, blue: 32)]))
            return attributedText
        } else {
            let attributedText = NSMutableAttributedString(string: "Membership Number:  ", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 16) ?? UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.yellow])
            attributedText.append(NSAttributedString(string: "0\(shmaId ?? 0)A", attributes: [NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 20) ?? UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 218, green: 165, blue: 32)]))
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
    
    func getMembershipNumberLabelHeight() -> CGFloat {
        return 30
    }
    
    func getContactInfoLabelHeight() -> CGFloat {
        return 35
    }
    
    func getDateAndTimeLabelHeight() -> CGFloat {
        return 25
    }
    
    func getDateAndTimeLabelWidth() -> CGFloat {
        return 140
    }
}
