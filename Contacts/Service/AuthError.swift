//
//  AuthError.swift
//  Contacts
//
//  Created by João Luis Santos on 16/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthError {
    
    func returnErrorDescription(_ error: Error) -> String? {
        guard let erroCode = AuthErrorCode(rawValue: error._code) else { return "Algo deu erro." }
        var errorDescription: String
        switch erroCode {
        case .weakPassword:
            errorDescription = "A senha deve ter 6 caracteres ou mais."
            return errorDescription
        case .invalidEmail:
            errorDescription = "O e-mail tem um formato inválido."
            return errorDescription
        case .wrongPassword:
            errorDescription = "A senha está incorreta."
            return errorDescription
        case .userNotFound:
            errorDescription = "Não existe usuário cadastrado com esse e-mail."
            return errorDescription
        case .emailAlreadyInUse:
            errorDescription = "Esse e-mail já ese encontra em uso."
            return errorDescription
        default:
            return "Algo deu erro."
        }
    }

}
