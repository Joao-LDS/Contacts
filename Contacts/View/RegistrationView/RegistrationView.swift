//
//  RegistrationView.swift
//  Contacts
//
//  Created by João Luis Santos on 15/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class RegistrationView: UIView {
    
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
    
    lazy var confirmPasswordTextField: CustomTextField = {
        let view = CustomTextField(placeHolder: .Número)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var signButton: OkButton = {
        let view = OkButton()
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
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        addSubview(stackView)
        addSubview(signButton)
        addSubview(iHaveAnAccountButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            iHaveAnAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            iHaveAnAccountButton.bottomAnchor.constraint(equalTo: signButton.topAnchor, constant: -30),
            
            signButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .white
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        iHaveAnAccountButton.setTitle("Eu já tenho uma conta.", for: .normal)
        iHaveAnAccountButton.setTitleColor(Constants.Color.main!, for: .normal)
    }
    
    
}
