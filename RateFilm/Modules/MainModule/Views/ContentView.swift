//
//  TabBarView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.10.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Text(TabBarSelections.main.rawValue)
                    Image(systemName: "house")
                }
            ReviewView()
                .tabItem {
                    Text(TabBarSelections.review.rawValue)
                    Image(systemName: "safari")
                }
            FavoritesView()
                .tabItem {
                    Text(TabBarSelections.favorites.rawValue)
                    Image(systemName: "bookmark")
                }
            ProfileView()
                .tabItem {
                    Text(TabBarSelections.profile.rawValue)
                    Image(systemName: "person.crop.circle.fill")
                }
        }
    }
}

enum TabBarSelections: String {
    case main = "Главная"
    case review = "Обзор"
    case favorites = "Избранное"
    case profile = "Профиль"
}



#Preview {
    ContentView()
}


