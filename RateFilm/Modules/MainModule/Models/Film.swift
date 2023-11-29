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
    var duration: Int
    var previewImage: String
    var images: [ImageModel]?
    var avgRating: Float
    var ageRating: Int
    var moveTypes: [Genre]
    var author: String
    var actors: [ActorModel]?
    var isFavorite: Bool
    var favoritesSelection: MovieStatus
}

enum Genre: String, Codable {
    case action = "Экшен"
    case fantasy = "Фэнтези"
}
