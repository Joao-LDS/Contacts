//
//  AppDelegate.swift
//  Contacts
//
//  Created by João Santos on 15/02/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let viewModel = ContactListViewModel()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ContactsListTableViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()
        
        return true
    }

}

