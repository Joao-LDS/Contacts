//
//  ContactListViewModel.swift
//  Contacts
//
//  Created by João Luis Santos on 25/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

protocol ContactListViewModelDelegate {
    func presentAuthenticationView()
}

class ContactListViewModel {
    
    // MARK: - Properties
    
    var delegate: ContactListViewModelDelegate?
    let coreDataStack = CoreDataStack()
    var contacts: [Contact] = []
    var filteredContacts: [Contact] = []
    var isSearch = false
    
    // MARK: - Functions
    
    func fetchContacts() {
        contacts = coreDataStack.fetchContacts() ?? []
    }
    
    func deleteContact(at indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        let contactId = contact.id!
        coreDataStack.deleteObject(contact)
        contacts.remove(at: indexPath.row)
        FirestoreService.shared.delete(at: contactId)
    }
    
    func filterContacts(_ text: String) {
        filteredContacts = text.isEmpty ? self.contacts : contacts.filter({
            let name = $0.name!.lowercased()
            let text = text.lowercased()
            return name.contains(text)
        })
        isSearch = text.isEmpty ? false : true
    }
    
    func countRows() -> Int {
        if isSearch {
            return filteredContacts.count
        } else {
            return contacts.count
        }
    }
    
    func returnContact(at index: Int) -> Contact {
        if isSearch {
            return filteredContacts[index]
        } else {
            return contacts[index]
        }
    }
    
    func logout() {
        let logout = AuthService().logoutUser()
        if logout == true {
            delegate?.presentAuthenticationView()
        }
    }

}
