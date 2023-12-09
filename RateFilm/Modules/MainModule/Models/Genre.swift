//
//  Genre.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.12.2023.
//

import SwiftUI

enum Genre: LocalizedStringKey, CaseIterable {
    case action = "Action"
    case fantasy = "Fantasy"
    case horror = "Horror"
    
    func localizeString() -> String {
        return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
    }
}

