//
//  FirebaseDatabaseManager.swift
//  SHMA
//
//  Created by Umar Yaqub on 04/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirebaseDatabaseManager {
    
    private let session: FirebaseDatabaseSession
    
    init(session: FirebaseDatabaseSession) {
        self.session = session
    }
    
    func searchMemberUsing(_ dob: String, _ surname: String, completion: @escaping (String?, Bool) -> Void) {
        session.searchMemberUsing(dob, surname) { (shmaId, memberFound) in
            completion(shmaId, memberFound)
        }
    }
    
    func fetchExistingMemberFromOfflineDatabaseUsing(_ shmaId: String, completion: @escaping (Bool, Member?) -> Void) {
        session.fetchExistingMemberFromOfflineDatabaseUsing(shmaId) { (success, member) in
            completion(success, member)
        }
    }
    
    func checkShmaIdIsntAlreadyRegisteredInFirebase(_ shmaId: String, completion: @escaping (Bool) -> Void) {
        session.checkShmaIdIsntAlreadyRegisteredInFirebase(shmaId) { (registered) in
            completion(registered)
        }
    }
    
    func saveExistingMemberDetailsToDatabase(_ uid: String, _ member: Member, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        session.saveExistingMemberDetailsToDatabase(uid, member) { (error, ref) in
            completion(error, ref)
        }
    }
    
    func generateNewMemberShmaId(completion: @escaping (Int) -> Void) {
        session.generateNewMemberShmaId { (shmaId) in
            completion(shmaId)
        }
    }
    
    func saveNewMemberDetailsToDatabase(_ uid: String, _ member: Member, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        session.saveNewMemberDetailsToDatabase(uid, member) { (error, ref) in
            completion(error, ref)
        }
    }
    
    func saveNewMemberFamilyDetailsToDatabase(_ uid: String, _ family: Family, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        session.saveNewMemberFamilyDetailsToDatabase(uid, family) { (error, ref) in
            completion(error, ref)
        }
    }
    
    func fetchAssociationDetails(completion: @escaping (Association) -> Void) {
        session.fetchAssociationDetails { (association) in
            completion(association)
        }
    }
    
    func fetchMemberDetails(_ uid: String, completion: @escaping (Member) -> Void) {
        session.fetchMemberDetails(uid) { (member) in
            completion(member)
        }
    }
    
    func fetchBusinessesDetailsFromFirebase(completion: @escaping (String, String, String, Int) -> Void) {
        session.fetchBusinessesDetailsFromFirebase { (placeId, iconUrl, discount, placeIdCount) in
            completion(placeId, iconUrl, discount, placeIdCount)
        }
    }
   
    func fetchFuneralContacts(completion: @escaping (FuneralContact) -> Void) {
        session.fetchFuneralContacts { (funeralContact) in
            completion(funeralContact)
        }
    }
}
