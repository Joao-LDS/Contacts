//
//  FirestoreService.swift
//  Contacts
//
//  Created by João Luis Santos on 16/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Firebase

enum FirestoreReference: String {
    case users = "Users"
    case contacts = "Contacts"
}

class FirestoreService {
    
    let db = Firestore.firestore()
    
    func update(user: User, reference: FirestoreReference) {
        
    }
}
