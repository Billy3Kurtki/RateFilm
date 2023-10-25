//
//  ColorSchemeExtension.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 25.10.2023.
//

import SwiftUI

enum SchemeType: String, Identifiable, CaseIterable {
    var id: Self { self }
    case system = "📱 System"
    case light = "☀️ Light"
    case dark = "🌑 Dark"
}

extension SchemeType {
    var title: String {
        switch self {
        case .system:
            return self.rawValue
        case .light:
            return self.rawValue
        case .dark:
            return self.rawValue
        }
    }
}

extension ColorScheme {
    static func selectedScheme(scheme: String?) -> ColorScheme? {
        guard let scheme = scheme,
              let theme = SchemeType(rawValue: scheme)
        else { return nil }
        
        switch theme {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return nil
        }
    }
}
