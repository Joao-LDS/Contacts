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
    
    lazy var hintView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var hintLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: FloatButton = {
        let view = FloatButton()
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
        addSubview(backButton)
        addSubview(nameGroupTf)
        addSubview(tableView)
        addSubview(addButton)
        hintView.addSubview(hintLabel)
        addSubview(hintView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            hintView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hintView.topAnchor.constraint(equalTo: topAnchor),
            hintView.trailingAnchor.constraint(equalTo: trailingAnchor),
            hintView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            hintLabel.centerYAnchor.constraint(equalTo: hintView.centerYAnchor),
            hintLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hintLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 20),
            
            nameGroupTf.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            nameGroupTf.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            nameGroupTf.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 50),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            tableView.topAnchor.constraint(equalTo: nameGroupTf.bottomAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -30),
            
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -12)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .white
        
        backButton.imageview.image = Constants.Image.backArrow
        
        tableView.separatorStyle = .none
        
        hintView.backgroundColor = Constants.Color.main
        hintView.alpha = 0.7
        
        hintLabel.font = Constants.Font.avenir20
        hintLabel.numberOfLines = 0
        hintLabel.textAlignment = .center
        hintLabel.textColor = .white
        hintLabel.text = """
        Você pode criar um grupo usando a caixa de texto acima.
        
        Se precisar, você pode editar um grupo pressionando ele por um segundo.
        """
    }
    
    
}
