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
        if indexPath.section == 0 || indexPath.row < childRows.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SpouseChildCell
            if indexPath.section == 0 {
                cell.isChildCell = false
            } else {
                cell.isChildCell = true
            }
            cell.delegate = self
            cell.loginRegistrationViewModel = loginRegistrationViewModel
            spouseChildCells?.append(cell)
            if childRows.count > 4 {
                spouseChildTableViewDelegate?.disableAddChildButton()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: addChildCellId, for: indexPath) as! AddSpouseChildCell
            cell.loginRegisterViewModel = loginRegistrationViewModel
            cell.delegate = self
            spouseChildTableViewDelegate = cell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            childRows.remove(at: indexPath.row)
            spouseChildCells?.remove(at: indexPath.row + 1)
            spouseChildTableView?.deleteRows(at: [indexPath], with: .automatic)
            spouseChildTableViewDelegate?.enableAddChildButton()
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
