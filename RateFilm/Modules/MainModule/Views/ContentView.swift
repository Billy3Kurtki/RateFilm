//
//  TabBarView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.10.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("systemThemeVal") private var systemTheme: String = SchemeType.allCases.first!.rawValue
    @State var animateIsActive = false
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Text(TabBarSelections.main.stringValue())
                    Image(systemName: Images.house.rawValue)
                }
//            SearchView()
//                .tabItem {
//                    Text(TabBarSelections.search.stringValue())
//                    Image(systemName: Images.lupo.rawValue)
//                }
            FavoritesView()
                .tabItem {
                    Text(TabBarSelections.favorites.stringValue())
                    Image(systemName: Images.bookmark.rawValue)
                }
            ProfileView()
                .tabItem {
                    Text(TabBarSelections.profile.stringValue())
                    Image(systemName: Images.personFill.rawValue)
                }
        }
        .preferredColorScheme(ColorScheme.selectedScheme(scheme: systemTheme))
    }
    
    enum Images: String {
        case house = "house"
        case lupo = "magnifyingglass"
        case bookmark = "bookmark"
        case personFill = "person.crop.circle.fill"
    }
}

enum TabBarSelections {
    static var main: LocalizedStringKey = "mainLabel"
    static var review: LocalizedStringKey = "reviewLabel"
    static var search: LocalizedStringKey = "searchLabel"
    static var favorites: LocalizedStringKey = "favoritesLabel"
    static var profile: LocalizedStringKey = "profileLabel"
}



#Preview {
    ContentView()
}


