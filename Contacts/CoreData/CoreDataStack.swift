//
//  CoreDataStack.swift
//  Contacts
//
//  Created by João Luis Santos on 26/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation
import CoreData

enum TypeObject {
    case Contact, Group
}

class CoreDataStack {
    
    // MARK: - Core Data Properties
    
    static let shared = CoreDataStack()
    var fetchedResultControllerContact: NSFetchedResultsController<Contact>?
    var fetchedResultControllerGroup: NSFetchedResultsController<Group>?

    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Contacts")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }

    // MARK: - Core Data Functions

    func save() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteObject(_ object: NSManagedObject) {
        context.delete(object)
        save()
    }
    
    func fetchContacts() -> [Contact]? {
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        request.sortDescriptors = [sort]
        fetchedResultControllerContact = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultControllerContact?.performFetch()
            return fetchedResultControllerContact?.fetchedObjects
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func fetchGroups() -> [Group]? {
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let request: NSFetchRequest<Group> = Group.fetchRequest()
        request.sortDescriptors = [sort]
        fetchedResultControllerGroup = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultControllerGroup?.performFetch()
            return fetchedResultControllerGroup?.fetchedObjects
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
