//
//  MovieCard.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 05.12.2023.
//

import Foundation

struct MovieCard {
    var id: String
    var name: String
    var description: String
    var duration: Int?
    var previewImage: ImageModel
    var images: [ImageModel]?
    var avgRating: Float
    var ageRating: Int
    var genre: [Genre]
    var people: [Person]
    var isFavorite: Bool
    var favoritesSelection: MovieStatus
    var movieType: MovieType
    var seasons: [Season]?
}
