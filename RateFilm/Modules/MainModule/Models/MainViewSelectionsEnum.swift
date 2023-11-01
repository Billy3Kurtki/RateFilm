//
//  MainViewSelectionsEnum.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 28.10.2023.
//

import SwiftUI

enum MainViewSelections: LocalizedStringKey, CaseIterable {
    case mySelection = "mySelection"
    case lastReleased = "lastReleased"
    case ongoings = "ongoings"
    case announcement = "announcement"
    case completed = "completed"
    case serials = "serials"
    case films = "films"
    
    func localizeString() -> String {
        return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
    }
}
