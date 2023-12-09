//
//  Film.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 05.10.2023.
//

import Foundation

struct Film: Codable {
    var id: String
    var name: String
    var releaseDate: Int?
    var description: String
    var previewImage: ImageModel
    var avgRating: Float
    var ageRating: Int
    var genre: [Genre]
    var isAnnouncement: Bool
    var isFavorite: Bool
    var status: String?
    var country: String?
    var userRating: Int?
}

enum Genre: String, Codable {
    case action = "Экшен"
    case fantasy = "Фэнтези"
}
