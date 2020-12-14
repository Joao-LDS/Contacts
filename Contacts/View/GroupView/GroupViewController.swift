//
//  GroupViewController.swift
//  Contacts
//
//  Created by João Luis Santos on 27/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: GroupViewModel
    var uiview: GroupView
    
    // MARK: - Init
    
    init(viewModel: GroupViewModel) {
        self.viewModel = viewModel
        uiview = GroupView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureView()
        viewModel.loadGroups()
        delegateTextFields()
        let defaultUser = UserDefaults.standard
        let firstLaunch = UserDefaults.standard.bool(forKey: "First Launch")
        if firstLaunch == true {
            print("Second")
            uiview.hintView.isHidden = true
        } else {
            print("First")
            defaultUser.set(true, forKey: "First Launch")
        }
    }
    
    override func loadView() {
        self.view = uiview
    }
    
    // MARK: - Functions
    
    func setupTableView() {
        uiview.tableView.delegate = self
        uiview.tableView.dataSource = self
        uiview.tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func configureView() {
        uiview.addButton.addTarget(self, action: #selector(self.tappedAdd), for: .touchUpInside)
        uiview.backButton.addTarget(self, action: #selector(self.tappedBack), for: .touchUpInside)
        view.dismissKeyboardWhenTapView()
        configureLongPress()
        configureDimissHintView()
    }
    
    func delegateTextFields() {
        uiview.nameGroupTf.textField.delegate = self
    }
    
    func configureLongPress() {
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(self.edit))
        tap.minimumPressDuration = 1.0
        uiview.tableView.addGestureRecognizer(tap)
    }
    
    func configureDimissHintView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedHintView))
        uiview.hintView.addGestureRecognizer(tap)
    }
    
    func showAlertForEdit(GroupAt index: Int) {
        let group = viewModel.groups[index]
        var alert: UIAlertController!
        var actions: [UIAlertAction] = []
        actions.append(UIAlertAction(title: "Salvar", style: .default, handler: { _ in
            guard let textFields = alert.textFields else { return }
            let textField = textFields[0] as UITextField
            if let name = textField.text, name != Contants.String.empty {
                self.viewModel.editGroup(At: index, with: name)
                self.uiview.tableView.reloadData()
            }
        }))
        alert = UIAlertController().create(title: nil, message: "Editar grupo", preferredStyle: .alert, actions: actions)
        alert.addTextField { textField in
            textField.text = group.name!
        }
        present(alert, animated: true)
    }
    
    // MARK: - Selectors
    
    @objc func tappedAdd() {
        guard let groupName = uiview.nameGroupTf.textField.text else { return }
        viewModel.addGroupWith(name: groupName)
        uiview.tableView.reloadData()
    }
    
    @objc func tappedBack() {
        dismiss(animated: true)
    }
    
    @objc func edit(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: uiview.tableView)
            if let index = uiview.tableView.indexPathForRow(at: point) {
                showAlertForEdit(GroupAt: index.row)
            }
        }
    }
    
    @objc func tappedHintView() {
        UIView.animate(withDuration: 0.6, animations: {
            self.uiview.hintView.alpha = 0
        }) { _ in
            self.uiview.hintView.removeFromSuperview()
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension GroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GroupTableViewCell
        let group = viewModel.groups[indexPath.row].name
        cell.configureCell(with: group)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedGroup = viewModel.groups[indexPath.row]
        dismiss(animated: true)
    }
    
}

// MARK: - UITextFieldDelegate

extension GroupViewController: UITextFieldDelegate {
    
    // Desaparece o teclado quando clicar em return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
