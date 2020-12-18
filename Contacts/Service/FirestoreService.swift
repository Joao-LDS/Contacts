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
    
    static let shared = FirestoreService()
    let dbRef = Firestore.firestore()
    let userId = AuthService().userId()
    
    func write(_ values: [String: Any]) {
        let set = FirestoreSettings()
        set.isPersistenceEnabled = true
        dbRef.settings = set
        dbRef.collection(self.userId).addDocument(data: values)
    }
    
    func whereField(id: String, completion: @escaping(QueryDocumentSnapshot?) -> Void) {
        dbRef.collection(self.userId).whereField("id", isEqualTo: id).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            let contact = snapshot?.documents[0]
            completion(contact)
        }
    }
    
    func update(at id: String,with values: [String: Any]) {
        whereField(id: id) { document in
            self.dbRef.collection(self.userId).document(document!.documentID).updateData(values)
        }
    }
    
    func fetch(at id: String) {
        dbRef.collection(id).getDocuments { snapshot, error in
            if let documents = snapshot?.documents {
                for document in documents {
                    let values = document.data()
                    let id = document.documentID
                    print(values, id)
                }
            }
        }
    }
    
    func delete(at id: String) {
        whereField(id: id) { document in
            self.dbRef.collection(self.userId).document(document!.documentID).delete()
        }
    }
    
}
