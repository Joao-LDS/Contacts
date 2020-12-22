//
//  RecoveryPasswordView.swift
//  Contacts
//
//  Created by João Luis Santos on 21/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class RecoveryPasswordView: UIView {
    
    lazy var closeButton: FloatButton = {
        let view = FloatButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emailRecoveryPassTextField: CustomTextField = {
        let view = CustomTextField(placeHolder: .Email)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var okButton: FloatButton = {
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

extension RecoveryPasswordView: ConfigureView {
    func addComponents() {
        addSubview(closeButton)
        addSubview(imageView)
        addSubview(messageLabel)
        addSubview(emailRecoveryPassTextField)
        addSubview(okButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            closeButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 30),
            
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -40),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            messageLabel.bottomAnchor.constraint(equalTo: emailRecoveryPassTextField.topAnchor, constant: -30),
                       
            emailRecoveryPassTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            emailRecoveryPassTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            emailRecoveryPassTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            okButton.topAnchor.constraint(equalTo: emailRecoveryPassTextField.bottomAnchor, constant: 70),
            okButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .white
        
        closeButton.imageview.image = Constants.Image.backArrow
        
        imageView.image = Constants.Image.logo
        
        messageLabel.text = "Entre com o e-mail associado a sua conta e lhe enviaremos as instruções para registrar uma nova senha."
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = Constants.Font.avenir18
        messageLabel.textColor = Constants.Color.main
        
        okButton.imageview.image = Constants.Image.ok
    }
}
