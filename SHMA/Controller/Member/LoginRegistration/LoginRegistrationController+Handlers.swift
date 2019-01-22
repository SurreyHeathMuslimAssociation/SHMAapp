//
//  LoginRegistrationController+Handlers.swift
//  SHMA
//
//  Created by Umar Yaqub on 10/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseAuth
import NotificationBannerSwift

extension LoginRegistrationController {
    
    func handleLogIn() {
        viewLoading(true)
        guard let email = loginRegistrationView.emailTextField.text, let password = loginRegistrationView.passwordTextField.text else { return }
        // validates credentials from firebase
        firebaseAuthManager.signIn(with: email, password: password) { (result, err) in
            if let err = err {
                let code = AuthErrorCode(rawValue: err._code)
                self.showErrorAlert(with: code?.errorMessage ?? "", .danger)
                self.viewLoading(false)
                return
            }
            print("successfully signed in, send user to homepage")
            self.resignKeyboardAndSetTextFieldsToNil()
        }
    }
    
    func handleExistingMemberSignUp() {
        viewLoading(true)
        guard let email = loginRegistrationView.emailTextField.text, let password = loginRegistrationView.passwordTextField.text, let shmaId = loginRegistrationView.shmaIdTextField.text else { return }
        // check shma id provided exists
        checkShmaIdExistsWithInDatabase(shmaId: shmaId, email: email, password: password)
    }
    
    private func checkShmaIdExistsWithInDatabase(shmaId: String, email: String, password: String) {
        firebaseDatabaseManager.checkShmaIdExistsWithInOfflineDatabaseUsing(shmaId) { (exists, firstname, surname) in
            if exists {
                guard let firstname = firstname else { return }
                guard let surname = surname else { return }
                // check shma id isnt already registered to another user
                self.checkShmaIdIsntAlreadyRegistered(email, password, shmaId, firstname, surname)
            } else {
                self.showErrorAlert(with: "SHMA ID: \(shmaId) is invalid, please use a valid ID.", .danger)
                self.viewLoading(false)
            }
        }
    }
    
    func checkShmaIdIsntAlreadyRegistered(_ email: String, _ password: String, _ shmaId: String, _ firstname: String, _ surname: String) {
        firebaseDatabaseManager.checkShmaIdIsntAlreadyRegisteredInFirebase(shmaId) { (registered) in
            if registered {
                 self.showErrorAlert(with: "SHMA ID: \(shmaId) is already registered with another email", .danger)
                self.viewLoading(false)
                return
            }
            self.registerExistingMemberToFirebase(with: email, password, shmaId, firstname, surname)
        }
    }
    
    private func registerExistingMemberToFirebase(with email: String, _ password: String, _ shmaId: String, _ firstname: String, _ surname: String) {
        firebaseAuthManager.createUser(with: email, password: password) { (result, err) in
            if let err = err {
                let code = AuthErrorCode(rawValue: err._code)
                self.showErrorAlert(with: code?.errorMessage ?? "", .danger)
                self.viewLoading(false)
                return
            }
            print("successfully created user in firebase auth")
            guard let uid = result?.user.uid else { return }
            self.saveExistingMemberDetailsToDatabase(uid: uid, shmaId: shmaId, firstname: firstname, surname: surname, email: email)
        }
    }
    
    private func saveExistingMemberDetailsToDatabase(uid: String, shmaId: String, firstname: String, surname: String, email: String) {
        firebaseDatabaseManager.saveExistingMemberDetailsToDatabase(uid, shmaId, firstname, surname, email) { (err, ref) in
            if let err = err {
                let code = AuthErrorCode(rawValue: err._code)
                self.showErrorAlert(with: code?.errorMessage ?? "", .danger)
                self.viewLoading(false)
                return
            }
            print("registration complete, send user to home")
            self.resignKeyboardAndSetTextFieldsToNil()
        }
    }
    
