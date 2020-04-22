//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by João Santos on 23/02/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var imageContact: UIImageView!
    @IBOutlet weak var labelContact: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var cell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageContact.layer.cornerRadius = 5.0
        self.imageContact.clipsToBounds = true
        self.viewCell.layer.cornerRadius = 5.0
        self.viewCell.layer.masksToBounds = false
        self.viewCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.viewCell.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.viewCell.layer.shadowOpacity = 0.23
        self.viewCell.layer.shadowRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(with contact: Contact) { // Prepara a cell
        labelContact.text = contact.name
        labelNumber.text = contact.phoneNumber
        if let image = contact.image as? UIImage { // Se houver um imagem
            imageContact.image = image
        }
    }
}
