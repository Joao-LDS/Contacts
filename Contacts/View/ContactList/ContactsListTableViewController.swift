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

class ContactsListTableViewController: UIViewController {

    let viewModel: ContactListViewModel
    var uiview: ContactListView
    
    // MARK: - Attributes
    
    var delegate: ContactDetailsDelegate?
    var fetchedResultController: NSFetchedResultsController<Contact>! // Classe usada para fazer a requisição
    
    // MARK: - Init
    
    init(viewModel: ContactListViewModel) {
        self.viewModel = viewModel
        uiview = ContactListView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        self.view = uiview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadContacts()
        configureView()
    }

    // MARK: - Functions
    
    func setupTableView() {
        uiview.tableView.delegate = self
        uiview.tableView.dataSource = self
        uiview.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func configureView() {
        uiview.floatButton.addTarget(self, action: #selector(self.plusTapped(_:)), for: .touchUpInside)
    }
    
    @objc func plusTapped(_ sender: UIButton) {
        let viewModel = FormViewModel()
        let controller = FormViewController(viewModel: viewModel)
        present(controller, animated: true, completion: nil)
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

    // MARK: - Table view data source
extension ContactsListTableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultController.fetchedObjects?.count ?? 0 // fetchedResultController.fetchedObjects retorna uma array com os Obejtos
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        guard let contact = fetchedResultController.fetchedObjects?[indexPath.row] else { // Recupera o objeto no Array
            return cell
        }
        let image = contact.image as! UIImage
        cell.configureCell(with: contact.name!, contact.phoneNumber!, image)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let contact = fetchedResultController.fetchedObjects?[indexPath.row] else { return }
            context.delete(contact)
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
                uiview.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        default:
            uiview.tableView.reloadData()
        }
    }
}
