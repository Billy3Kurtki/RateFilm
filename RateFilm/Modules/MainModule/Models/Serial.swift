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
    var previewImage: ImageModel
    var avgRating: Float?
    var ageRating: Int
    var genre: [String]
    var isFavorite: Bool
    var status: String
    var isAnnouncement: Bool
    var isOngoing: Bool
    var countSeriesLeft: Int
    var countSeriesMax: Int?
    var lastSeriesReleaseDate: Int?
    var country: String?
    var userRating: Int?
}
