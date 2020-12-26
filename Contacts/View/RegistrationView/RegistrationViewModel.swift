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

protocol DismissViewDelegate {
    func dismissRecoveryView()
}

class RegistrationViewModel {
    
    var signErrorDescription: SignErrorDelegate?
    var dismissViewDelegate: DismissViewDelegate?
    
    func signUpUser(_ email: String,_ password: String,_ passwordAgain: String) {
        if confirmPassword(password, with: passwordAgain) {
            AuthService().registerUser(With: email, password) { sucess, errorDescription in
                if sucess == false && errorDescription != nil {
                    self.signErrorDescription?.showAlertWithError(message: errorDescription!)
                    return
                }
                self.dismissViewDelegate?.dismissRecoveryView()
            }
        }
        
    }
    
    func confirmPassword(_ first: String, with second: String) -> Bool {
        if first == second {
            return true
        } else {
            signErrorDescription?.showAlertWithError(message: "As senhas não são iguais.")
            return false
        }
    }
}
