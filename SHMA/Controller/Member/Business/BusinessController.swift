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
        firebaseDatabaseManager.fetchBusinessesDetailsFromFirebase { (placeId, iconUrl, discount) in
            self.networkManager.fetchGooglePlaceData(using: placeId, completion: { (response) in
                let business = Business(iconUrl: iconUrl, discount: discount, information: response)
                let businessViewModel = BusinessViewModel(self.traitCollection)
                businessViewModel.business = business
                self.businessView.businessViewModels.append(businessViewModel)
            })
            self.attempReloadOfCollectionView()
        }
    }
    
    private func attempReloadOfCollectionView() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(handleReload), userInfo: nil, repeats: false)
    }
    
    @objc func handleReload() {
        DispatchQueue.main.async {
            self.businessView.activityIndicatorView.stopAnimating()
            self.businessView.reloadData()
        }
    }
}
