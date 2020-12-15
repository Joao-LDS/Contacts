//
//  String+Extension.swift
//  Contacts
//
//  Created by João Luis Santos on 10/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func styleText(_ font: UIFont) -> NSAttributedString {
        return NSAttributedString(string: self,
                                  attributes: [.font: font,
                                               .foregroundColor: UIColor.systemGray])
    }
}
