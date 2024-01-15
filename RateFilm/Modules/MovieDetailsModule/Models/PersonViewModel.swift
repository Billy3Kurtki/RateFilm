//
//  PersonViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 20.12.2023.
//

import Foundation

struct PersonViewModel {
    var id: String
    var name: String
    var age: Int?
    var image: ImageModel?
    var professions: [Profession]
}
