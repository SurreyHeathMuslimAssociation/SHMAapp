//
//  FirebaseDatabase+Util.swift
//  SHMA
//
//  Created by Umar Yaqub on 04/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension Database: FirebaseDatabaseSession {
    // sorts on client side, possibly future improvement
    func searchMemberUsing(_ dob: String, _ surname: String, completion: @escaping (String?, Bool) -> Void) {
        Database.database().reference().child("offline_members").observeSingleEvent(of: .value) { (snapshot) in
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            allObjects.forEach({ (snapshot) in
                guard let member = snapshot.value as? [String: Any] else { return }
                let memberDOB = member["DOB"] as? String
                let memberSurname = member["surname"] as? String
                if dob == memberDOB && surname == memberSurname {
                    let shmaId = snapshot.key
                    completion(shmaId, true)
                } else {
                    completion(nil, false)
                }
            })
        }
    }
    
    func fetchExistingMemberFromOfflineDatabaseUsing(_ shmaId: String, completion: @escaping (Bool, Member?) -> Void) {
        Database.database().reference().child("offline_members").queryOrderedByKey().queryEqual(toValue: shmaId).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
                allObjects.forEach({ (snapshot) in
                    guard let value = snapshot.value as? [String: Any] else { return }
                    print(value)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                        let member = try JSONDecoder().decode(Member.self, from: jsonData)
                        completion(true, member)
                    } catch {
                        print(error.localizedDescription)
                        completion(false, nil)
                    }
                })
            } else {
                completion(false, nil)
            }
        }
    }
    
    func checkShmaIdIsntAlreadyRegisteredInFirebase(_ shmaId: String, completion: @escaping (Bool) -> Void) {
        Database.database().reference().child("shmaIdsOnApp").queryOrderedByKey().queryEqual(toValue: shmaId).observeSingleEvent(of: .value) { (snapshot) in
            if let _ = snapshot.value as? [String: Any] {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func saveExistingMemberDetailsToDatabase(_ uid: String, _ member: Member, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(member) {
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: encoded, options: []) as? [String: Any] else { return }
                Database.database().reference().child("members").child(uid).updateChildValues(jsonData) { (error, ref) in
                    completion(error, ref)
                }
            } catch {
                completion(error, nil)
            }
        }
    }
    
    func generateNewMemberShmaId(completion: @escaping (Int) -> Void) {
        // get the lastest key (shmaId) that exists in member_search
        let query = Database.database().reference().child("offline_members").queryOrderedByKey().queryLimited(toLast: 1)
        query.observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? [String: Any]
            guard let key = value?.keys.first else { return }
            guard let offlineDatabaseShmaId = Int(key) else { return }
            // get the latest shmaid that exists among the members signed up on the app
            let query = Database.database().reference().child("shmaIdsOnApp").queryOrderedByKey().queryLimited(toLast: 1)
            query.observeSingleEvent(of: .value) { (snapshot) in
                // if members table exists
                if snapshot.exists() {
                    let value = snapshot.value as? [String: Any]
                    let shmaId = Int(value?.keys.first ?? "") ?? 0
                    print(shmaId)
                    // gets the highest value and adds 1 to create a new shmaId
                    if shmaId > offlineDatabaseShmaId {
                        completion(shmaId + 1)
                    } else {
                        completion(offlineDatabaseShmaId + 1)
                    }
                } else {
                    // else just get the highest value from offline members
                    completion(offlineDatabaseShmaId + 1)
                }
            }
        }
    }
    
    func saveNewMemberDetailsToDatabase(_ uid: String, _ member: Member, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(member) {
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: encoded, options: []) as? [String: Any] else { return }
                Database.database().reference().child("members").child(uid).updateChildValues(jsonData) { (error, ref) in
                    completion(error, ref)
                }
            } catch {
                completion(error, nil)
            }
        }
    }
    
    func saveNewMemberFamilyDetailsToDatabase(_ uid: String, _ family: Family, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        guard let relationship = family.relationship else { return }
        let spouseRef = Database.database().reference().child("spouse").child(uid)
        let childRef = Database.database().reference().child("children").child(uid).childByAutoId()
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(family) {
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: encoded, options: []) as? [String: Any] else { return }
                if relationship == .Spouse {
                    spouseRef.updateChildValues(jsonData) { (error, ref) in
                        completion(error, ref)
                    }
                } else {
                    childRef.updateChildValues(jsonData) { (error, ref) in
                        completion(error, ref)
                    }
                }
            } catch {
                completion(error, nil)
            }
        }
    }
    
    func fetchAssociationDetails(completion: @escaping (Association) -> Void) {
        Database.database().reference().child("association").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [String: Any] else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                let association = try JSONDecoder().decode(Association.self, from: jsonData)
                completion(association)
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func fetchMemberDetails(_ uid: String, completion: @escaping (Member) -> Void) {
        Database.database().reference().child("members").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value as? [String: Any] else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                let member = try JSONDecoder().decode(Member.self, from: jsonData)
                completion(member)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchBusinessesPlaceIdAndIconUrl(completion: @escaping (String, String) -> Void) {
        Database.database().reference().child("businesses").observeSingleEvent(of: .value) { (snapshot) in
            guard let allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            allObjects.forEach({ (snapshot) in
                let placeId = snapshot.key
                guard let iconUrl = snapshot.value as? String else { return }
                completion(placeId, iconUrl)
            })
           
        }
    }
   
}
