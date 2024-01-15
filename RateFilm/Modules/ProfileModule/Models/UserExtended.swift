//
//  UserExtended.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 12.12.2023.
//

import Foundation

struct UserExtended: Codable {
    var id: String
    var name: String?
    var username: String
    var image: ImageModel?
    var email: String
    var phone: String?
    var age: Int?
    var statisticStatus: [String : Int]
}
