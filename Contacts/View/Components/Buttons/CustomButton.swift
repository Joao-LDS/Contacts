//
//  CustomButton.swift
//  Contacts
//
//  Created by João Luis Santos on 26/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    var title: String?
    
    convenience init(title: String) {
        self.init(frame: .zero)
        self.title = title
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomButton: ConfigureView {
    func addComponents() {}
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func additionalConfiguration() {
        backgroundColor = UIColor(named: "second")
        setTitle(self.title, for: .normal)
        layer.cornerRadius = 8
    }
    
    
}
