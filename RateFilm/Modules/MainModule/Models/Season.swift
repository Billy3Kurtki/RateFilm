//
//  Season.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 04.12.2023.
//

import Foundation

struct Season: Codable {
    var id: String
    var releaseDate: Int?
    var description: String
    var images: [ImageModel]?
    var avgRating: Float?
    var series: [Series]
}
