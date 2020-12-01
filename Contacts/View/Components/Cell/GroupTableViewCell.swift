//
//  GroupTableViewCell.swift
//  Contacts
//
//  Created by João Luis Santos on 27/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var nameLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var arrowView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func configureCell(with name: String?) {
        nameLbl.text = name
    }
    
}

// MARK: - ConfigureView

extension GroupTableViewCell: ConfigureView {
    func addComponents() {
        addSubview(nameLbl)
        addSubview(arrowView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),

            nameLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            arrowView.heightAnchor.constraint(equalToConstant: 25),
            arrowView.widthAnchor.constraint(equalToConstant: 25),
            arrowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            arrowView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func additionalConfiguration() {
        nameLbl.font = UIFont(name: "Avenir", size: 28)
        nameLbl.textColor = UIColor(named: "second")
        
        arrowView.image = UIImage(named: "arrow")
    }
    
    
}
