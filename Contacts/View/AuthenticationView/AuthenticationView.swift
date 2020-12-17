//
//  AuthenticationView.swift
//  Contacts
//
//  Created by João Luis Santos on 15/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class AuthenticationView: UIView {
    
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
    
    lazy var forgotPasswordButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dontHaveAnAccountButton: UIButton = {
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

extension AuthenticationView: ConfigureView {
    func addComponents() {
        addSubview(imageView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        addSubview(stackView)
        addSubview(forgotPasswordButton)
        addSubview(dontHaveAnAccountButton)
        addSubview(signButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -70),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            signButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 70),
            
            dontHaveAnAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            dontHaveAnAccountButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .white
        
        imageView.image = Constants.Image.logo
        
        passwordTextField.textField.isSecureTextEntry = true
        
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        
        forgotPasswordButton.setTitle("Esqueci minha senha", for: .normal)
        forgotPasswordButton.setTitleColor(Constants.Color.main!, for: .normal)
        forgotPasswordButton.titleLabel?.font = Constants.Font.avenir18
        
        signButton.imageview.image = Constants.Image.ok
        
        dontHaveAnAccountButton.setTitle("Eu não tenho uma conta", for: .normal)
        dontHaveAnAccountButton.setTitleColor(Constants.Color.main!, for: .normal)
        dontHaveAnAccountButton.titleLabel?.font = Constants.Font.avenir18
    }
    
    
}
