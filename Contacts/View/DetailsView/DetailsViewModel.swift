//
//  DetailsViewModel.swift
//  Contacts
//
//  Created by João Luis Santos on 27/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

class DetailsViewModel {
    
    var contact: Contact
    var dictContact: [String: Any] {
        return contact.convertObjectToDictionary(contact: contact)
    }
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    func numberOfRows() -> Int {
        var number = 0
        for (key, _) in dictContact {
            if let value = dictContact[key] as? String, value != "" {
                number += 1
            }
        }
        return number
    }
    
    
    
    
}
