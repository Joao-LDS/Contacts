//
//  DetailsViewModel.swift
//  Contacts
//
//  Created by João Luis Santos on 27/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

protocol DetailsViewModelDelegate {
    func uiapplicationOpen(_ url: URL)
}

class DetailsViewModel {
    
    var delegate: DetailsViewModelDelegate?
    var contact: Contact
    var dictContact: [String: Any] {
        return contact.convertObjectToDictionary(contact: contact)
    }
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    func sms() {
        let message = Message()
        
    }
    
    func waze() {
        if let address = contact.address, address != "" {
            Location().convertAddressToCordinate(address: address) { (foundLocation) in
                // Converte as coordenadas em String
                let latitude = String(describing: foundLocation.location!.coordinate.latitude)
                let longitude = String(describing: foundLocation.location!.coordinate.longitude)
                
                print("\(latitude), \(longitude)")
                
                // Cria URL para abrir o waze
                let url = URL(string: "waze://?ll=\(latitude),\(longitude)&navigate=yes")! // url com as coordenadas
                self.delegate?.uiapplicationOpen(url)
            }
        }
    }
    
}
