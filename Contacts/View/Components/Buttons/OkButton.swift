//
//  CustomButton.swift
//  Contacts
//
//  Created by João Luis Santos on 26/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class OkButton: UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ConfigureView

extension OkButton: ConfigureView {
    
    func addComponents() {}
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),
            widthAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    func additionalConfiguration() {
        setImage(Constants.Image.okButton, for: .normal)
        layer.cornerRadius = 8
        shadow(shadowColor: UIColor.black.cgColor, shadowRadius: 8, shadowOpacity: 0.4)
    }
    
    
}
