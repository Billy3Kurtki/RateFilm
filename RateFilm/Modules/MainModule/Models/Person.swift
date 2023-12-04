//
//  Person.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 04.12.2023.
//

import Foundation

struct Person: Codable {
    var id: String
    var name: String
    var age: Int
    var image: ImageModel
    var professions: [Profession]
}

enum Profession: Codable {
    case Actor
    case Autor
}
