//
//  NetworkMovies.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 29.11.2023.
//

import Foundation

struct NetworkMovies: Codable {
    var films: [Film]
    var serials: [Serial]
}
