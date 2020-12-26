//
//  DetailsView.swift
//  Contacts
//
//  Created by João Luis Santos on 27/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class DetailsView: UIView {
    
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
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var phoneView: ViewDetail = {
        let view = ViewDetail()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emailView: ViewDetail = {
        let view = ViewDetail()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addressView: ViewDetail = {
        let view = ViewDetail()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var groupView: ViewDetail = {
        let view = ViewDetail()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackViewButtons: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var callButton: FloatButton = {
        let view = FloatButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageButton: FloatButton = {
        let view = FloatButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var editButton: FloatButton = {
        let view = FloatButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var localizeButton: FloatButton = {
        let view = FloatButton()
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

extension DetailsView: ConfigureView {
    
    func addComponents() {
        addSubview(backButton)
        addSubview(bottomView)
        addSubview(shadowView)
        addSubview(imageView)
        addSubview(nameLabel)
        stackView.addArrangedSubview(phoneView)
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(addressView)
        stackView.addArrangedSubview(groupView)
        addSubview(stackView)
        stackViewButtons.addArrangedSubview(callButton)
        stackViewButtons.addArrangedSubview(messageButton)
        stackViewButtons.addArrangedSubview(localizeButton)
        stackViewButtons.addArrangedSubview(editButton)
        addSubview(stackViewButtons)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 20),
            
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.topAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -30),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 50),
            
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            shadowView.widthAnchor.constraint(equalToConstant: 150),
            shadowView.heightAnchor.constraint(equalToConstant: 150),
            shadowView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            stackViewButtons.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViewButtons.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = Constants.Color.main
        
        backButton.imageview.image = Constants.Image.backArrow
        backButton.blackShadowColor()
        
        bottomView.backgroundColor = .white
        bottomView.layer.cornerRadius = 30
        bottomView.shadow(shadowColor: UIColor.black.cgColor, shadowRadius: 8, shadowOpacity: 0.5)
        
        imageView.layer.cornerRadius = 75
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        
        shadowView.backgroundColor = .black
        shadowView.layer.cornerRadius = 75
        shadowView.shadow(shadowColor: UIColor.black.cgColor, shadowRadius: 8, shadowOpacity: 0.5)
        
        nameLabel.font = Constants.Font.avenirHeavy28
        nameLabel.textColor = .systemGray
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 12
        
        stackViewButtons.axis = .horizontal
        stackViewButtons.distribution = .fill
        stackViewButtons.alignment = .fill
        stackViewButtons.spacing = 24
        
        callButton.imageview.image = Constants.Image.call
        messageButton.imageview.image = Constants.Image.message
        localizeButton.imageview.image = Constants.Image.localize
        editButton.imageview.image = Constants.Image.edit
    }
    
    
}
