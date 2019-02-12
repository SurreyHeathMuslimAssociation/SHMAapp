//
//  BusinessDetailView+Delegate.swift
//  SHMA
//
//  Created by Umar Yaqub on 11/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension BusinessDetailView: UITableViewDelegate, ProfileFooterDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return businessViewModel?.getBusinessDetailViewHeaderHeight() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return businessViewModel?.getBusinessDetailViewFooterHeight() ?? 0
    }
    
    func didTapGetDirections() {
        businessDetailViewDelegate?.didTapGetDirections()
    }
}
