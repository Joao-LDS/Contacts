//
//  ManagerContact.swift
//  Contacts
//
//  Created by João Luis Santos on 23/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

class ManagerContact {
    
    let coreDataStack = CoreDataStack.shared
    let firestoreService = FirestoreService.shared
    let firestorageService = FirestorageService.shared
    
    func managerSynchronization() {
        
        let contactsFromCoreData = coreDataStack.fetchContacts()
        
        firestoreService.fetchAll { values in
            if values.isEmpty == false, let contactsFromCoreData = contactsFromCoreData {
                
                var idsContacsFromCoreData: [String] = []
                for contact in contactsFromCoreData {
                    idsContacsFromCoreData.append(contact.id!)
                }
                
                var idsFromContactsFromFirestore: [String] = []
                for value in values {
                    let id = value["id"] as! String
                    idsFromContactsFromFirestore.append(id)
                }
                
                // Compara os dois array para saber quais Contatos já estão no device e quais devem ser buscados do firestore
                let setByIdsCoreData = Set(idsContacsFromCoreData)
                let setByIdsFirestore = Set(idsFromContactsFromFirestore)
                let idsToGetFirestore: [String] = Array(setByIdsCoreData.symmetricDifference(setByIdsFirestore))
                
                if idsToGetFirestore.isEmpty == false {
                    self.getPhotoFirestorage(ids: idsToGetFirestore)
                }
            }
        }
    }
    
    func getPhotoFirestorage(ids: [String]) {
        self.firestorageService.fetch(at: ids) { finish in
            if finish == true {
                self.getDataStorage(ids: ids)
            }
        }
    }
    
    func getDataStorage(ids: [String]) {
        for id in ids {
            self.firestoreService.fetchContactById(at: id) { values in
                if let values = values {
                    self.createObjectContact(with: values)
                }
            }
        }
    }
    
    func createObjectContact(with values: [String: Any]) {
        let id = values["id"] as? String
        
        let contact = Contact(entity: self.coreDataStack.entity, insertInto: self.coreDataStack.context)
        contact.id = id
        contact.name = values["name"] as? String
        contact.phone = values["phone"] as? String
        contact.email = values["email"] as? String
        contact.address = values["address"] as? String
        let groupName = values["group"] as? String
        contact.group = self.createObjectGroup(name: groupName)
        let photo = try! Data(contentsOf: DocumentDirectory().urlToImages(id!))
        contact.photo = photo
        
        self.coreDataStack.save()
        
    }
    
    func createObjectGroup(name: String?) -> Group? {
        if let name = name, name != Constants.String.empty {
            let group = Group(context: coreDataStack.context)
            group.name = name
            return group
        } else {
            return nil
        }
    }
    
}
