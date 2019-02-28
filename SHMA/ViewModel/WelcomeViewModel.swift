//
//  WelcomeViewModel.swift
//  SHMA
//
//  Created by Umar Yaqub on 23/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class WelcomeViewModel {
    
    var traitCollection: UITraitCollection
    let member: Member
    
    init(_ traitCollection: UITraitCollection, _ member: Member) {
        self.traitCollection = traitCollection
        self.member = member
    }
    
    func getWelcomePageTitle() -> String {
        if member.status == "Approved" {
            //return "Welcome, \(memberName)!"
            return "Welcome, "
        } else {
            //return "Congratulations on joining SHMA, \n \(memberName)!"
            return "Congratulations on joining SHMA,\n"
        }
    }
    
    func getWelcomePageMessage() -> String {
        if member.status == "Approved" {
            let message = "Congratulations on signing up to our Surrey Heath Muslim Association App, this is another step to bringing our members closer.\n\nWe have sent you an email asking you to verfiy your account, you will be able to log in once it has been verified."
            return message
        } else {
            let message = "You are now just a few steps away from being a full feldged Surrey Heath Muslim Association Member.\n\n Please swipe right to continue..."
            return message
        }
    }
    
    func getDetailPageMessage() -> String {
        var cost: Int!
        if member.membershipType == "Single" {
            cost = 4
        } else {
            cost = 7
        }
        let message = "Your membership cost is £\(cost ?? 0).\n However, many of our members choose to contribute more and the rest is counted as donation.\nThis enables us to provide more services to our members."
        return message
    }
    
    func getPaymentPageMessage() -> String {
        let message = "Just few more steps to go:\n\n😊 Verfiy your account via the link in your email\n😊 Setup your monthly standing order to the following account:\n\nSurrey Heath Muslim Association\nSort Code: 30-00-83\nAccount Number: 01222601\n\nThe payment reference must be: SHMA-\(member.shmaId ?? 0)"
        return message
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
