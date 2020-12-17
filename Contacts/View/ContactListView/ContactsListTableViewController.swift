//
//  ContactsListTableViewController.swift
//  Contacts
//
//  Created by João Santos on 15/02/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit
import CoreData

class ContactsListTableViewController: UIViewController {

    // MARK: - Properties
    
    let viewModel: ContactListViewModel
    var uiview: ContactListView
    
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
        configureView()
        viewModel.userAlreadyAuthenticated()
        uiview.searchTextField.delegate = self
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchContacts()
        uiview.tableView.reloadData()
    }

    // MARK: - Functions
    
    func setupTableView() {
        uiview.tableView.delegate = self
        uiview.tableView.dataSource = self
        uiview.tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func configureView() {
        uiview.addButton.addTarget(self, action: #selector(self.plusTapped(_:)), for: .touchUpInside)
        uiview.searchTextField.addTarget(self, action: #selector(self.searchChange(_:)), for: .editingChanged)
        uiview.logoutButton.addTarget(self, action: #selector(self.tappedLogout), for: .touchUpInside)
        uiview.dismissKeyboardWhenTapView()
    }
    
    // MARK: - Selectors
    
    @objc func plusTapped(_ sender: UIButton) {
        let viewModel = FormViewModel()
        let controller = FormViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    @objc func searchChange(_ tf: UITextField) {
        viewModel.filterContacts(tf.text ?? "")
        uiview.tableView.reloadData()
    }
    
    @objc func tappedLogout() {
        viewModel.logout()
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ContactsListTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        let contact = viewModel.returnContact(at: indexPath.row)
        let image = UIImage(data: contact.photo!)
        cell.configureCell(with: contact.name!, contact.phone!, image!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = viewModel.returnContact(at: indexPath.row)
        let viewModel = DetailsViewModel(contact: contact)
        let controller = DetailsViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteContact(at: indexPath)
            uiview.tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
}

extension ContactsListTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension ContactsListTableViewController: ContactListViewModelDelegate {
    func presentAuthenticationView() {
        let viewModel = AuthenticationViewModel()
        let controller = AuthenticationViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}
