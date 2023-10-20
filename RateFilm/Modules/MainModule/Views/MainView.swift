//
//  ContentView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 02.10.2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedCategory: String = MainViewSelections.lastReleased.localizeString()
    var body: some View {
        NavigationStack {
            VStack {
                ListView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
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
