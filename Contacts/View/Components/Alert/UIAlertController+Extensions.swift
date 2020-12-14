//
//  AlertController.swift
//  Contacts
//
//  Created by João Luis Santos on 30/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

extension UIAlertController {

    func create(title: String?,
                message: String,
                preferredStyle: UIAlertController.Style, actions: [UIAlertAction]?) -> UIAlertController {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: preferredStyle)
        alert.setValue(title?.styleText(.AvenirHeavy, 18), forKey: "attributedTitle")
        alert.setValue(message.styleText(.Avenir, 18), forKey: "attributedMessage")
        alert.view.tintColor = UIColor(named: "second")
        
        let titleAction = "Cancelar"
        
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }
        alert.addAction(UIAlertAction(title: titleAction, style: .cancel))
        
        return alert
    }
    
}
