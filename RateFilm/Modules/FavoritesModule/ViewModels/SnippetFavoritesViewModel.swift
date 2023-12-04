//
//  SnippetFavoritesViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 03.12.2023.
//

import Foundation

struct SnippetFavoritesViewModel: Identifiable {
    var id: String
    var name: String
    var releaseDate: String?
    var description: String
    var previewImage: String
    var avgRating: String?
    var seriesCount: String?
    var isFavorite: Bool
    var favoriteSelection: MovieStatus
}
