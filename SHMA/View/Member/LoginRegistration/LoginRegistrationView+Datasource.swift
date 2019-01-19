//
//  LoginRegistrationView+Datasource.swift
//  SHMA
//
//  Created by Umar Yaqub on 16/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit

extension LoginRegistrationView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return header.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return childRows.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SpouseChildCell
            cell.loginRegistrationViewModel = loginRegistrationViewModel
            cell.delegate = self
            cell.isChildCell = false
            return cell
        } else {
            if indexPath.row < childRows.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SpouseChildCell
                cell.loginRegistrationViewModel = loginRegistrationViewModel
                cell.delegate = self
                cell.isChildCell = true
                childCells?.append(cell)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: addChildCellId, for: indexPath) as! AddSpouseChildCell
                cell.loginRegisterViewModel = loginRegistrationViewModel
                cell.delegate = self
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            childRows.remove(at: indexPath.row)
            childCells?.remove(at: indexPath.row)
            spouseChildTableView?.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            if indexPath.row < childRows.count {
                return true
            }
        }
        return false
    }
}
