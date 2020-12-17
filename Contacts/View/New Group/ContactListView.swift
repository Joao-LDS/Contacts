//
//  ContactListView.swift
//  Contacts
//
//  Created by João Luis Santos on 25/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class ContactListView: UIView {
    
    // MARK: - Properties
    
    lazy var logoutButton: FloatButton = {
        let view = FloatButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var viewSearchTextField: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftViewTextField: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addButton: FloatButton = {
        let view = FloatButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ConfigureView

extension ContactListView: ConfigureView {
    
    func addComponents() {
        addSubview(logoutButton)
        viewSearchTextField.addSubview(searchTextField)
        addSubview(viewSearchTextField)
        addSubview(tableView)
        addSubview(addButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            logoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: viewSearchTextField.leadingAnchor, constant: -20),
            logoutButton.centerYAnchor.constraint(equalTo: viewSearchTextField.centerYAnchor),
            
            viewSearchTextField.leadingAnchor.constraint(equalTo: logoutButton.trailingAnchor, constant: 20),
            viewSearchTextField.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15),
            viewSearchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            viewSearchTextField.heightAnchor.constraint(equalToConstant: 80),
            
            searchTextField.centerYAnchor.constraint(equalTo: viewSearchTextField.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: viewSearchTextField.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: viewSearchTextField.trailingAnchor, constant: -20),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            leftViewTextField.widthAnchor.constraint(equalToConstant: 40),
            leftViewTextField.heightAnchor.constraint(equalToConstant: 25),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: viewSearchTextField.bottomAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -26),
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .white
        
        logoutButton.imageview.image = Constants.Image.logout
        
        viewSearchTextField.backgroundColor = .white
        viewSearchTextField.shadow(shadowColor: Constants.Color.main!.cgColor, shadowRadius: 7, shadowOpacity: 0.4)
        viewSearchTextField.layer.cornerRadius = 30
        
        searchTextField.backgroundColor = Constants.Color.main
        searchTextField.layer.cornerRadius = 15
        searchTextField.alpha = 0.4
        searchTextField.leftView = leftViewTextField
        searchTextField.leftViewMode = .always
        
        leftViewTextField.image = Constants.Image.search
        leftViewTextField.contentMode = .scaleAspectFit
        
        tableView.separatorStyle = .none
        
        addButton.imageview.image = Constants.Image.plus
    }
}
