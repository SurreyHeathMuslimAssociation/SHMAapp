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
        
        setupNavBar()
        setupBusinessLabels()
        setupBusinessDetails()
        switchDiscountImageAndLabel()
    }
    
    private func setupNavBar() {
        guard let businessInfo = businessViewModel?.business?.information.result else { return }
        navigationItem.title = businessInfo.name
        navigationController?.navigationBar.titleTextAttributes = businessDetailView.businessViewModel?.getNavigationBarTitleTextAttributes()
    }
    
    private func setupBusinessLabels() {
        businessDetailView.businessLabels.append("Address")
        businessDetailView.businessLabels.append("Rating")
        businessDetailView.businessLabels.append("Type")
        businessDetailView.businessLabels.append("Open Now")
        businessDetailView.businessLabels.append("Opening Times")
        businessDetailView.businessLabels.append("Phone Number")
    }
    
    private func setupBusinessDetails() {
        guard let businessInfo = businessViewModel?.business?.information.result else { return }
        businessDetailView.businessDetails.append(businessInfo.address)
        businessDetailView.businessDetails.append("\(businessInfo.rating)")
        businessDetailView.businessDetails.append(businessInfo.types[0].capitalized)
        if businessInfo.openingHours?.isOpen == true {
            businessDetailView.businessDetails.append("Yes")
        } else {
            businessDetailView.businessDetails.append("No")
        }
        businessDetailView.businessDetails.append("\(businessInfo.openingHours?.timings ?? ["N/A"])")
        businessDetailView.businessDetails.append(businessInfo.phoneNo)

        DispatchQueue.main.async {
            self.businessDetailView.reloadData()
        }
    }
    
    var isImageBeingDisplayed = false
    
    func switchDiscountImageAndLabel() {
        Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: { (timer) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.businessDetailView.businessDetailHeader.discountLabel.isHidden = self.isImageBeingDisplayed ? true : false
                self.businessDetailView.businessDetailHeader.businessImageView.isHidden = self.isImageBeingDisplayed ? false : true
            })
            self.isImageBeingDisplayed = !self.isImageBeingDisplayed
        })
    }
}
