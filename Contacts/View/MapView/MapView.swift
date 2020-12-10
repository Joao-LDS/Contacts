//
//  MapView.swift
//  Contacts
//
//  Created by João Luis Santos on 09/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {
    
    lazy var backButton: FloatButton = {
        let view = FloatButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var mapView: MKMapView = {
        let view = MKMapView()
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

extension MapView: ConfigureView {
    func addComponents() {
        addSubview(mapView)
        addSubview(backButton)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func additionalConfiguration() {
        backButton.imageview.image = UIImage(named: "back_arrow")
        backButton.blackShadowColor()
    }
    
    
}
