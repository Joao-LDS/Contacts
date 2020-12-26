//
//  FirestorageService.swift
//  Contacts
//
//  Created by João Luis Santos on 22/12/20.
//  Copyright © 2020 João Santos. All rights reserved.
//

import FirebaseStorage

class FirestorageService {
    
    static let shared = FirestorageService()
    let refImages = Storage.storage().reference().child("images")
    let userId = AuthService().userId()
    
    func upload(_ photo: Data, idContact: String) {
        let refUser = refImages.child(userId)
        let refContactPhoto = refUser.child("\(idContact).jpg")
        refContactPhoto.putData(photo, metadata: nil) { metadata, error in
            if let error = error {
                print("Storage Error: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func fetch(at ids: [String], completion: @escaping(Bool) -> Void) {
        let refUser = refImages.child(userId)
        let dispatchGroup = DispatchGroup()
        for id in ids {
            dispatchGroup.enter()
            let refContactPhoto = refUser.child("\(id).jpg")
            let documentUrl = DocumentDirectory().urlToImages(id)
            let downloadTask = refContactPhoto.write(toFile: documentUrl, completion: nil)
            downloadTask.observe(.success) { _ in
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion(true)
        }
    }
    
    func delete(at id: String) {
        let refUser = refImages.child(userId)
        let refContactPhoto = refUser.child("\(id).jpg")
        refContactPhoto.delete { error in
            if let error = error {
                print("Storage Error: \(error.localizedDescription)")
                return
            }
        }
    }
}
