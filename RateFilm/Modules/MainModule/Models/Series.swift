//
//  Series.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 04.12.2023.
//

import Foundation

struct Series: Codable {
    var id: String
    var name: String
    var duration: Int
    var realeseDate: Int?
    var previewImage: ImageModel
    var avgRating: Float
}
