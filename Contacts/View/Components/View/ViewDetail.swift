//
//  ViewDetail.swift
//  Contacts
//
//  Created by João Luis Santos on 10/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class ViewDetail: UIView {
    
    lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ViewDetail: ConfigureView {
    func addComponents() {
        view.addSubview(label)
        addSubview(view)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),
            
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            view.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func additionalConfiguration() {
        view.shadow(shadowColor: UIColor(named: "second")!.cgColor, shadowRadius: 7, shadowOpacity: 0.4)
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        
        label.font = UIFont(name: "Avenir", size: 20)
        label.textColor = .systemGray
    }
    
}
