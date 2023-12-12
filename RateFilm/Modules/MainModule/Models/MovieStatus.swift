//
//  MovieSelectionsEnum.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 28.11.2023.
//

import SwiftUI

enum MovieStatus: LocalizedStringKey, Codable, CaseIterable {
    case none = "DontWatching"
    case looking = "Looking"
    case inThePlans = "InThePlans"
    case viewed = "Viewed"
    case postponed = "Postponed"
    case abandoned = "Abandoned"
    
    func localizeString() -> String {
        return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
    }
}
