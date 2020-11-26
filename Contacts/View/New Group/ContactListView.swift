//
//  ContactListView.swift
//  Contacts
//
//  Created by João Luis Santos on 25/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class ContactListView: UIView {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var floatButton: FloatButton = {
        let view = FloatButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ContactListView: ConfigureView {
    func addComponents() {
        addSubview(tableView)
        addSubview(floatButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            floatButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            floatButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -26),
        ])
    }
    
    func additionalConfiguration() {
        floatButton.imageview.image = UIImage(named: "plus")
    }
}
