//
//  TermsAndConditionsController.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class TermsAndConditionsController: UIViewController {
    
    var termsAndConditionsView: TermsAndConditionsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        termsAndConditionsView = TermsAndConditionsView(traitCollection: traitCollection)
        termsAndConditionsView.delegate = self
        view.addSubview(termsAndConditionsView)
        termsAndConditionsView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.title = termsAndConditionsView.termsAndConditionsViewModel.getNavBarText()
        navigationController?.navigationBar.titleTextAttributes = termsAndConditionsView.termsAndConditionsViewModel.getNavigationBarTitleTextAttributes()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
