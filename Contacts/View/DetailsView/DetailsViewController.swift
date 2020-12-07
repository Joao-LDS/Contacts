//
//  DetailsContactViewController.swift
//  Contacts
//
//  Created by João Santos on 16/02/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

enum ActionSheetType {
    case localize, callOrSMS
}

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
        uiview.imageView.image = contact.photo as? UIImage
        uiview.nameLabel.text = contact.name
        let emptyString = ""
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
    }
    
    
    // MARK: - Selectors
    
    @IBAction func tel(_ sender: Any) {
        guard let number = contact.phone else { return }
        // Faz ligação
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func sms(_ sender: Any) {
        if let componentSMS = message.configSMS(contact) {
            componentSMS.messageComposeDelegate = message // Delegate de componentSMS será a classa Message()
            present(componentSMS, animated: true, completion: nil)
        }
    }
    
    func showActionSheet(_ type: ActionSheetType) {
        switch type {
        case .localize:
            present(actionSheetForLocalize(), animated: true)
        case .callOrSMS:
            present(actionSheetForCallOrSMS(), animated: true)
        }
    }
    
    func actionSheetForLocalize() -> UIAlertController {
        var actions: [UIAlertAction] = []
        
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            actions.append(UIAlertAction(title: "Waze", style: .default) { (alert) in
                self.viewModel.waze()
            })
        }
        actions.append(UIAlertAction(title: "Maps", style: .default) { (map) in
            self.maps()
        })
        actions.append(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        let actionSheet = UIAlertController().create(title: nil,
                                                     message: "Selecione uma opção",
                                                     preferredStyle: .actionSheet,
                                                     actions: actions)
        return actionSheet
    }
    
    func actionSheetForCallOrSMS() -> UIAlertController {
        var actions: [UIAlertAction] = []
        
        actions.append(UIAlertAction(title: "Ligar", style: .default) { _ in
            
        })
        actions.append(UIAlertAction(title: "SMS", style: .default) { _ in
            
        })
        
        let actionSheet = UIAlertController().create(title: nil,
                                                     message: "Selecione uma opção",
                                                     preferredStyle: .actionSheet,
                                                     actions: actions)
        
        return actionSheet
    }
    
    func maps() {
        let map = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "map") as! MapViewController
        map.contact = contact
        self.navigationController?.pushViewController(map, animated: true)
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
        showActionSheet(.localize)
    }
    
    @objc func tappedCall() {
        showActionSheet(.callOrSMS)
    }
}

extension DetailsViewController: DetailsViewModelDelegate {
    func uiapplicationOpen(_ url: URL) {
        UIApplication.shared.open(url, options: [:])
    }
}
