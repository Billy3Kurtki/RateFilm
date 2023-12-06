//
//  SnippetFavoritesViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 06.12.2023.
//

import Foundation

struct SnippetViewModel: Identifiable {
    var id: String
    var name: String
    var releaseDate: String?
    var description: String
    var previewImage: String
    var avgRating: String?
    var seriesCount: String?
    var movieType: MovieType
    var isFavorite: Bool
    var movieStatus: MovieStatus
}
