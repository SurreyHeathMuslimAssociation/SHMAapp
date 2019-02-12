//
//  ProfileController+Delegate.swift
//  SHMA
//
//  Created by Umar Yaqub on 02/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension ProfileController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return profileViewModel.getTableViewCellHeightForEachDevice()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return profileViewModel.getTableViewFooterHeightForEachDevice()
    }
}
