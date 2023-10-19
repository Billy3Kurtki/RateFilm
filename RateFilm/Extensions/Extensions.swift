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
}
