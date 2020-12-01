//
//  GroupView.swift
//  Contacts
//
//  Created by João Luis Santos on 27/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class GroupView: UIView {
    
    // MARK: - Properties
    
    lazy var backButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButtonImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var nameGroupTf: CustomTextField = {
        let view = CustomTextField(placeHolder: .Grupo)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addButton: OkButton = {
        let view = OkButton()
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

extension GroupView: ConfigureView {
    
    func addComponents() {
        backButton.addSubview(backButtonImageView)
        addSubview(backButton)
        addSubview(nameGroupTf)
        addSubview(tableView)
        addSubview(addButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            
            backButtonImageView.widthAnchor.constraint(equalToConstant: 40),
            backButtonImageView.heightAnchor.constraint(equalToConstant: 40),
            backButtonImageView.centerXAnchor.constraint(equalTo: backButton.centerXAnchor),
            backButtonImageView.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            nameGroupTf.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            nameGroupTf.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            nameGroupTf.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            tableView.topAnchor.constraint(equalTo: nameGroupTf.bottomAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -30),
            
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .white
        
        backButtonImageView.image = UIImage(named: "back_arrow")
        backButtonImageView.shadow(shadowColor: UIColor.black.cgColor,
                                   shadowRadius: 7,
                                   shadowOpacity: 0.4)
        
        tableView.separatorStyle = .none
    }
    
    
}
