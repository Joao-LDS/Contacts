//
//  ViewController+CoreData.swift
//  Contacts
//
//  Created by João Luis dos Santos on 01/04/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    /*
     Classe criada para toda UIViewController ter acesso ao NSPersistentContainer do Core Data no AppDelegate
     */
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // Estância para a classe AppDelegate
        return appDelegate.persistentContainer.viewContext // Recupera o NSPersistentContainer
    }

}
