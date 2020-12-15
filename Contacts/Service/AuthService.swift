//
//  AuthService.swift
//  Contacts
//
//  Created by João Luis Santos on 15/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    func registerUser(_ email: String,_ password: String, completion: @escaping(Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error, let errorCode = AuthErrorCode(rawValue: error._code) {
                let errorDescription = self.returnErrorDescription(errorCode)
                completion(false, errorDescription)
                return
            }
            completion(true, nil)
        }
    }
    
    func signInUser(_ email: String,_ password: String, completion: @escaping(Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error, let errorDescription = AuthErrorCode(rawValue: error._code) {
                let errorDescription = self.returnErrorDescription(errorDescription)
                completion(false, errorDescription)
                return
            }
            completion(true, nil)
        }
    }
    
    func returnErrorDescription(_ error: AuthErrorCode) -> String {
        var errorDescription: String
        switch error {
        case .weakPassword:
            errorDescription = "A senha deve ter 6 caracteres ou mais."
            return errorDescription
        case .invalidEmail:
            errorDescription = "O e-mail tem um formato inválido."
            return errorDescription
        case .wrongPassword:
            errorDescription = "A senha está incorreta."
            return errorDescription
        default:
            return ""
        }
    }
    
}
