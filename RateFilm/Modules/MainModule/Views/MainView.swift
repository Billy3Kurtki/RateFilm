//
//  ContentView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 02.10.2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedCategory: MainViewSelections = MainViewSelections.lastReleased
    
    var body: some View {
        TabView(selection: $selectedCategory) {
            //пока так, через ForEach пока не получилось.
            NavigationStack {
                ListView(filterBy: $selectedCategory)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem {
                            HorizontalScrollView(selectedCategory: $selectedCategory)
                        }
                    }
            }
            .tag(selectedCategory)
            NavigationStack {
                ListView(filterBy: $selectedCategory)
            }
            .tag(selectedCategory)
            NavigationStack {
                ListView(filterBy: $selectedCategory)
            }
            .tag(selectedCategory)
            NavigationStack {
                ListView(filterBy: $selectedCategory)
            }
            .tag(selectedCategory)
            NavigationStack {
                ListView(filterBy: $selectedCategory)
            }
            .tag(selectedCategory)
            NavigationStack {
                ListView(filterBy: $selectedCategory)
            }
            .tag(selectedCategory)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
