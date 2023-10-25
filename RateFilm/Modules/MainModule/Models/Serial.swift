//
//  Serial.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 06.10.2023.
//

import Foundation

struct Serial: Identifiable, Codable {
    var id: String
    var name: String
    var releaseDate: Int?
    var description: String
    var duration: Int
    var previewImage: String
    var avgRating: Float
    var seriesCount: Int
    var seasons: [Season]
    var ageRating: Int
    var moveTypes: [MovieType]
    var author: String
}

struct Season: Codable {
    var id: String
    var releaseDate: Date
    var description: String
    var images: [ImageModel]?
    var avgRating: Float = 0.0
    var actors: [ActorModel]?
}

