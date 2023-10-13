//
//  ContentView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 02.10.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
                ListView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    HorizontalScrollView()
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
