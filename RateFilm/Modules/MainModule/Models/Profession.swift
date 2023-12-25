//
//  Profession.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.12.2023.
//

import SwiftUI

enum Profession: LocalizedStringKey, CaseIterable {
    case none
    case actor = "Actor"
    case autor = "Autor"
    case director = "Director"
    case manage = "Manager"
    case screenWriter = "ScreenWriter"
    case producer = "Producer"
    case productionDesigner = "ProductionDesigner"
    case editor = "Editor"
    case composer = "Composer"
    
    func localizeString() -> String {
        return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
    }
}
