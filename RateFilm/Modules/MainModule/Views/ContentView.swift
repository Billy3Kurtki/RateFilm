//
//  TabBarView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.10.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("systemThemeVal") private var systemTheme: String = SchemeType.allCases.first!.rawValue
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Text(TabBarSelections.main.stringValue())
                    Image(systemName: "house")
                }
            ReviewView()
                .tabItem {
                    Text(TabBarSelections.review.stringValue())
                    Image(systemName: "safari")
                }
            FavoritesView()
                .tabItem {
                    Text(TabBarSelections.favorites.stringValue())
                    Image(systemName: "bookmark")
                }
            ProfileView()
                .tabItem {
                    Text(TabBarSelections.profile.stringValue())
                    Image(systemName: "person.crop.circle.fill")
                }
            LoginView() // Для теста тёмной темы, потом уберу
                .tabItem {
                    Text("SignIn")
                    Image(systemName: "person")
                }
        }.preferredColorScheme(ColorScheme.selectedScheme(scheme: systemTheme))
    }
}

enum TabBarSelections {
    static var main: LocalizedStringKey = "mainLabel"
    static var review: LocalizedStringKey = "reviewLabel"
    static var favorites: LocalizedStringKey = "favoritesLabel"
    static var profile: LocalizedStringKey = "profileLabel"
}



#Preview {
    ContentView()
}


