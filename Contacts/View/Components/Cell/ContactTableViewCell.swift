//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by João Santos on 23/02/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var photoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLbl: UILabel = {
        let view = UILabel()
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
    
    func configureCell(with name: String,_ number: String,_ photo: UIImage) {
        nameLbl.text = name
        photoView.image = photo
    }
    
}

// MARK: - ConfigureView

extension ContactTableViewCell: ConfigureView {
    
    func addComponents() {
        addSubview(view)
        view.addSubview(photoView)
        view.addSubview(nameLbl)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            view.heightAnchor.constraint(equalToConstant: 100),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            photoView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoView.widthAnchor.constraint(equalToConstant: 70),
            photoView.heightAnchor.constraint(equalToConstant: 70),

            nameLbl.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 16),
            nameLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func additionalConfiguration() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        view.shadow(shadowColor: Constants.Color.main!.cgColor, shadowRadius: 5, shadowOpacity: 0.4)
        
        photoView.layer.cornerRadius = 35
        photoView.layer.masksToBounds = true
        
        nameLbl.font = Constants.Font.avenir28
        nameLbl.textColor = Constants.Color.main
        
        selectionStyle = .none
    }
    
    
}
