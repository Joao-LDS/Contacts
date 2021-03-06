//
//  DetailsViewModel.swift
//  Contacts
//
//  Created by João Luis Santos on 27/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsViewModelDelegate {
    func uiapplicationOpen(_ url: URL)
    func presentView(controller: UIViewController)
}

class DetailsViewModel {
    
    var delegate: DetailsViewModelDelegate?
    var contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    func call() {
        guard let phone = contact.phone,
            let url = URL(string: "tel://\(phone)") else { return }
        delegate?.uiapplicationOpen(url)
    }
    
    func SMS() {
        let message = Message()
        if let component = message.configSMS(contact.phone!) {
            delegate?.presentView(controller: component)
        }
    }
    
    func waze() {
        if let address = contact.address, address != "" {
            Location().convertAddressToCordinate(address: address) { foundLocation in
                // Converte as coordenadas em String
                let latitude = String(describing: foundLocation.location!.coordinate.latitude)
                let longitude = String(describing: foundLocation.location!.coordinate.longitude)
                
                // Cria URL para abrir o waze
                let url = URL(string: "waze://?ll=\(latitude),\(longitude)&navigate=yes")! // url com as coordenadas
                self.delegate?.uiapplicationOpen(url)
            }
        }
    }
    
}
