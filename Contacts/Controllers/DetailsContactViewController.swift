//
//  DetailsContactViewController.swift
//  Contacts
//
//  Created by João Santos on 16/02/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class DetailsContactViewController: UIViewController {
    
    var contact: Contact!
    let message = Message() // Usada para trabalhar com o SMS
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageContact.image = contact.image as? UIImage
        self.nameLabel.text = contact.name
        self.numberPhoneLabel.text = contact.phoneNumber
        self.emailLabel.text = contact.email
        self.addressLabel.text = contact.address
        self.typeLabel.text = contact.type?.name
        self.imageContact.layer.cornerRadius = 5.0
        self.imageContact.layer.masksToBounds = true
        viewWithBorderAndShadow(viewDetails, cornerRadius: 20.0)
        viewWithBorderAndShadow(viewWithBorderShadow, cornerRadius: 5.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            let vc = segue.destination as! FormViewController
            vc.contact = contact
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageContact: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberPhoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var viewWithBorderShadow: UIView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var viewType: UIView!
    
    
    // MARK: - IBAction
    @IBAction func mapButton(_ sender: Any) {
        alertAction()
    }
    @IBAction func tel(_ sender: Any) {
        guard let number = contact.phoneNumber else { return }
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
    
    func alertAction() {
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

    
    func viewWithBorderAndShadow(_ vw: UIView, cornerRadius: CGFloat) {
        vw.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        vw.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        vw.layer.shadowOpacity = 0.30
        vw.layer.shadowRadius = 5.0
        vw.layer.cornerRadius = cornerRadius
    }
}
