//
//  UserDetailInfo.swift
//  FirebaseAuthentication
//
//  Created by Muhammad Osama Naeem on 9/2/21.
//

import Foundation

struct Entity: Encodable, Identifiable {
    var id: String = UUID().uuidString
    var authorID: String = ""
    var text: String = ""
    var createdAt: Date?
    
//    enum CodingKeys: String, CodingKey {
//        case authorID
//        case text
//        case createdAt
//      }
}
