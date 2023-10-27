//
//  MainViewSelectionsEnum.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 28.10.2023.
//

import SwiftUI

enum MainViewSelections: LocalizedStringKey, CaseIterable { // через static var ... : LocalizedStringKey не получится, тк нужно, чтобы осталось соответствие CaseIterable
    case mySelection = "mySelection"
    case lastReleased = "lastReleased"
    case ongoings = "ongoings"
    case announcement = "announcement"
    case films = "films"
    case serials = "serials"
//    case movie = "movie" // добавился, всё работает
    
    func localizeString() -> String {
        return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
    }
}
