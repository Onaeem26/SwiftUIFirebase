//
//  EntityViewModel.swift
//  FirebaseAuthentication
//
//  Created by Muhammad Osama Naeem on 9/2/21.
//

import Foundation
import Firebase

class EntityViewModel: ObservableObject {
    @Published var entity: Entity = Entity(authorID: "", text: "", createdAt: Date())
    private var db = Firestore.firestore()
    
    func addEntity(entity: Entity) {
        do {
            let _ = try db.collection("entities").addDocument(from: entity)
        }
        catch {
            print(error)
        }
    }
    
    func save() {
        addEntity(entity: entity)
    }
}
