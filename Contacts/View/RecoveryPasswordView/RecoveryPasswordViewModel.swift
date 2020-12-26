//
//  RecoveryPasswordViewModel.swift
//  Contacts
//
//  Created by João Luis Santos on 21/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

class RecoveryPasswordViewModel {
    
    var signErrorDescription: SignErrorDelegate?
    var dismissViewDelegate: DismissViewDelegate?
    
    func send(Email email: String) {
        AuthService().sendEmailRecoveryPassoword(email) { sucess, errorDescription in
            if sucess == false && errorDescription != nil {
                self.signErrorDescription?.showAlertWithError(message: errorDescription!)
                return
            }
            self.dismissViewDelegate?.dismissRecoveryView()
        }
    }
}
