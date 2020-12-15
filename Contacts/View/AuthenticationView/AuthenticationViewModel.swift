//
//  AuthenticationViewModel.swift
//  Contacts
//
//  Created by João Luis Santos on 15/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

class AuthenticationViewModel {
    
    var delegate: SignErrorDelegate?
    
    func signInUser(_ email: String, password: String) {
        AuthService().signInUser(email, password) { failed, errorDescription in
            let emptyString = Constants.String.empty
            if failed || errorDescription != emptyString {
                self.delegate?.showAlertWithError(message: errorDescription!)
            }
        }
    }
}