    func determineIfMemberDetailRequirementsAreMet() {
        viewLoading(true)
        guard let name = loginRegistrationView.nameTextField.text, name.count > 0, let email = loginRegistrationView.emailTextField.text, email.count > 0, let password = loginRegistrationView.passwordTextField.text, password.count > 0, let dob = loginRegistrationView.dobTextField.text, dob.count > 0, let addressLineOne = loginRegistrationView.addressLineOneTextField.text, addressLineOne.count > 0, let addressLineTwo = loginRegistrationView.addressLineTwoTextField.text, addressLineTwo.count > 0, let town = loginRegistrationView.townTextField.text, town.count > 0, let postcode = loginRegistrationView.postcodeTextField.text, postcode.count > 0, let mobileNo = loginRegistrationView.mobileNoTextField.text, mobileNo.count > 0 else {
            // display alert if any fields are empty
            showErrorAlert(with: "Please ensure all fields are filled in", .danger)
            viewLoading(false)
            return
        }
        // assigning member detail variables
        memberName = name; memberEmail = email; memberPassword = password; memberDob = dob; memberAddressLineOne = addressLineOne; memberAddressLineTwo = addressLineTwo; memberTown = town; memberPostcode = postcode; memberMobileNo = mobileNo

        appendNewMemberSpouseDetails()
    }
    
    private func appendNewMemberSpouseDetails() {
        // get family details
        if loginRegistrationView.membershipSwitch.isOn {
            let spouseCell = loginRegistrationView.spouseChildTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SpouseChildCell
            guard let spouseName = spouseCell?.nameTextField.text, spouseName.count > 0, let spouseDob = spouseCell?.dobTextField.text, spouseDob.count > 0 else {
                showErrorAlert(with: "Please ensure you provide your Spouse's Name and D.O.B", .danger)
                viewLoading(false)
                return
            }
            family = [Family]()
            let spouseEmail = spouseCell?.emailTextField.text ?? ""
            var spouse = Family(fullName: spouseName, dob: spouseDob, relationship: .Spouse)
            spouse.email = spouseEmail
            family?.append(spouse)
            appendNewMemberChildrenDetails()
        } else {
            presentTermsAndConditionsIfRequirementsAreMet()
            
        }
    }
    
    private func appendNewMemberChildrenDetails() {
        // append child if present
        let childCells = loginRegistrationView.childCells
        var wasChildLeftEmpty = false
        childCells?.forEach({ (childCell) in
            guard let childName = childCell.nameTextField.text, childName.count > 0, let childDob = childCell.dobTextField.text, childDob.count > 0 else {
                wasChildLeftEmpty = true
                return
            }
            let child = Family(fullName: childName, dob: childDob, relationship: .Child)
            family?.append(child)
        })
        if wasChildLeftEmpty {
            showErrorAlert(with: "If the child was mistakenly added please remove the row by swiping left.", .danger)
            viewLoading(false)
            return
        }
        presentTermsAndConditionsIfRequirementsAreMet()
    }
    
    private func presentTermsAndConditionsIfRequirementsAreMet() {
        let nav = UINavigationController(rootViewController: TermsAndConditionsController())
        present(nav, animated: true, completion: nil)
    }
    
    @objc func termsAgreedHandleMemberRegisteration() {
        firebaseAuthManager.createUser(with: memberEmail, password: memberPassword) { (result, err) in
            if let err = err {
                let code = AuthErrorCode(rawValue: err._code)
                self.showErrorAlert(with: code?.errorMessage ?? "", .danger)
                self.viewLoading(false)
                return
            }
            print("successfully created user in firebase auth")
            guard let uid = result?.user.uid else { return }
            self.saveNewMemberDetailsToDatabase(uid)
        }
    }
    
    private func saveNewMemberDetailsToDatabase(_ uid: String) {
        var components = memberName.components(separatedBy: " ")
        if components.count > 0 {
            let firstName = components.removeFirst().capitalized
            let surname = components.joined(separator: " ").capitalized
            firebaseDatabaseManager.saveNewMemberDetailsToDatabase(uid, firstName, surname, memberEmail, memberDob, memberAddressLineOne, memberAddressLineTwo, memberTown, memberPostcode, memberMobileNo) { (err, _) in
                if let err = err {
                    let code = AuthErrorCode(rawValue: err._code)
                    self.showErrorAlert(with: code?.errorMessage ?? "", .danger)
                    self.viewLoading(false)
                    return
                }
                print("user saved, save fam details")
                self.saveNewMemberFamilyDetailsToDatabase(uid)
            }
        }
    }
    
