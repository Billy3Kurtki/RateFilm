//
//  FavoriteMovie.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 24.12.2023.
//

import Foundation

struct FavoriteMovie: Encodable {
    var movieId: String
    var statusMovie: String?
    var isFavorite: Bool?
    var score: Int?
}
