//
//  PageViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 28/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class PageViewModel {
    
    let traitCollection: UITraitCollection
    let page: Page
    let member: Member
    let isNavBarHidden: Bool
    
    init(page: Page, deviceTraitCollection: UITraitCollection, _ member: Member, _ isNavBarHidden: Bool) {
        self.traitCollection = deviceTraitCollection
        self.page = page
        self.member = member
        self.isNavBarHidden = isNavBarHidden
    }
    
    func getMainLabelAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString()
        let message = page.message as NSString
        if traitCollection.isIpad {
            attributedText.append(NSAttributedString(string: "\(page.title)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40)]))
            attributedText.append(NSAttributedString(string: member.fullName, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40)]))
            attributedText.append(NSAttributedString(string: "\n\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]))
            attributedText.append(getMessageStringWithAttributes(message, fontSize: 30))
            return attributedText
        } else {
            attributedText.append(NSAttributedString(string: "\(page.title)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]))
            attributedText.append(NSAttributedString(string: member.fullName, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]))
            attributedText.append(NSAttributedString(string: "\n\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 8)]))
            attributedText.append(getMessageStringWithAttributes(message, fontSize: 18))
            return attributedText
        }
    }
    
    private func getMessageStringWithAttributes(_ message: NSString, fontSize: CGFloat) -> NSAttributedString {
        let messageAT = NSMutableAttributedString(string: message as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)])
        messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)], range: message.range(of: "Surrey Heath Muslim Association"))
        messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)], range: message.range(of: "£7"))
        messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)], range: message.range(of: "£4"))
        messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)], range: message.range(of: "30-00-83"))
        messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)], range: message.range(of: "01222601"))
        if traitCollection.isIpad {
            messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 32)], range: message.range(of: "SHMA-\(member.shmaId ?? 0)"))
        } else {
            messageAT.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)], range: message.range(of: "SHMA-\(member.shmaId ?? 0)"))
        }
        return messageAT
    }
    
    func getButtonFontForEachDevice() -> UIFont {
        if traitCollection.isIpad {
            return UIFont.systemFont(ofSize: 22)
        } else {
            return UIFont.systemFont(ofSize: 14)
        }
    }
    
    func getButtonIsHiddenStatus() -> Bool {
        if isNavBarHidden {
            if member.status == "Applied" {
                if page.type == .payment {
                    return false
                } else {
                    return true
                }
            } else {
                return false
            }
        } else {
            return true
        }
    }
    
    func getButtonCornerRadiusForEachDevice() -> CGFloat {
        if traitCollection.isIpad {
            return 10
        } else {
            return 5
        }
    }
    
    func getButtonWidthForEachDevice() -> CGFloat {
        if traitCollection.isIpad {
            return 520
        } else {
            return 260
        }
    }
    
    func getButtonHeightForEachDevice() -> CGFloat {
        if traitCollection.isIpad {
            return 85
        } else {
            return 45
        }
    }
}
