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
    
    func signInUser(_ email: String, password: String, completion: @escaping(Bool) -> Void) {
        AuthService().loginUser(email, password) { sucess, errorDescription in
            if sucess == false && errorDescription != nil {
                self.delegate?.showAlertWithError(message: errorDescription!)
                completion(false)
                return
            }
            completion(true)
        }
    }
}
