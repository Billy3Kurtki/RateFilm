//
//  ContentView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 02.10.2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedCategory: MainViewSelections = MainViewSelections.lastReleased
    @State private var data = ListViewModel()
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedCategory) {
                ForEach(MainViewSelections.allCases, id: \.self) { selection in
                    ListView(snippets: data.getFilteredList(filterBy: selection))
                    .tag(selection)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    HorizontalScrollView(selectedCategory: $selectedCategory)
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
