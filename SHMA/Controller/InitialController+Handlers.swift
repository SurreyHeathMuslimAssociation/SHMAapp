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
        navigationController?.pushViewController(CorporateController(), animated: true)
    }
    
    func didPressMember() {
        navigationController?.pushViewController(MemberController(), animated: true)
    }
}
