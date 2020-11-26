//
//  ConfigureView.swift
//  Contacts
//
//  Created by João Luis Santos on 25/11/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

protocol ConfigureView {
    func addComponents()
    func addConstraints()
    func additionalConfiguration()
}

extension ConfigureView {
    func setupView() {
        addComponents()
        addConstraints()
        additionalConfiguration()
    }
}
