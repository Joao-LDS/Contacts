//
//  AlertController.swift
//  Contacts
//
//  Created by João Luis Santos on 30/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

enum AvenirFont: String {
    case Avenir = "Avenir"
    case AvenirHeavy = "Avenir-Heavy"
}

extension UIAlertController {

    func create(title: String?,
                message: String,
                preferredStyle: UIAlertController.Style, actions: [UIAlertAction]?) -> UIAlertController {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: preferredStyle)
       
        alert.setValue(styleText(title, .AvenirHeavy, 20), forKey: "attributedTitle")
        alert.setValue(styleText(message, .Avenir, 18), forKey: "attributedMessage")
        alert.view.tintColor = UIColor(named: "second")
        
        let titleAction = preferredStyle == .alert ? "Ok" : "Cancelar"
        
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }
        alert.addAction(UIAlertAction(title: titleAction, style: .cancel))
        
        return alert
    }
    
    private func styleText(_ text: String?,_ font: AvenirFont,_ size: CGFloat) -> NSAttributedString {
        return NSAttributedString(string: text ?? "",
                                  attributes: [.font: UIFont(name: font.rawValue, size: size)!,
                                               .foregroundColor: UIColor.systemGray])
    }
    
}
