//
//  Film.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 05.10.2023.
//

import Foundation

struct Film: Codable {
    var id: String
    var name: String
    var description: String
    var releaseDate: Int?
    var genre: [String]
    var previewImage: ImageModel
    var avgRating: Float?
    var ageRating: Int
    var isAnnouncement: Bool
    var isFavorite: Bool
    var status: String
    var country: String?
    var userRating: Int?
}
