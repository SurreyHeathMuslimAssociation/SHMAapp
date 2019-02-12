//
//  BusinessDetailController.swift
//  SHMA
//
//  Created by Umar Yaqub on 11/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

class BusinessDetailController: UIViewController {
    
    var businessDetailView: BusinessDetailView!
    var businessViewModel: BusinessViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        businessDetailView = BusinessDetailView(frame: .zero, style: .grouped)
        view.addSubview(businessDetailView)
        businessDetailView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerYAnchor: nil, centerXAnchor: nil)
        businessDetailView.businessViewModel = businessViewModel
        businessDetailView.businessDetailViewDelegate = self
        
        setupBusinessLabels()
        setupBusinessDetails()
    }
    
    private func setupBusinessLabels() {
        businessDetailView.businessLabels.append("Name")
        businessDetailView.businessLabels.append("Address")
        businessDetailView.businessLabels.append("Rating")
        businessDetailView.businessLabels.append("Type")
        businessDetailView.businessLabels.append("Open Now")
        businessDetailView.businessLabels.append("Opening Times")
    }
    
    private func setupBusinessDetails() {
        guard let businessInfo = businessViewModel?.business?.information.result else { return }
        businessDetailView.businessDetails.append(businessInfo.name)
        businessDetailView.businessDetails.append(businessInfo.address)
        businessDetailView.businessDetails.append("\(businessInfo.rating)")
        businessDetailView.businessDetails.append("\(businessInfo.types)")
        if businessInfo.openingHours?.isOpen == true {
            businessDetailView.businessDetails.append("Yes")
        } else {
            businessDetailView.businessDetails.append("No")
        }
        businessDetailView.businessDetails.append("\(businessInfo.openingHours?.timings ?? ["N/A"])")

        DispatchQueue.main.async {
            self.businessDetailView.reloadData()
        }
    }
}
