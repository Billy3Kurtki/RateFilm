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
    var releaseDate: String
    var duration: String?
    var previewImage: ImageModel
    var images: [ImageModel]?
    var avgRating: String
    var ageRating: String
    var genre: [Genre]
    var peopleDescription: String?
    var isFavorite: Bool
    var movieType: MovieType
    var movieTypeString: String
    var seasons: [Season]?
    var status: MovieStatus
    var isAnnouncement: Bool
    var isOngoing: Bool
    var seriesCount: String?
    var lastSeriesReleaseDate: Int?
    var country: String?
    var userRating: Int?
    var comments: [CommentViewModel]?
    var ratings: [Int : Int]?
    var countRatings: Int
    var statusOfPeople: [MovieStatus : Int]
}
