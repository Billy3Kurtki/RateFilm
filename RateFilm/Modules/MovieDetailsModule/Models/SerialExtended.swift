//
//  SerialExtended.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 09.12.2023.
//

import Foundation

struct SerialExtended: Codable {
    var id: String
    var name: String
    var releaseDate: Int?
    var description: String
    var previewImage: ImageModel
    var avgRating: Float
    var seasons: [Season]
    var ageRating: Int
    var moveTypes: [Genre]
    var people: [Person]
    var isFavorite: Bool
    var status: String?
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
