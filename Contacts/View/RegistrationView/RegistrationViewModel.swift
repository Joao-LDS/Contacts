//
//  RegistrationViewModel.swift
//  Contacts
//
//  Created by João Luis Santos on 15/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

protocol SignErrorDelegate {
    func showAlertWithError(message: String)
}

class RegistrationViewModel {
    
    var delegate: SignErrorDelegate?
    
    func signUpUser(_ email: String,_ password: String,_ passwordAgain: String) {
        if confirmPassword(password, with: passwordAgain) {
            let user = User()
            user.email = email
            user.password = password
            AuthService().registerUser(user) { sucess, errorDescription in
                if sucess == false && errorDescription != nil {
                    self.delegate?.showAlertWithError(message: errorDescription!)
                }
            }
        }
        
    }
    
    func confirmPassword(_ first: String, with second: String) -> Bool {
        if first == second {
            return true
        } else {
            delegate?.showAlertWithError(message: "As senhas não são iguais.")
            return false
        }
    }
}
