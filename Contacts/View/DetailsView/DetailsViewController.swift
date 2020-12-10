//
//  DetailsContactViewController.swift
//  Contacts
//
//  Created by João Santos on 16/02/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit
import MessageUI

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var contact: Contact!
    let message = Message() // Usada para trabalhar com o SMS
    let viewModel: DetailsViewModel
    var uiview: DetailsView
    
    // MARK: - Init
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        self.uiview = DetailsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        self.view = uiview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.delegate = self
    }
    
    // MARK: - Functions
    
    func configureView() {
        let contact = viewModel.contact
        let emptyString = ""
        
        uiview.imageView.image = contact.photo as? UIImage
        uiview.nameLabel.text = contact.name
        
        if contact.phone != emptyString {
            uiview.createView(WithText: "\(contact.phone!)")
            uiview.callButton.isHidden = false
            uiview.messageButton.isHidden = false
        }
        if contact.address != emptyString {
            uiview.createView(WithText: "\(contact.address!)")
            uiview.localizeButton.isHidden = false
        }
        if contact.email != emptyString {
            uiview.createView(WithText: "\(contact.email!)")
            uiview.messageButton.isHidden = false
        }
        if let groupName = contact.group?.name, groupName != emptyString {
            uiview.createView(WithText: "\(groupName)")
        }
        
        uiview.backButton.addTarget(self, action: #selector(self.tappedBack), for: .touchUpInside)
        uiview.editButton.addTarget(self, action: #selector(self.tappedEdit), for: .touchUpInside)
        uiview.localizeButton.addTarget(self, action: #selector(self.tappedLocalize), for: .touchUpInside)
        uiview.callButton.addTarget(self, action: #selector(self.tappedCall), for: .touchUpInside)
        uiview.messageButton.addTarget(self, action: #selector(self.tappedMessage), for: .touchUpInside)
    }
    
    
    // MARK: - Functions

    func showActionSheetForLocalize() {
        var actions: [UIAlertAction] = []
        
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            actions.append(UIAlertAction(title: "Waze", style: .default) { _ in
                self.viewModel.waze()
            })
        }
        actions.append(UIAlertAction(title: "Maps", style: .default) { _ in
            let viewModel = MapViewModel(address: self.viewModel.contact.address!)
            let controller = MapViewController(viewModel: viewModel)
            self.present(controller, animated: true)
        })
        
        let actionSheet = UIAlertController().create(title: nil,
                                                     message: "Selecione uma opção",
                                                     preferredStyle: .actionSheet,
                                                     actions: actions)
        present(actionSheet, animated: true)
    }
    
    func showActionSheetForMessage() {
        let contact = viewModel.contact
        let emptyString = ""
        var actions: [UIAlertAction] = []
        
        if contact.phone != emptyString {
            actions.append(UIAlertAction(title: "SMS", style: .default) { _ in
                self.viewModel.SMS()
            })
        }
        
        if contact.email != emptyString {
            actions.append(UIAlertAction(title: "E-mail", style: .default) { _ in
                let mailController = self.configureMail()
                if MFMailComposeViewController.canSendMail() {
                    self.present(mailController, animated: true)
                }
            })
        }
        
        let actionSheet = UIAlertController().create(title: nil,
                                                     message: "Selecione uma opção",
                                                     preferredStyle: .actionSheet,
                                                     actions: actions)
        present(actionSheet, animated: true)
    }
    
    func configureMail() -> MFMailComposeViewController {
        let controller = MFMailComposeViewController()
        controller.mailComposeDelegate = self
        controller.setToRecipients([self.viewModel.contact.email!])
        return controller
    }
    
    // MARK: - Selectors
    
    @objc func tappedBack() {
        dismiss(animated: true)
    }
    
    @objc func tappedEdit() {
        let viewModel = FormViewModel(contact: self.viewModel.contact)
        let controller = FormViewController(viewModel: viewModel)
        present(controller, animated: true)
    }
    
    @objc func tappedLocalize() {
        showActionSheetForLocalize()
    }
    
    @objc func tappedCall() {
        viewModel.call()
    }
    
    @objc func tappedMessage() {
        showActionSheetForMessage()
    }
    
}

extension DetailsViewController: DetailsViewModelDelegate {
    func uiapplicationOpen(_ url: URL) {
        UIApplication.shared.open(url, options: [:])
    }
    
    func presentView(controller: UIViewController) {
        present(controller, animated: true)
    }
}

extension DetailsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
