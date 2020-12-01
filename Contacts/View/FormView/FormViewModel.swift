//
//  FormViewModel.swift
//  Contacts
//
//  Created by João Luis Santos on 25/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

protocol FormViewModelDelegate: class {
    var selectedGroup: Group? { get }
}

class FormViewModel {
    
    // MARK: - Properties
    
    var delegate: FormViewModelDelegate?
    let coreData = CoreDataStack.shared
    var contact: Contact?
    
    // MARK: - Init
    
    init() {}
    
    convenience init(contact: Contact) {
        self.init()
        self.contact = contact
    }
    
    // MARK: - Functions
    
    func addContact(with name: String,_ phone: String,_ email: String,_ address: String,_ photo: NSObject) -> Bool {
        
        if name.isEmpty {
            return false
        }
        if contact == nil {
            self.contact = Contact(context: coreData.context)
        }
        
        contact?.name = name
        contact?.phone = phone
        contact?.email = email
        contact?.address = address
        contact?.photo = photo
        contact?.group = delegate?.selectedGroup
        
        CoreDataStack.shared.save()
        
        return true
    }
    
}
