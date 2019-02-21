//
//  HomeController+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 18/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension HomeController {
    
    func fetchAssociationDetailsAndSetupMember() {
        firebaseDatabaseManager.fetchAssociationDetails { (association) in
            self.shmaCardView.association = association
            self.shmaCardView.member = self.member
        }
    }
    
    func setupPrayerTitles() {
        self.prayerTimesView.prayerTitles.append("Fajr")
        self.prayerTimesView.prayerTitles.append("Sunrise")
        self.prayerTimesView.prayerTitles.append("Dhuhr")
        self.prayerTimesView.prayerTitles.append("Asr")
        self.prayerTimesView.prayerTitles.append("Sunset")
        self.prayerTimesView.prayerTitles.append("Maghrib")
        self.prayerTimesView.prayerTitles.append("Isha")
        self.prayerTimesView.prayerTitles.append("Imsak")
        self.prayerTimesView.prayerTitles.append("Midnight")
        self.prayerTimesView.prayerTitles.append("Hijri")
    }

}
