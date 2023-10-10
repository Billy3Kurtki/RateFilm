//
//  Actor.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.10.2023.
//

import Foundation

struct ActorModel: Codable {
    var id: String
    var name: String
    var age: String?
    var images: [ImageModel]?
}
