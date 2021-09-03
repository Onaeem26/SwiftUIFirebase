//
//  PersistenceObservation.swift
//  FirebaseAuthentication
//
//  Created by Muhammad Osama Naeem on 8/26/21.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class PersistenceObservation: ObservableObject {
    @Published var uid: String?
    @Published var user = User()
    
    var db = Firestore.firestore()
    init() {
        self.uid = persistenceLogin()
        if uid != nil {
            fetchDocuments(id: uid!)
        }
    }
    
    func persistenceLogin() -> String? {
        guard let uid = Auth.auth().currentUser?.uid else {
            return nil
        }
        
        return uid
    }
    
    func fetchDocuments(id: String) {
        db.collection("Users").whereField("id", isEqualTo: id)
          .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print(document.data())
                    let docs = document.data()
                    self.user = User(id: docs["id"] as? String, fullName: docs["fullName"] as? String, email: docs["email"] as? String)
                }
            }
        }
    }
}
