//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by João Santos on 23/02/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
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
    
    lazy var numberLbl: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with name: String,_ number: String,_ photo: UIImage) {
        nameLbl.text = name
        numberLbl.text = number
        photoView.image = photo
    }
    
}

extension ContactTableViewCell: ConfigureView {
    func addComponents() {
        addSubview(photoView)
        addSubview(nameLbl)
        addSubview(numberLbl)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            photoView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            photoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            photoView.widthAnchor.constraint(equalToConstant: 50),
            photoView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLbl.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 16),
            nameLbl.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            numberLbl.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: 16),
            numberLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func additionalConfiguration() {
        
    }
    
    
}
