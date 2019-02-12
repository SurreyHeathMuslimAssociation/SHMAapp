//
//  ProfileController.swift
//  SHMA
//
//  Created by Umar Yaqub on 22/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileController: UITableViewController {
    
    var firebaseAuthManager: FirebaseAuthManager!
    var firebaseDatabaseManager: FirebaseDatabaseManager!
    let cellId = "cellId"
    let footerId = "footerId"
    var member: Member!
    var profileViewModel: ProfileViewModel!
    var memberDetails = [String]()
    var memberLabels = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // removes tableview header space
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        tableView.tableHeaderView = UIView(frame: frame)
       
        // initialise auth manager
        firebaseAuthManager = FirebaseAuthManager(session: Auth.auth())
        // initialise view model
        profileViewModel = ProfileViewModel(traitCollection, member)
        
        registerCellAndFooter()
        setupNavBar()
        setupMemberLabels()
        setupMemberDetails()
    }
    
    private func registerCellAndFooter() {
        tableView.register(ProfileCell.self, forCellReuseIdentifier: cellId)
        tableView.register(ProfileFooter.self, forHeaderFooterViewReuseIdentifier: footerId)
    }
    
    private func setupNavBar() {
        navigationItem.title = profileViewModel.getNavigationBarTitle()
        navigationController?.navigationBar.titleTextAttributes = profileViewModel.getNavigationBarTitleTextAttributes()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogOut(sender:)))
    }
    
    private func setupMemberLabels() {
        memberLabels.append("Membership Status")
        memberLabels.append("First Name")
        memberLabels.append("Middle Name")
        memberLabels.append("Last Name")
        memberLabels.append("D.O.B")
        memberLabels.append("Email")
        memberLabels.append("Membership Type")
    }
    
    private func setupMemberDetails() {
        memberDetails.append(member.status ?? "")
        memberDetails.append(member.firstName)
        memberDetails.append(member.middleName ?? "")
        memberDetails.append(member.lastName)
        memberDetails.append(member.dob ?? "")
        memberDetails.append(member.email ?? "")
        memberDetails.append(member.membershipType)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
