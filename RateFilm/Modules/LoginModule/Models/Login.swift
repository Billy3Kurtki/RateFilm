//
//  Login.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 07.10.2023.
//

import Foundation

enum UserTypes {
    case admin
    case authUser
    case unauthUser
}

struct Login: Codable {
    var userLogin: String
    var password: String
}

