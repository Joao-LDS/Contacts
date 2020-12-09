//
//  Message.swift
//  Contacts
//
//  Created by João Luis dos Santos on 17/04/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit
import MessageUI

class Message: NSObject, MFMessageComposeViewControllerDelegate {

    // Exibe o componente na tela do app
    func configSMS(_ phone: String) -> MFMessageComposeViewController? {
        if MFMessageComposeViewController.canSendText() { // Verifica se o device pode enviar SMS
            let componentSMS = MFMessageComposeViewController()
            componentSMS.recipients = [phone] // Passa o número para SMS
            componentSMS.messageComposeDelegate = self
            return componentSMS
        } else {
            return nil
        }
    }
    
    // MARK: - MessageComposeDelegate
    
    // Método obrigatório de MFMailComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
