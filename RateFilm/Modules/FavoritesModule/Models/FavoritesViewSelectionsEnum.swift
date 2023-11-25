//
//  FavoritesViewSelectionsEnum.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 28.10.2023.
//

import SwiftUI

enum FavoritesViewSelections: LocalizedStringKey, CaseIterable, Codable {
    case collection = "Collection"
    case history = "History"
    case favourite = "Favorite"
    case looking = "Looking"
    case inThePlans = "InThePlans"
    case viewed = "Viewed"
    case postponed = "Postponed"
    case abandoned = "Abandoned"
    
    func localizeString() -> String {
        return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
    }
}
