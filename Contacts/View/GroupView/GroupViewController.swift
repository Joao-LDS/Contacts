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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteGroup(at: indexPath)
            uiview.tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedGroup = viewModel.groups[indexPath.row]
        dismiss(animated: true)
    }
    
}
