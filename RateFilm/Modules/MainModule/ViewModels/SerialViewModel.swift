//
//  SerialViewModel.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 15.10.2023.
//

import Foundation
import UIKit

struct SerialViewModel: Identifiable {
    var id: String
    var name: String
    var releaseDate: Date?
    var description: String
    var previewImage: UIImage?
    var avgRating: String?
    var seriesCount: Int
}
