//
//  User.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 04.10.2023.
//

import Foundation

struct NetworkUser: Codable {
    var id: String
    var userName: String
    var userType: String
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userName = "username"
        case userType = "role"
        case token = "token"
    }
}

struct User: Identifiable {
    var id: String
    var userName: String
    var userType: UserTypes
    var token: String
}

// MARK: Inittializer for unauthorized user
extension User {
    init() {
        self.id = ""
        self.userName = ""
        self.userType = .unauthUser
        self.token = ""
    }
}
