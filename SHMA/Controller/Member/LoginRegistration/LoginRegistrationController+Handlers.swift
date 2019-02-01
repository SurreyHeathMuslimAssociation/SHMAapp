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
import FirebaseDatabase

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
            print("successfully signed in")
            guard let user = result?.user else { return }
            
            // check if user has verified email
            if user.isEmailVerified {
                self.resignKeyboardAndSetTextFieldsToNil()
                self.present(MemberTabBarController(), animated: true, completion: nil)
            } else {
                self.viewLoading(false)
                self.showErrorAlert(with: "Your email is not verified, please verify using the link sent in your email.", .danger)
                // sign user out
                self.firebaseAuthManager.signOut(completion: { (success, err) in
                    print(success)
                })
            }
        }
    }
    
    func handleExistingMemberSignUp() {
        viewLoading(true)
        guard let email = loginRegistrationView.emailTextField.text, let password = loginRegistrationView.passwordTextField.text, let shmaId = loginRegistrationView.shmaIdTextField.text else { return }
        // check id isnt already registered to another user
        checkShmaIdIsntAlreadyRegistered(email, password, shmaId)
    }
    
    func checkShmaIdIsntAlreadyRegistered(_ email: String, _ password: String, _ shmaId: String) {
        firebaseDatabaseManager.checkShmaIdIsntAlreadyRegisteredInFirebase(shmaId) { (isRegistered) in
            if isRegistered {
                self.showErrorAlert(with: "SHMA ID: \(shmaId) is already registered with another email", .danger)
                self.viewLoading(false)
                return
            }
            // check shma id provided exists
            self.fetchExistingMemberFromOfflineDatabase(shmaId: shmaId, email: email, password: password)
        }
    }
    
    private func fetchExistingMemberFromOfflineDatabase(shmaId: String, email: String, password: String) {
        firebaseDatabaseManager.fetchExistingMemberFromOfflineDatabaseUsing(shmaId) { (success, member) in
            if success {
                guard let member = member else { return }
                guard let shmaId = Int(shmaId) else { return }
                member.shmaId = shmaId
                member.email = email
                member.status = "Approved"
                self.registerExistingMemberToFirebase(member, password)
            } else {
                self.showErrorAlert(with: "SHMA ID: \(shmaId) is invalid, please use a valid ID.", .danger)
                self.viewLoading(false)
            }
        }
    }
    
    private func registerExistingMemberToFirebase(_ member: Member, _ password: String) {
        // create user
        firebaseAuthManager.createUser(with: member.email ?? "", password: password) { (result, err) in
            if let err = err {
                let code = AuthErrorCode(rawValue: err._code)
                self.showErrorAlert(with: code?.errorMessage ?? "", .danger)
                self.viewLoading(false)
                return
            }
            print("successfully created user in firebase auth")
            // send verification email, to verify users account
            guard let user = result?.user else { return }
            self.sendEmailVerification(user: user)
            self.saveExistingMemberDetailsToDatabase(user.uid, member)
        }
    }
    
    private func sendEmailVerification(user: User) {
        self.firebaseAuthManager.sendEmailVerification(user, completion: { (err) in
            if let err = err {
                let code = AuthErrorCode(rawValue: err._code)
                self.showErrorAlert(with: code?.errorMessage ?? "", .danger)
                self.viewLoading(false)
                return
            }
            print("successfully sent verification email")
        })
    }
    
    private func saveExistingMemberDetailsToDatabase(_ uid: String, _ member: Member) {
        firebaseDatabaseManager.saveExistingMemberDetailsToDatabase(uid, member) { (err, _) in
            if let err = err {
                let code = AuthErrorCode(rawValue: err._code)
                self.showErrorAlert(with: code?.errorMessage ?? "", .danger)
                self.viewLoading(false)
                return
            }
            self.resignKeyboardAndSetTextFieldsToNil()
            self.viewLoading(false)
            print("existing registration complete, send user to welcome page")
            let tabBarController = MemberTabBarController()
            tabBarController.isNavAndTabBarHidden = true
            self.present(tabBarController, animated: true, completion: nil)
            self.signUserOut()
        }
    }
    
    private func signUserOut() {
        firebaseAuthManager.signOut(completion: { (success, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
        })
    }
    
    func determineIfMemberDetailRequirementsAreMet() {
        viewLoading(true)
        guard let name = loginRegistrationView.nameTextField.text, name.count > 0, let email = loginRegistrationView.emailTextField.text, email.count > 0, let password = loginRegistrationView.passwordTextField.text, password.count > 0, let dob = loginRegistrationView.dobTextField.text, dob.count > 0, let addressLineOne = loginRegistrationView.addressLineOneTextField.text, addressLineOne.count > 0, let town = loginRegistrationView.townTextField.text, town.count > 0, let postcode = loginRegistrationView.postcodeTextField.text, postcode.count > 0, let mobileNo = loginRegistrationView.mobileNoTextField.text, mobileNo.count > 0 else {
            // display alert if any fields are empty
            showErrorAlert(with: "Please ensure all fields are filled in", .danger)
            viewLoading(false)
            return
        }
        // optional details
        let addressLineTwo = loginRegistrationView.addressLineTwoTextField.text ?? ""
        let county = loginRegistrationView.countyTextField.text ?? ""
        // verify age over 19
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let dateOfBirth = dateFormatter.date(from: dob) else { return }
        let ageComponents = Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date())
        guard let age = ageComponents.year, age > 18 else {
            showErrorAlert(with: "You need to be atleast 19 years old to be a member.", .danger)
            viewLoading(false)
            return
        }
        // assigning member detail variables
        memberName = name; memberEmail = email; memberPassword = password; memberDob = dob; memberAddressLineOne = addressLineOne; memberAddressLineTwo = addressLineTwo; memberTown = town; memberCounty = county; memberPostcode = postcode; memberMobileNo = mobileNo; memberStatus = "Applied"

        getNewMemberFamilyDetails()
    }
    
    private func getNewMemberFamilyDetails() {
        // get family details
        if loginRegistrationView.membershipSwitch.isOn {
            family = [Family]()
            membershipType = "Family"
            wasCellLeftEmpty = false
            wasChild19 = false
            let spouseChildCells = loginRegistrationView.spouseChildCells
            spouseChildCells?.forEach({ (spouseChildCell) in
                guard let spouseChildName = spouseChildCell.nameTextField.text, spouseChildName.count > 0, let spouseChildDob = spouseChildCell.dobTextField.text, spouseChildDob.count > 0 else {
                    wasCellLeftEmpty = true
                    return
                }
                // email is only present for spouse
                let spouseEmail = spouseChildCell.emailTextField.text ?? ""
                appendNewMemberFamilyDetails(spouseChildCell, spouseChildName, spouseEmail, spouseChildDob)
            })
            if wasCellLeftEmpty {
                showErrorAlert(with: "Please ensure you provide your Spouse's and Children (if present) Name and D.O.B", .danger)
                viewLoading(false)
                return
            }
            if wasChild19 {
                showErrorAlert(with: "You child needs to be under 19 to be covered.", .danger)
                viewLoading(false)
                return
            }
            presentTermsAndConditionsIfRequirementsAreMet()
        } else {
            membershipType = "Single"
            presentTermsAndConditionsIfRequirementsAreMet()
        }
    }
    
    private func appendNewMemberFamilyDetails(_ spouseChildCell: SpouseChildCell, _ spouseChildName: String, _ spouseEmail: String, _ spouseChildDob: String) {
        let value = ["fullName": spouseChildName, "email": spouseEmail, "DOB": spouseChildDob]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
            let spouseAndChildren = try JSONDecoder().decode(Family.self, from: jsonData)
            if spouseChildCell.isChildCell == true {
                // verify age under 19
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                guard let dateOfBirth = dateFormatter.date(from: spouseChildDob) else { return }
                let ageComponents = Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date())
                guard let age = ageComponents.year, age < 19 else {
                    wasChild19 = true
                    return
                }
                spouseAndChildren.relationship = .Child
            } else {
                spouseAndChildren.relationship = .Spouse
            }
            family?.append(spouseAndChildren)
        } catch {
            print(error.localizedDescription)
        }
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
            guard let user = result?.user else { return }
            self.generateNewMemberShmaId(user.uid)
            self.sendEmailVerification(user: user)
        }
    }
    
    @objc func termsDisagreed() {
        viewLoading(false)
    }
    
    private func generateNewMemberShmaId(_ uid: String) {
        firebaseDatabaseManager.generateNewMemberShmaId { (shmaId) in
            self.saveNewMemberDetailsToDatabase(uid, shmaId)
        }
    }
    
    private func saveNewMemberDetailsToDatabase(_ uid: String, _ shmaId: Int) {
        let components = memberName.components(separatedBy: " ")
        if components.count > 0 {
            // extract first, middle and last names
            guard let firstName = components.first?.capitalized else { return }
            let middleNameComponents = components.dropFirst().dropLast()
            let middleName = middleNameComponents.joined(separator: " ").capitalized
            guard let lastName = components.last?.capitalized else { return }
            // defines json value
            let value = ["firstName": firstName, "middleName": middleName, "lastName": lastName, "email": memberEmail, "DOB": memberDob, "addressLineOne": memberAddressLineOne, "addressLineTwo": memberAddressLineTwo, "town": memberTown, "county": memberCounty, "postcode": memberPostcode, "mobileNo": memberMobileNo, "status": memberStatus, "membershipType": membershipType, "shmaId": shmaId] as [String : Any]
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                let member = try JSONDecoder().decode(Member.self, from: jsonData)
                firebaseDatabaseManager.saveNewMemberDetailsToDatabase(uid, member) { (err, _) in
                    if let err = err {
                        let code = AuthErrorCode(rawValue: err._code)
                        self.showErrorAlert(with: code?.errorMessage ?? "", .danger)
                        self.viewLoading(false)
                        return
                    }
                    print("user saved, save fam details")
                    self.saveNewMemberFamilyDetailsToDatabase(uid, shmaId)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveNewMemberFamilyDetailsToDatabase(_ uid: String, _ shmaId: Int) {
        family?.forEach({ (fam) in
            firebaseDatabaseManager.saveNewMemberFamilyDetailsToDatabase(uid, fam, completion: { (err, _) in
                if let err = err {
                    let code = AuthErrorCode(rawValue: err._code)
                    self.showErrorAlert(with: code?.errorMessage ?? "", .danger)
                    self.viewLoading(false)
                    return
                }
                print("family saved")
            })
        })
        resignKeyboardAndSetTextFieldsToNil()
        resignSpouseTableviewKeyboardAndSetTextFieldsToNil()
        viewLoading(false)
        let tabBarController = MemberTabBarController()
        tabBarController.isNavAndTabBarHidden = true
        present(tabBarController, animated: true, completion: nil)
        print("registration complete, send user to setup standing order screen")
        self.signUserOut()
    }
    
    private func resignKeyboardAndSetTextFieldsToNil() {
        activityIndicatorView.stopAnimating()
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
        loginRegistrationView.countyTextField.resignFirstResponder()
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
        loginRegistrationView.countyTextField.text = nil
    }
    
    private func resignSpouseTableviewKeyboardAndSetTextFieldsToNil() {
        let spouseCell = loginRegistrationView.spouseChildTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SpouseChildCell
        spouseCell?.nameTextField.resignFirstResponder()
        spouseCell?.emailTextField.resignFirstResponder()
        spouseCell?.dobTextField.resignFirstResponder()
        spouseCell?.nameTextField.text = nil
        spouseCell?.emailTextField.text = nil
        spouseCell?.dobTextField.text = nil
        let childCells = loginRegistrationView.spouseChildCells
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
                self.activityIndicatorView.startAnimating()
            } else {
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    private func showErrorAlert(with text: String, _ bannerStyle: BannerStyle) {
        let iv = UIImageView(image: UIImage(named: "Error"))
        let banner = NotificationBanner(title: "Error", subtitle: text, leftView: nil, rightView: iv, style: bannerStyle, colors: nil)
        banner.show()
    }
}
