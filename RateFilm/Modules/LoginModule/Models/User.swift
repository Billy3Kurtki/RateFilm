//
//  User.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 04.10.2023.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var name: String?
    var userName: String
    var email: String
    var phone: String?
    var age: Int?
    var userType: UserTypes
}

// MARK: Inittializer for unauthorized user
extension User {
    init() {
        self.id = ""
        self.name = ""
        self.userName = ""
        self.email = ""
        self.age = 0
        self.userType = .unauthUser
    }
}
