//
//  AuthService.swift
//  Contacts
//
//  Created by João Luis Santos on 15/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    let authError = AuthError()
    
    func registerUser(_ user: User, completion: @escaping(Bool, String?) -> Void) {
        guard let email = user.email, let password = user.password else { return }
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                let errorDescription = self.authError.returnErrorDescription(error)
                completion(false, errorDescription)
                return
            }
            completion(true, nil)
        }
    }
    
    func loginUser(_ email: String,_ password: String, completion: @escaping(Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                let errorDescription = self.authError.returnErrorDescription(error)
                completion(false, errorDescription)
                return
            }
            completion(true, nil)
        }
    }
    
    func userAlreadyAuthenticated(completion: @escaping(Bool) -> Void) {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                completion(true)
                return
            }
            completion(false)
        }
    }
}
