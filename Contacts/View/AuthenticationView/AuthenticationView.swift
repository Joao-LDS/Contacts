//
//  AuthenticationView.swift
//  Contacts
//
//  Created by João Luis Santos on 15/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class AuthenticationView: UIView {

    lazy var emailTextField: CustomTextField = {
        let view = CustomTextField(placeHolder: .Email)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let view = CustomTextField(placeHolder: .Número)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var signButton: OkButton = {
        let view = OkButton()
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
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(dontHaveAnAccountButton)
        addSubview(signButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -30),
            
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            dontHaveAnAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            dontHaveAnAccountButton.bottomAnchor.constraint(equalTo: signButton.topAnchor, constant: -30),
            
            signButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .white
        
        dontHaveAnAccountButton.setTitle("Eu não tenho uma conta.", for: .normal)
        dontHaveAnAccountButton.setTitleColor(Constants.Color.main!, for: .normal)
    }
    
    
}
