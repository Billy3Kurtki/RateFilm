//
//  MovieViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 30.10.2023.
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
    var mainViewSelection: [MainViewSelections]
    var isFavorite: Bool
    var favoriteSelection: MovieStatus
}

