//
//  CoreDataStack.swift
//  Contacts
//
//  Created by João Luis Santos on 26/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // MARK: - Core Data Properties
    
    static let shared = CoreDataStack()
    var fetchedResultControllerContact: NSFetchedResultsController<Contact>?
    var fetchedResultControllerGroup: NSFetchedResultsController<Group>?

    // MARK: - Core Data Functions
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Contacts")
        let url = DocumentDirectory().urlToCoreData()
        let description = NSPersistentStoreDescription(url: url)
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        description.setOption(FileProtectionType.completeUnlessOpen as NSObject, forKey: NSPersistentStoreFileProtectionKey)
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    var entity: NSEntityDescription {
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
        return entity!
    }

    func save() {
        do {
            try context.save()
        } catch { }
        
    }
    
    func deleteObject(_ object: NSManagedObject) {
        context.delete(object)
        save()
    }
    
    func fetchContacts() -> [Contact]? {
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        request.sortDescriptors = [sort]
        fetchedResultControllerContact = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)

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
        fetchedResultControllerGroup = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultControllerGroup?.performFetch()
            return fetchedResultControllerGroup?.fetchedObjects
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
