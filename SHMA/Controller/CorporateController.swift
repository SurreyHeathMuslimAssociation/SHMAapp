//
//  CorporateController.swift
//  SHMA
//
//  Created by Umar Yaqub on 22/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class CorporateController: UIViewController {
    
    var corporateView: CorporateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        corporateView = CorporateView(traitCollection: traitCollection)
        view.addSubview(corporateView)
        corporateView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        navigationItem.title = "SHMA Corporate"
        navigationController?.navigationBar.titleTextAttributes = corporateView.corporateViewModel.getNavigationBarTitleTextAttributes()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        corporateView.traitCollectionDidChange(traitCollection)
    }
}
