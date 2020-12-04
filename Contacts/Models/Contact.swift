//
//  Contact.swift
//  Contacts
//
//  Created by João Luis Santos on 02/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

extension Contact {
    
    func convertObjectToDictionary(contact: Contact) -> [String: Any] {
        // O nome não entra no dict por ser obrigatório e por estar fixo na view Details
        var dict = contact.dictionaryWithValues(forKeys: ["name", "phone", "email", "address", "photo"])
        if let group = contact.group?.name {
            dict.updateValue(group, forKey: "group")
        }
        return dict
    }
}
