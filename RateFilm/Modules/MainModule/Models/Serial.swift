//
//  Serial.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 06.10.2023.
//

import Foundation

struct Serial: Codable {
    var id: String
    var name: String
    var releaseDate: Int?
    var description: String
    var duration: Int
    var previewImage: ImageModel
    var avgRating: Float
    var seasons: [Season]
    var ageRating: Int
    var moveTypes: [Genre]
    var author: String
    var isFavorite: Bool
    var favoritesSelection: MovieStatus
}
