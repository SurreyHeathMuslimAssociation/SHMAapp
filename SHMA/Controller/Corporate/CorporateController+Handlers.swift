//
//  CorporateController+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 27/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension CorporateController: CorporateViewDelegate {

    func didPressSearch() {
        if Reachability.isConnectedToNetwork() {
            guard let surname = corporateView.surnameTextField.text, surname.count > 0 else {
                UIAlertController.showAlert(title: corporateView.corporateViewModel.getEmptyLastNameTextFieldAlertViewTitle(), text: corporateView.corporateViewModel.getEmptyLastNameTextFieldAlertViewText(), viewController: self)
                return
            }
            // capital surname
            let capitalizedSurname = surname.capitalized
            // prepare the view
            corporateView.surnameTextField.resignFirstResponder()
            DispatchQueue.main.async {
                self.corporateView.dimView.isHidden = false
                self.corporateView.activityIndicatorView.startAnimating()
            }
            formatSearchedDateToMatchFirebase(surname: capitalizedSurname)

        } else {
            UIAlertController.showAlert(title: corporateView.corporateViewModel.getNoNetworkAlertTitle(), text: corporateView.corporateViewModel.getNoNetworkAlertText(), viewController: self)
        }
    }
    
    private func formatSearchedDateToMatchFirebase(surname: String) {
        // format the date
        let dob = corporateView.datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let datestring = dateFormatter.string(from: dob)
        
        searchMemberUsing(datestring, surname)
    }
    
    private func searchMemberUsing(_ date: String, _ surname: String) {
        fetchedShmaIds = [String]()
        databaseManager.searchMemberUsing(date, surname) { (shmaId, wasFound) in
            if wasFound {
                guard let shmaId = shmaId else { return }
                self.fetchedShmaIds.append(shmaId)
            }
            self.attemptPresentationOfShmaIdsAlert()
        }
    }
    
    private func attemptPresentationOfShmaIdsAlert() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.presentAlert), userInfo: nil, repeats: false)
    }
    
    @objc func presentAlert() {
        DispatchQueue.main.async {
            self.corporateView.activityIndicatorView.stopAnimating()
            self.corporateView.dimView.isHidden = true
            UIAlertController.showAlert(title: self.corporateView.corporateViewModel.getShmaIdsAlertTitle(fetchedShmaIds: self.fetchedShmaIds), text: self.corporateView.corporateViewModel.getShmaIdsAlertText(fetchedShmaIds: self.fetchedShmaIds), viewController: self)
        }
    }
}
