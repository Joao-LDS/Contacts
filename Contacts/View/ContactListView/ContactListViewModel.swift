//
//  ContactListViewModel.swift
//  Contacts
//
//  Created by João Luis Santos on 25/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

class ContactListViewModel {
    
    // MARK: - Properties
    
    let coreDataStack = CoreDataStack()
    var contacts: [Contact] = []
    
    // MARK: - Functions
    
    func fetchContacts() {
        contacts = coreDataStack.fetchContacts() ?? []
    }
    
    func deleteContact(at indexPath: IndexPath) {
        coreDataStack.deleteObject(contacts[indexPath.row])
        contacts.remove(at: indexPath.row)
    }

}
