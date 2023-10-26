//
//  SettingsView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 25.10.2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("systemThemeVal") private var systemTheme: String = SchemeType.allCases.first!.rawValue

    var body: some View {
            Picker(selection: $systemTheme) {
                ForEach (SchemeType.allCases) { item in
                    Text(item.title)
                        .tag(item.rawValue)
                }
            } label: {
                Text("Pick a theme")
                    .foregroundStyle(Color.customBlack)
            }
            .background(.green, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SettingsView()
}
