//
//  TypeManager.swift
//  Contacts
//
//  Created by João Luis dos Santos on 02/04/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import CoreData

class TypeManager {
    
    // MARK: - Attributes
    
    static let shared = TypeManager()
    var types: [TypeOfContact] = []
    
    private init() {
    }
    
    // MARK: - Methods
    
    func loadTypes(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<TypeOfContact> = TypeOfContact.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            types = try context.fetch(fetchRequest) // Devolve uma lista com todos os tipos de contato
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteType(at index: Int, context: NSManagedObjectContext) {
        let type = types[index]
        context.delete(type) // Deleta do contexto, essa info ainda n foi persistida
        do {
            try context.save() // Contexto é salvo persistindo a info no Core Data
        } catch {
            print(error.localizedDescription)
        }
    }
}
