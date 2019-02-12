//
//  BusinessController+Delegate.swift
//  SHMA
//
//  Created by Umar Yaqub on 11/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension BusinessController: BusinessViewDelegate {
    
    func didTapCell(businessViewModel: BusinessViewModel) {
        let businessDetailController = BusinessDetailController()
        businessDetailController.businessViewModel = businessViewModel
        navigationController?.pushViewController(businessDetailController, animated: true)
    }
    
    
}
