//
//  RegistrationView.swift
//  Contacts
//
//  Created by João Luis Santos on 15/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class RegistrationView: UIView {
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emailTextField: CustomTextField = {
        let view = CustomTextField(placeHolder: .Email)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let view = CustomTextField(placeHolder: .Senha)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var confirmPasswordTextField: CustomTextField = {
        let view = CustomTextField(placeHolder: .Senha)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var signButton: FloatButton = {
        let view = FloatButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var iHaveAnAccountButton: UIButton = {
        let view = UIButton()
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

extension RegistrationView: ConfigureView {
    func addComponents() {
        addSubview(imageView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        addSubview(stackView)
        addSubview(signButton)
        addSubview(iHaveAnAccountButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -70),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                       
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            signButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 70),
            
            iHaveAnAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            iHaveAnAccountButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .white
        
        imageView.image = Constants.Image.logo
        
        passwordTextField.textField.isSecureTextEntry = true
        confirmPasswordTextField.textField.isSecureTextEntry = true
        
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        
        signButton.imageview.image = Constants.Image.ok
        
        iHaveAnAccountButton.setTitle("Eu já tenho uma conta", for: .normal)
        iHaveAnAccountButton.setTitleColor(Constants.Color.main!, for: .normal)
        iHaveAnAccountButton.titleLabel?.font = Constants.Font.avenir18
    }
    
    
}
