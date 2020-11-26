//
//  FormView.swift
//  Contacts
//
//  Created by João Luis Santos on 25/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class FormView: UIView {
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameTf: CustomTextField = {
        let view = CustomTextField(placeHolder: .Name)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var phoneTf: CustomTextField = {
        let view = CustomTextField(placeHolder: .Phone)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emailTf: CustomTextField = {
        let view = CustomTextField(placeHolder: .Email)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addressTf: CustomTextField = {
        let view = CustomTextField(placeHolder: .Address)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var typeOfContactTf: CustomTextField = {
        let view = CustomTextField(placeHolder: .TypeOfContact)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addButton: CustomButton = {
        let view = CustomButton(title: "Add")
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

extension FormView: ConfigureView {
    func addComponents() {
        addSubview(bottomView)
        addSubview(shadowView)
        addSubview(imageView)
        stackView.addArrangedSubview(nameTf)
        stackView.addArrangedSubview(phoneTf)
        stackView.addArrangedSubview(emailTf)
        stackView.addArrangedSubview(addressTf)
        stackView.addArrangedSubview(typeOfContactTf)
        addSubview(stackView)
        addSubview(addButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            shadowView.widthAnchor.constraint(equalToConstant: 150),
            shadowView.heightAnchor.constraint(equalToConstant: 150),
            shadowView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.topAnchor.constraint(equalTo: imageView.centerYAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 50),
            
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -30),
            
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = UIColor(named: "second")
        
        bottomView.backgroundColor = .white
        bottomView.layer.cornerRadius = 15
        bottomView.shadow(shadowColor: UIColor.black.cgColor, shadowRadius: 8, shadowOpacity: 0.5)
        
        imageView.image = UIImage(named: "userDefaultImage")
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        
        shadowView.backgroundColor = .black
        shadowView.layer.cornerRadius = 15
        shadowView.shadow(shadowColor: UIColor.black.cgColor, shadowRadius: 8, shadowOpacity: 0.5)
        
        stackView.spacing = 28
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .vertical
    }
    
    
}
