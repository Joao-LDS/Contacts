//
//  GroupButton.swift
//  Contacts
//
//  Created by João Luis Santos on 27/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class GroupButton: UIButton {
    
    // MARK: - Properties
    
    lazy var arrowView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var iconView: UIImageView = {
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

extension GroupButton: ConfigureView {
    
    func addComponents() {
        addSubview(arrowView)
        addSubview(iconView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),

            arrowView.heightAnchor.constraint(equalToConstant: 25),
            arrowView.widthAnchor.constraint(equalToConstant: 25),
            arrowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            arrowView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    func additionalConfiguration() {
        iconView.image = Constants.Image.group
        
        setAttributedTitle("Grupo".styleText(Constants.Font.avenir18!), for: .normal)
        setTitleColor(.lightGray, for: .normal)
        contentHorizontalAlignment = .left
        titleEdgeInsets.left = 42
        
        arrowView.image = Constants.Image.arrow
    }
    
    
}
