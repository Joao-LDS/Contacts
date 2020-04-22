//
//  Location.swift
//  Contacts
//
//  Created by João Luis dos Santos on 16/04/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit
import CoreLocation

class Location: NSObject {
    
    // MARK: - Methods
    
    func convertAddressToCordinate(address: String, local:@escaping(_ local:CLPlacemark) -> Void) {
        // Converte um endereço de formato string para cordenada
        let convert = CLGeocoder()
        convert.geocodeAddressString(address) { (locationArray, error) in
            if let location = locationArray?.first {
                local(location) // Retorna o location na clojure
                print(location)
            }
        }
    }
}
