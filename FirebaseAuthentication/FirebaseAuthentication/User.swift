//
//  User.swift
//  FirebaseAuthentication
//
//  Created by Muhammad Osama Naeem on 8/25/21.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Encodable, Identifiable, Equatable {
    var id: String?
    var fullName: String?
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName
        case email
      }
}
