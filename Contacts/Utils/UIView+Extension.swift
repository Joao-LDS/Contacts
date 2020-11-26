//
//  UIView+Extension.swift
//  Contacts
//
//  Created by João Luis Santos on 26/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

extension UIView {
    func shadow(shadowColor: CGColor, shadowRadius: CGFloat, shadowOpacity: Float) {
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
    }
}
