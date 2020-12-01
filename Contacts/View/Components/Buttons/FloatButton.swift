//
//  FloatButton.swift
//  Contacts
//
//  Created by João Luis Santos on 25/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class FloatButton: UIButton {
    
    // MARK: - Properties
    
    lazy var imageview: UIImageView = {
        let view = UIImageView()
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

extension FloatButton: ConfigureView {
    
    func addComponents() {
        addSubview(imageview)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 60),
            heightAnchor.constraint(equalToConstant: 60),
            
            imageview.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageview.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageview.widthAnchor.constraint(equalToConstant: 30),
            imageview.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = UIColor(named: "second")
        layer.cornerRadius = 30
        shadow(shadowColor: UIColor(named: "second")!.cgColor, shadowRadius: 10, shadowOpacity: 0.5)
    }
    
    
}

