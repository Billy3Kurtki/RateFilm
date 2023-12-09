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
    var movieType: MovieType
    var seasons: [Season]?
    
    var status: MovieStatus
    var isAnnouncement: Bool
    var isOngoing: Bool
    var countSeriesLeft: Int
    var countSeriesMax: Int?
    var lastSeriesRealeseDate: Int?
    var country: String?
    var userRating: Int?
    var comments: Comment?
    var ratings: [Int : Int]?
    var statusOfPeople: [String : Int]?
}
