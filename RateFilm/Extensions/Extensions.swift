//
//  Extensions.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 16.10.2023.
//

import SwiftUI

extension Date {
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension Color {
    static let customLightGray = Color("lightGray")
    static let customSuperLightGray = Color("superLightGray")
    static let customGray = Color("gray")
    static let customTitleColor = Color("titleColor")
    static let customLightRed = Color("lightRed")
}

extension Image {
    func imageIconModifier(width: CGFloat, height: CGFloat) -> some View {
        self
            .renderingMode(.original)
            .resizable()
            .frame(width: width, height: height)
            .shadow(color: Color(red: 0,
                    green: 0, blue: 0, opacity: 0.3),
                    radius: 3, x: 2, y: 2)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

typealias UnixTimestamp = Int

extension Date {
    var unixTimestamp: UnixTimestamp {
        return UnixTimestamp(self.timeIntervalSince1970 * 1_000)
    }
}

extension UnixTimestamp {
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval((self + 10800000) / 1_000))
    }
}

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

