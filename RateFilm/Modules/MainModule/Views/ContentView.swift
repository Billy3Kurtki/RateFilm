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
        }
    }
}

enum TabBarSelections: String {
    case main = "Главная"
    case review = "Обзор"
    case bookMarks = "Закладки"
    case profile = "Профиль"
}



#Preview {
    ContentView()
}


