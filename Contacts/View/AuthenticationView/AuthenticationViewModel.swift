//
//  AuthenticationViewModel.swift
//  Contacts
//
//  Created by João Luis Santos on 15/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

protocol AuthenticationViewModelDelegate {
    func presentContactListView()
}

class AuthenticationViewModel {
    
    var signErrorDelegate: SignErrorDelegate?
    var authViewDelegate: AuthenticationViewModelDelegate?
    
    func signInUser(_ email: String,_ password: String) {
        AuthService().loginUser(email, password) { sucess, errorDescription in
            if sucess == false && errorDescription != nil {
                self.signErrorDelegate?.showAlertWithError(message: errorDescription!)
                return
            }
            self.authViewDelegate?.presentContactListView()
        }
    }
}
