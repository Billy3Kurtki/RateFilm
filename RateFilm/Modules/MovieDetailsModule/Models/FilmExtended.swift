//
//  FilmExtended.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 09.12.2023.
//

import Foundation

struct FilmExtended: Codable {
    var id: String
    var name: String
    var releaseDate: Int?
    var description: String
    var duration: Int
    var previewImage: ImageModel
    var images: [ImageModel]?
    var avgRating: Float?
    var ageRating: Int
    var genre: [String]
    var people: [Person]
    var isFavorite: Bool
    var isAnnouncement: Bool
    var status: String?
    var country: String?
    var userRating: Int?
    var comments: [Comment]?
    var ratings: [Int : Int]?
    var statusOfPeople: [String : Int]
}