    private func saveNewMemberFamilyDetailsToDatabase(_ uid: String) {
        family?.forEach({ (fam) in
            if fam.relationship == .Spouse {
                saveNewMemberSpouseDetailsToDatabase(uid, fam.fullName, fam.email ?? "", fam.dob)
            } else {
                saveNewMemberChildrenDetailsToDatabase(uid, fam.fullName, fam.dob)
            }
        })
        resignKeyboardAndSetTextFieldsToNil()
        resignSpouseTableviewKeyboardAndSetTextFieldsToNil()
        viewLoading(false)
        print("registration complete, send user to home")
    }
    
    private func saveNewMemberSpouseDetailsToDatabase(_ uid: String, _ name: String, _ email: String, _ dob: String) {
        let capitalisedName = name.capitalized
        firebaseDatabaseManager.saveNewMembersSpouseDetailsToDatabase(uid, capitalisedName, email, dob, completion: { (err, _) in
            if let err = err {
                let code = AuthErrorCode(rawValue: err._code)
                self.showErrorAlert(with: code?.errorMessage ?? "", .danger)
                self.viewLoading(false)
                return
            }
            print("Spouse saved")
        })
    }
    
    private func saveNewMemberChildrenDetailsToDatabase(_ uid: String, _ name: String, _ dob: String) {
        let capitalisedName = name.capitalized
        firebaseDatabaseManager.saveNewMembersChildrenDetailsToDatabase(uid, capitalisedName, dob) { (err, _) in
            if let err = err {
                let code = AuthErrorCode(rawValue: err._code)
                self.showErrorAlert(with: code?.errorMessage ?? "", .danger)
                self.viewLoading(false)
                return
            }
            print("Child saved")
        }
    }
    
    private func test() {
        
    }
    
    private func resignKeyboardAndSetTextFieldsToNil() {
        loginRegistrationView.activityIndicatorView.stopAnimating()
        loginRegistrationView.shmaIdTextField.resignFirstResponder()
        loginRegistrationView.emailTextField.resignFirstResponder()
        loginRegistrationView.passwordTextField.resignFirstResponder()
        loginRegistrationView.nameTextField.resignFirstResponder()
        loginRegistrationView.dobTextField.resignFirstResponder()
        loginRegistrationView.addressLineOneTextField.resignFirstResponder()
        loginRegistrationView.addressLineTwoTextField.resignFirstResponder()
        loginRegistrationView.townTextField.resignFirstResponder()
        loginRegistrationView.postcodeTextField.resignFirstResponder()
        loginRegistrationView.mobileNoTextField.resignFirstResponder()
        loginRegistrationView.shmaIdTextField.text = nil
        loginRegistrationView.emailTextField.text = nil
        loginRegistrationView.passwordTextField.text = nil
        loginRegistrationView.nameTextField.text = nil
        loginRegistrationView.dobTextField.text = nil
        loginRegistrationView.addressLineOneTextField.text = nil
        loginRegistrationView.addressLineTwoTextField.text = nil
        loginRegistrationView.townTextField.text = nil
        loginRegistrationView.postcodeTextField.text = nil
        loginRegistrationView.mobileNoTextField.text = nil
    }
    
    private func resignSpouseTableviewKeyboardAndSetTextFieldsToNil() {
        let spouseCell = loginRegistrationView.spouseChildTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SpouseChildCell
        spouseCell?.nameTextField.resignFirstResponder()
        spouseCell?.emailTextField.resignFirstResponder()
        spouseCell?.dobTextField.resignFirstResponder()
        spouseCell?.nameTextField.text = nil
        spouseCell?.emailTextField.text = nil
        spouseCell?.dobTextField.text = nil
        let childCells = loginRegistrationView.childCells
        childCells?.forEach({ (childCell) in
            childCell.nameTextField.resignFirstResponder()
            childCell.dobTextField.resignFirstResponder()
            childCell.nameTextField.text = nil
            childCell.dobTextField.text = nil
        })
    }
    
    private func viewLoading(_ loading: Bool) {
        DispatchQueue.main.async {
            if loading {
                self.loginRegistrationView.activityIndicatorView.startAnimating()
            } else {
                self.loginRegistrationView.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    private func showErrorAlert(with text: String, _ bannerStyle: BannerStyle) {
        let iv = UIImageView(image: UIImage(named: "Error"))
        let banner = NotificationBanner(title: "Error", subtitle: text, leftView: nil, rightView: iv, style: bannerStyle, colors: nil)
        banner.show()
    }
}
