//
//  SettingsView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 25.10.2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("systemThemeVal") private var systemTheme: String = SchemeType.allCases.first!.rawValue
    @Environment(AuthViewModel.self) private var authVM
    
    var body: some View {
        VStack {
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
            Button {
                authVM.currentUser = nil
            } label: {
                Text(LocalizedStrings.logout.localizeString())
                    .foregroundStyle(Color.red)
                    .padding(7)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundStyle(Color.red)
                    }
            }
        }
    }
    enum LocalizedStrings: LocalizedStringKey {
        case logout = "LogoutLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
    
}

#Preview {
    SettingsView()
}
