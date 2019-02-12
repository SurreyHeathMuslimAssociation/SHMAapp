//
//  ProfileController+Datasource.swift
//  SHMA
//
//  Created by Umar Yaqub on 02/02/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension ProfileController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProfileCell
        cell.profileViewModel = profileViewModel
        cell.detail = memberDetails[indexPath.row]
        cell.label = memberLabels[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberLabels.count
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerId) as! ProfileFooter
        footer.profileViewModel = profileViewModel
        return footer
    }
}
