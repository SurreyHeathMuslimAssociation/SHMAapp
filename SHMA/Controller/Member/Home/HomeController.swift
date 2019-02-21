//
//  HomeController.swift
//  SHMA
//
//  Created by Umar Yaqub on 22/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import CoreLocation

class HomeController: UIViewController {
    
    var shmaCardView: SHMACardView!
    var prayerTimesView: PrayerTimesView!
    
    var shmaCardViewTopAnchor: NSLayoutConstraint?
    var shmaCardViewWidthAnchor: NSLayoutConstraint?
    var shmaCardViewHeightAnchor: NSLayoutConstraint?
    var shmaCardViewCenterYAnchor: NSLayoutConstraint?
    var shmaCardViewRightAnchor: NSLayoutConstraint?
    
    var prayerTimesViewTopAnchor: NSLayoutConstraint?
    var prayerTimesViewLeftAnchor: NSLayoutConstraint?
    
    var firebaseDatabaseManager: FirebaseDatabaseManager!
    var member: Member!
    var networkManager: NetworkManager!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        firebaseDatabaseManager = FirebaseDatabaseManager(session: Database.database())
        networkManager = NetworkManager(session: URLSession.shared)
        
        guard let navBarHeight = navigationController?.navigationBar.frame.height else { return }
        guard let tabBarHeight = tabBarController?.tabBar.frame.height else { return }
        
        shmaCardView = SHMACardView(traitCollection: traitCollection, navBarHeight, tabBarHeight)
        view.addSubview(shmaCardView)
        shmaCardView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        prayerTimesView = PrayerTimesView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(prayerTimesView)
        prayerTimesView.anchor(top: nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        prayerTimesView.prayerTimesViewModel.traitCollection = traitCollection
        
        saveCurrentLocation()
        setupShmaCardView()
        setupPrayerTimesView()
        setupNavBar()
        fetchAssociationDetailsAndSetupMember()
        setupPrayerTitles()
    }
    
    private func setupShmaCardView() {
        shmaCardViewTopAnchor?.isActive = false
        shmaCardViewWidthAnchor?.isActive = false
        shmaCardViewCenterYAnchor?.isActive = false
        shmaCardViewRightAnchor?.isActive = false
        shmaCardViewHeightAnchor?.isActive = false
        
        shmaCardViewTopAnchor = shmaCardView.shmaCardViewModel.getShmaCardViewTopAnchor()
        shmaCardViewTopAnchor?.isActive = true
        
        shmaCardViewWidthAnchor = shmaCardView.shmaCardViewModel.getShmaCardViewWidthAnchor()
        shmaCardViewWidthAnchor?.isActive = true
        
        shmaCardViewRightAnchor = shmaCardView.shmaCardViewModel.getShmaCardViewRightAnchor()
        shmaCardViewRightAnchor?.isActive = true
        
        shmaCardViewHeightAnchor = shmaCardView.shmaCardViewModel.getShmaCardViewHeightAnchor()
        shmaCardViewHeightAnchor?.isActive = true
        
        shmaCardViewCenterYAnchor = shmaCardView.shmaCardViewModel.getShmaCardViewCenterYAnchor()
        shmaCardViewCenterYAnchor?.isActive = true
    }
    
    private func setupPrayerTimesView() {
        prayerTimesViewTopAnchor?.isActive = false
        prayerTimesViewLeftAnchor?.isActive = false
        
        if !traitCollection.isIphonePortrait {
            prayerTimesViewTopAnchor = prayerTimesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
            prayerTimesViewTopAnchor?.isActive = true
            
            prayerTimesViewLeftAnchor = prayerTimesView.leftAnchor.constraint(equalTo: shmaCardView.rightAnchor, constant: 5)
            prayerTimesViewLeftAnchor?.isActive = true
        } else {
            prayerTimesViewTopAnchor = prayerTimesView.topAnchor.constraint(equalTo: shmaCardView.bottomAnchor, constant: 5)
            prayerTimesViewTopAnchor?.isActive = true
            
            prayerTimesViewLeftAnchor = prayerTimesView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5)
            prayerTimesViewLeftAnchor?.isActive = true
        }
    }
    
    private func setupNavBar() {
        navigationItem.title = member.fullName
        navigationController?.navigationBar.titleTextAttributes = shmaCardView.shmaCardViewModel.getNavigationBarTitleTextAttributes()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        shmaCardView.traitCollectionDidChange(previousTraitCollection)
        prayerTimesView.prayerTimesViewModel.traitCollection = traitCollection
        setupShmaCardView()
        setupPrayerTimesView()
    }
}
