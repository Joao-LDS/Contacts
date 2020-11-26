//
//  CustomTextField.swift
//  Contacts
//
//  Created by João Luis Santos on 26/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

enum PlaceHolder: String {
    case Name, Phone, Email, Address, TypeOfContact
}

class CustomTextField: UIView {
    
    var placeHolder: PlaceHolder!
    
    lazy var textField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    convenience init(placeHolder: PlaceHolder) {
        self.init(frame: .zero)
        self.placeHolder = placeHolder
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomTextField: ConfigureView {
    
    func addComponents() {
        addSubview(textField)
        addSubview(imageView)
        addSubview(lineView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: lineView.topAnchor),
            
            lineView.widthAnchor.constraint(equalTo: widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = .white
        
        textField.placeholder = placeHolder.rawValue
        
        imageView.image = UIImage(named: placeHolder.rawValue)
        
        lineView.backgroundColor = UIColor(named: "second")
    }
    
}
