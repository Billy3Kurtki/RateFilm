//
//  UserMini.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 09.12.2023.
//

import Foundation

struct UserMini: Identifiable, Codable {
    var id: String
    var username: String
    var image: ImageModel?
}
