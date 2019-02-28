//
//  InitialController+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 22/12/2018.
//  Copyright © 2018 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension InitialController: InitialViewDelegate {
    func didPressCorporate() {
        let businessController = BusinessController()
        navigationController?.pushViewController(businessController, animated: true)
    }
    
    func didPressMember() {
        navigationController?.pushViewController(MemberController(), animated: true)
    }
}
