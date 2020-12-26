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
    var authListener: AuthStateDidChangeListenerHandle!
    
    func registerUser(With email: String,_ password: String, completion: @escaping(Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                let errorDescription = self.authError.returnErrorDescription(error)
                completion(false, errorDescription)
                return
            }
            self.verifyEmail { sucess, errorDescription in
                if sucess == false && errorDescription != nil {
                    completion(false, errorDescription)
                    return
                }
            }
            completion(true, nil)
        }
    }
    
    func loginUser(_ email: String,_ password: String, completion: @escaping(Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                let errorDescription = self.authError.returnErrorDescription(error)
                completion(false, errorDescription)
                return
            }
            if self.isEmailVerified() == true {
                completion(true, nil)
            } else {
                completion(false, "Por favor verifique seu e-mail.")
            }
        }
    }
    
    func userAlreadyAuthenticated(completion: @escaping(Bool) -> Void) {
        if isEmailVerified() == true {
            self.authListener = Auth.auth().addStateDidChangeListener { _, user in
                let authenticated = user != nil ? true : false
                if authenticated {
                    completion(true)
                    return
                }
            }
        }
//        Auth.auth().removeStateDidChangeListener(self.authListener)
        completion(false)
    }
    
    func logoutUser() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
    
    func verifyEmail(completion: @escaping(Bool, String?) -> Void) {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
            if let error = error {
                let errorDescription = self.authError.returnErrorDescription(error)
                completion(false, errorDescription)
                return
            }
            completion(true, nil)
        })
    }
    
    func sendEmailRecoveryPassoword(_ email: String, completion: @escaping(Bool, String?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                let errorDescription = self.authError.returnErrorDescription(error)
                completion(false, errorDescription)
                return
            }
            completion(true, nil)
        }
    }
    
    func isEmailVerified() -> Bool {
        guard let verified = Auth.auth().currentUser?.isEmailVerified else { return false}
        return verified
    }
    
    func userId() -> String {
        return Auth.auth().currentUser!.uid
    }
}
