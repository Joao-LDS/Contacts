//
//  String+Extension.swift
//  Contacts
//
//  Created by João Luis Santos on 10/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation
import UIKit

enum AvenirFont: String {
    case Avenir = "Avenir"
    case AvenirHeavy = "Avenir-Heavy"
}

extension String {
    
    func styleText(_ font: AvenirFont,_ size: CGFloat) -> NSAttributedString {
        return NSAttributedString(string: self,
                                  attributes: [.font: UIFont(name: font.rawValue, size: size)!,
                                               .foregroundColor: UIColor.systemGray])
    }
}
