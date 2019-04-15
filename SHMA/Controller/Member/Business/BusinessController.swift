//
//  BusinessController.swift
//  SHMA
//
//  Created by Umar Yaqub on 04/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseDatabase

class BusinessController: UIViewController {
    
    var firebaseDatabaseManager: FirebaseDatabaseManager!
    var networkManager: NetworkManager!
    var isBusinessDetailAvailable: Bool?
    var businessView: BusinessView!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // setup business collection view
        businessView = BusinessView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(businessView)
        businessView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        let businessViewModel = BusinessViewModel(traitCollection)
        businessViewModel.businessView = businessView
        businessView.businessViewModel = businessViewModel
        businessView.businessViewDelegate = self
        
        // setup nav bar
        navigationItem.title = "Businesses"
        navigationController?.navigationBar.titleTextAttributes = businessView.businessViewModel.getNavigationBarTitleTextAttributes()
        
        // initialise database/network manager
        firebaseDatabaseManager = FirebaseDatabaseManager(session: Database.database())
        networkManager = NetworkManager(session: URLSession.shared)
        
        fetchBusinesses()
    }
    
    private func fetchBusinesses() {
        DispatchQueue.main.async {
            self.businessView.activityIndicatorView.startAnimating()
        }
        // create dispatch group and placeIdCount tracker
        var tracker = 0
        let dispatchGroup = DispatchGroup()
        firebaseDatabaseManager.fetchBusinessesDetailsFromFirebase { (placeId, iconUrl, discount, placeIdCount) in
            // enter dispatch group and increment tracker
            dispatchGroup.enter()
            tracker += 1
            self.networkManager.fetchGooglePlaceData(using: placeId, completion: { (response) in
                let business = Business(iconUrl: iconUrl, discount: discount, information: response)
                let businessViewModel = BusinessViewModel(self.traitCollection)
                businessViewModel.business = business
                self.businessView.businessViewModels.append(businessViewModel)
                // if tracker is equal to number of placeId's
                // leave the group as all api's calls have finished
                if tracker == placeIdCount {
                    dispatchGroup.leave()
                }
            })
            // update the collectionview on the main thread
            dispatchGroup.notify(queue: .main, execute: {
                DispatchQueue.main.async {
                    self.businessView.activityIndicatorView.stopAnimating()
                    self.businessView.reloadData()
                }
            })
        }
    }
}
