//
//  FormView.swift
//  Contacts
//
//  Created by João Luis Santos on 25/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class FormView: UIView {
    
    // MARK: - Properties
    
    lazy var backButton: FloatButton = {
        let view = FloatButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        let view = CustomTextField(placeHolder: .Nome)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var phoneTf: CustomTextField = {
        let view = CustomTextField(placeHolder: .Número)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emailTf: CustomTextField = {
        let view = CustomTextField(placeHolder: .Email)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addressTf: CustomTextField = {
        let view = CustomTextField(placeHolder: .Endereço)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var groupTypeButton: GroupButton = {
        let view = GroupButton(type: .system)
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

extension FormView: ConfigureView {
    
    func addComponents() {
        addSubview(backButton)
        addSubview(bottomView)
        addSubview(shadowView)
        addSubview(imageView)
        stackView.addArrangedSubview(nameTf)
        stackView.addArrangedSubview(phoneTf)
        stackView.addArrangedSubview(emailTf)
        stackView.addArrangedSubview(addressTf)
        stackView.addArrangedSubview(groupTypeButton)
        addSubview(stackView)
        addSubview(addButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 20),
            
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            shadowView.widthAnchor.constraint(equalToConstant: 150),
            shadowView.heightAnchor.constraint(equalToConstant: 150),
            shadowView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.topAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -30),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 50),
            
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
            
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -12)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = UIColor(named: "second")
        
        backButton.imageview.image = UIImage(named: "back_arrow")
        backButton.blackShadowColor()
        
        bottomView.backgroundColor = .white
        bottomView.layer.cornerRadius = 30
        bottomView.shadow(shadowColor: UIColor.black.cgColor, shadowRadius: 8, shadowOpacity: 0.5)
        
        imageView.image = UIImage(named: "userDefaultImage")
        imageView.layer.cornerRadius = 75
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        
        shadowView.backgroundColor = .black
        shadowView.layer.cornerRadius = 75
        shadowView.shadow(shadowColor: UIColor.black.cgColor, shadowRadius: 8, shadowOpacity: 0.5)
        
        stackView.spacing = 28
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .vertical
        
        phoneTf.textField.keyboardType = .phonePad
        emailTf.textField.keyboardType = .emailAddress
    }
    
    
}
