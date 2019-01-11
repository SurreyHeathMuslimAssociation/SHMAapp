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
        termsAndConditionsView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        
        makeNavigationBarTransparent()
    }
    
    private func makeNavigationBarTransparent() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
