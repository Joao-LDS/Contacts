//
//  Contants.swift
//  Contacts
//
//  Created by João Luis Santos on 14/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct String {
        static let empty = ""
    }
    
    struct Color {
        static let main = UIColor(named: "main")
    }
    
    struct Image {
        static let backArrow = UIImage(named: "back_arrow")
        static let arrow = UIImage(named: "arrow")
        static let search = UIImage(named: "search")
        static let plus = UIImage(named: "plus")
        static let userDefaultImage = UIImage(named: "userDefaultImage")
        static let call = UIImage(named: "call")
        static let message = UIImage(named: "message")
        static let localize = UIImage(named: "localize")
        static let edit = UIImage(named: "edit")
        static let okButton = UIImage(named: "okButton")
        static let group = UIImage(named: "Grupo")
    }
    
    struct Font {
        static let avenir18 = UIFont(name: "Avenir", size: 18)
        static let avenir20 = UIFont(name: "Avenir", size: 20)
        static let avenir28 = UIFont(name: "Avenir", size: 28)
        static let avenirHeavy18 = UIFont(name: "Avenir-Heavy", size: 18)
        static let avenirHeavy28 = UIFont(name: "Avenir-Heavy", size: 28)
    }
}
