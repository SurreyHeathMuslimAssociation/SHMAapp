//
//  FuneralContactsController.swift
//  SHMA
//
//  Created by Umar Yaqub on 16/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FuneralContactsController: UIViewController {
    
    var firebaseDatabaseManager: FirebaseDatabaseManager!
    var funeralContactsView: FuneralContactsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // setup funeral contacts view
        funeralContactsView = FuneralContactsView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(funeralContactsView)
        funeralContactsView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        let funeralContactViewModel = FuneralContactViewModel(traitCollection)
        funeralContactViewModel.funeralContactsView = funeralContactsView
        funeralContactsView.funeralContactViewModel = funeralContactViewModel
        
        // setup nav bar
        navigationItem.title = "Funeral Contacts"
        navigationController?.navigationBar.titleTextAttributes = funeralContactsView.funeralContactViewModel.getNavigationBarTitleTextAttributes()
        
        fetchFuneralContacts()
    }
    
    private func fetchFuneralContacts() {
        firebaseDatabaseManager = FirebaseDatabaseManager(session: Database.database())
        firebaseDatabaseManager.fetchFuneralContacts { (funeralContact) in
            let funeralContactViewModel = FuneralContactViewModel(self.traitCollection)
            funeralContactViewModel.funeralContact = funeralContact
            self.funeralContactsView.funeralContactViewModels?.append(funeralContactViewModel)
            DispatchQueue.main.async {
                self.funeralContactsView.reloadData()
            }
        }
        
    }
}
