//
//  DocumentDirectory.swift
//  Contacts
//
//  Created by João Luis Santos on 23/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import Foundation

class DocumentDirectory {
    func urlToImages(_ id: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask).first!.appendingPathComponent("images/\(id).jpg")
    }
    
    func urlToCoreData() -> URL {
        return FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask).first!.appendingPathComponent("contacts/\(AuthService().userId())/\(AuthService().userId())")
    }
}
