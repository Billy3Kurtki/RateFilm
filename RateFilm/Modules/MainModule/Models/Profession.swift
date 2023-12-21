//
//  Profession.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.12.2023.
//

import SwiftUI

enum Profession: LocalizedStringKey, CaseIterable {
    case actor = "Actor"
    case autor = "Autor"
    
    func localizeString() -> String {
        return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
    }
}
