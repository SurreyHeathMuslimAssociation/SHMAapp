//
//  FirebaseDatabaseSession.swift
//  SHMA
//
//  Created by Umar Yaqub on 04/01/2019.
//  Copyright © 2019 SurreyHeathMuslimAssociation. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol FirebaseDatabaseSession {
    func searchMemberUsing(_ dob: String,_ lastName: String, completion: @escaping (String?, Bool) -> Void)
    func fetchExistingMemberFromOfflineDatabaseUsing(_ shmaId: String, completion: @escaping (Bool, Member?) -> Void)
    func checkShmaIdIsntAlreadyRegisteredInFirebase(_ shmaId: String, completion: @escaping (Bool) -> Void)
    func saveExistingMemberDetailsToDatabase(_ uid: String, _ member: Member, completion: @escaping (Error?, DatabaseReference?) -> Void)
    func generateNewMemberShmaId(completion: @escaping (Int) -> Void)
    func saveNewMemberDetailsToDatabase(_ uid: String, _ member: Member, completion: @escaping (Error?, DatabaseReference?) -> Void)
    func saveNewMemberFamilyDetailsToDatabase(_ uid: String, _ family: Family, completion: @escaping (Error?, DatabaseReference?) -> Void)
    func fetchAssociationDetails(completion: @escaping (Association) -> Void)
    func fetchMemberDetails(_ uid: String, completion: @escaping (Member) -> Void)
}
