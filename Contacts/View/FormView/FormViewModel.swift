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
    lazy var isEdit = self.contact != nil ? true : false
    let firestoreService = FirestoreService.shared
    
    // MARK: - Init
    
    init() {}
    
    convenience init(contact: Contact) {
        self.init()
        self.contact = contact
    }
    
    // MARK: - Functions
    
    func addContact(with name: String,_ phone: String,_ email: String,_ address: String,_ photo: Data) -> Bool {
        
        if name.isEmpty {
            return false
        }
        if isEdit == false {
            self.contact = Contact(context: coreData.context)
            contact?.id = UUID().uuidString
        }
        
        contact?.name = name
        contact?.phone = phone
        contact?.email = email
        contact?.address = address
        contact?.photo = photo
        
        /* Se delegate?.selectedGroup == nil, pega o group do contact que está sendo
         editado. Se não pega de delegate?.selectedGroup, nesse caso indica que foi
         selecionado um grupo, seja na criação ou edição.
         */
        let group = delegate?.selectedGroup == nil ? self.contact?.group : delegate?.selectedGroup
        contact?.group = group
        
        coreData.save()
        
        let id = contact!.id!
        let values: [String: Any] = ["id": id,
                                     "name": name,
                                     "phone": phone,
                                     "email": email,
                                     "address": address]
        
        if isEdit == true {
            firestoreService.update(at: contact!.id!, with: values)
        } else {
            firestoreService.write(values)
        }
        
        return true
    }
    
    func formatPhoneNumber(_ text: String) -> String {
        // Extrai qualquer char qua não seja decimal
        let numbers = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(###) #####-####"
        var result = ""
        var index = text.startIndex
        // Monta uma string no formato da mask, trocando # pelo numero
        for char in mask where index < numbers.endIndex {
            if char == "#" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
    
}
