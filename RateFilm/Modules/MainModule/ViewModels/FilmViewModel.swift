//
//  FilmViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 15.10.2023.
//

import Foundation
import UIKit

struct FilmViewModel: Identifiable {
    var id: String
    var name: String
    var releaseDate: String?
    var description: String
    var previewImage: String
    var avgRating: String
}
