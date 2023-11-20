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
    var releaseDate: Int? // UnixTimestamp
    var description: String
    var duration: Int
    var previewImage: String
    var images: [ImageModel]?
    var avgRating: Float
    var ageRating: Int
    var moveTypes: [MovieType]
    var author: String
    var actors: [ActorModel]?
}

enum MovieType: String, Codable {
    case action = "Экшен"
    case fantasy = "Фэнтези"
}
