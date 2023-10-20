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
                    Text(TabBarSelections.main.localizeString())
                    Image(systemName: "house")
                }
            ReviewView()
                .tabItem {
                    Text(TabBarSelections.review.localizeString())
                    Image(systemName: "safari")
                }
            FavoritesView()
                .tabItem {
                    Text(TabBarSelections.favorites.localizeString())
                    Image(systemName: "bookmark")
                }
            ProfileView()
                .tabItem {
                    Text(TabBarSelections.profile.localizeString())
                    Image(systemName: "person.crop.circle.fill")
                }
        }
    }
}

enum TabBarSelections: String {
    case main = "mainLabel"
    case review = "reviewLabel"
    case favorites = "favoritesLabel"
    case profile = "profileLabel"
    
    func localizeString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}



#Preview {
    ContentView()
}


