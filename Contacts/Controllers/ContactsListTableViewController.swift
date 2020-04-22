//
//  ContactsListTableViewController.swift
//  Contacts
//
//  Created by João Santos on 15/02/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit
import CoreData

protocol ContactDetailsDelegate {
    func details(contact: Contact)
}

class ContactsListTableViewController: UITableViewController {

    // MARK: - Attributes
    
    var delegate: ContactDetailsDelegate?
    var fetchedResultController: NSFetchedResultsController<Contact>! // Classe usada para fazer a requisição
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultController.fetchedObjects?.count ?? 0 // fetchedResultController.fetchedObjects retorna uma array com os Obejtos
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        guard let contact = fetchedResultController.fetchedObjects?[indexPath.row] else { // Recupera o objeto no Array
            return cell
        }
        cell.prepare(with: contact)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let contact = fetchedResultController.fetchedObjects?[indexPath.row] else { return }
            context.delete(contact)
        }
    }
    
    // MARK: - Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "detailSegue" {
            let vc = segue.destination as! DetailsContactViewController
                if let contact = fetchedResultController.fetchedObjects {
                    vc.contact = contact[tableView.indexPathForSelectedRow!.row]
                }
        }
    }

    func loadContacts() {
        let fecthRequest: NSFetchRequest<Contact> = Contact.fetchRequest() // Var para fazer uma request no Core Data
        let sortDescritor = NSSortDescriptor(key: "name", ascending: true) // Ordenação da request
        fecthRequest.sortDescriptors = [sortDescritor] // Atribui a ordenação a request
        // Temos duas maneiras de fazer a requisição, usando NSFetchRequest ou NSFetchedResultsController.
        // NSFetchedResultsController nos da acesso ao delegate, com isso conseguimos monitor tudo, se foi adicionado, se foi removido, etc.
        fetchedResultController = NSFetchedResultsController(fetchRequest: fecthRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch() // Faz a requisição ao Core Data trazendo todos os dados
        } catch {
            print(error.localizedDescription)
        }
    }

}

extension ContactsListTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) { //  É disparado sempre que há uma modificação no Objeto Contact
        switch type { // type: NSFetchedResultsChangeType diz qual é o tipo de mudança
        case .delete:
            if let indexPath = indexPath {
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        default:
            tableView.reloadData()
        }
    }
}
