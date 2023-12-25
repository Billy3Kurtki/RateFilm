//
//  Genre.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.12.2023.
//

import SwiftUI

enum Genre: LocalizedStringKey, CaseIterable {
    case none = "None"
    case action = "Action"
    case fantasy = "Fantasy"
    case horror = "Horror"
    case adventure = "Adventure"
    case animated = "Animated"
    case anime = "Anime"
    case comedy = "Comedy"
    case drama = "Drama"
    case thriller = "Thriller"
    case historical = "Historical"
    case romance = "Romance"
    case crime = "Crime"
    
    
    func localizeString() -> String {
        return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
    }
}

