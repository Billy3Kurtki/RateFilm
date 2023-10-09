//
//  Serial.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 06.10.2023.
//

import Foundation

struct Serial: Identifiable {
    var id: String
    var name: String
    var description: String
    var duration: Int
    var previewImage: ImageModel
    var images: [ImageModel]
    var avgRating: Double = 0.0
    var seriesCount: Int
    var series: [Series]
    var ageRating: Int
}

struct Series {
    var id: String
    var name: String
    var duration: String
}
