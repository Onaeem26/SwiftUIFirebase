//
//  EntitiesViewModel.swift
//  FirebaseAuthentication
//
//  Created by Muhammad Osama Naeem on 9/2/21.
//

import Foundation
import FirebaseFirestore
import Combine

class EntitiesViewModel: ObservableObject {
    @Published var entities = [Entity]()
    
    private var db = Firestore.firestore()
    
    func fetchData(id: String) {
        print("Called: ", id)
        db.collection("entities").whereField("authorID", isEqualTo: id)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("No Documents")
                    return
                }
                print(documents.count)
                 
                self.entities = documents.map { (queryDocumentSnapshot) -> Entity in
                    let data = queryDocumentSnapshot.data()

                    let id = data["authorID"] as? String ?? ""
                    let text = data["text"] as? String ?? ""
                    let createdAt = data["createdAt"] as? Date

                    return Entity(authorID: id, text: text, createdAt: createdAt)
                }
            }
    }
}
