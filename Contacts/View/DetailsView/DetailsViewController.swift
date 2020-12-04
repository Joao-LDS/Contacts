//
//  DetailsContactViewController.swift
//  Contacts
//
//  Created by João Santos on 16/02/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

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
    }
    
    // MARK: - Functions
    
    func configureView() {
        let contact = viewModel.contact
        uiview.imageView.image = contact.photo as? UIImage
        uiview.nameLabel.text = contact.name
        let emptyString = ""
        if contact.phone != emptyString {
            uiview.createLabel(With: "Telefone: \(contact.phone!)")
            uiview.callButton.isHidden = false
            uiview.messageButton.isHidden = false
        }
        if contact.address != emptyString {
            uiview.createLabel(With: "Endereço: \(contact.address!)")
            uiview.localizeButton.isHidden = false
        }
        if contact.email != emptyString {
            uiview.createLabel(With: "E-mail: \(contact.email!)")
            uiview.messageButton.isHidden = false
        }
        if let groupName = contact.group?.name, groupName != emptyString {
            uiview.createLabel(With: "Grupo: \(groupName)")
        }
        
        uiview.backButton.addTarget(self, action: #selector(self.tappedBack), for: .touchUpInside)
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
    
    func showActionSheet() {
        let alert = UIAlertController(title: "Ok", message: "Select an option:", preferredStyle: .actionSheet)
        let waze = UIAlertAction(title: "Waze", style: .default) { (alert) in
            self.waze()
        }
        let maps = UIAlertAction(title: "Maps", style: .default) { (map) in
            self.maps()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(waze)
        alert.addAction(maps)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func waze() {
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {  // Verifica se o waze está instalado
            guard let addressContact = contact.address else { return }
            Location().convertAddressToCordinate(address: addressContact) { (foundLocation) in
                // Converte as coordenadas em String
                let latitude = String(describing: foundLocation.location!.coordinate.latitude)
                let longitude = String(describing: foundLocation.location!.coordinate.longitude)
                
                print("\(latitude), \(longitude)")
                
                // Cria URL para abrir o waze
                let url: String = "waze://?ll=\(latitude),\(longitude)&navigate=yes" // Waze a bre nas coordenadas e inicia a navegação
                print(url)
                
                // Abre o Waze
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil) // [:]
                
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Waze is not available!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
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
}
