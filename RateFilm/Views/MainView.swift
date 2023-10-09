//
//  ContentView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 02.10.2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedCategory: String = "Категория 1"
    var categories = ["Категорияfafafaff 1", "Категория 2", "Категория 3"]
    var items = ["Категория 1": ["Элемент 1", "Элемент 2", "Элемент 3"], "Категория 2": ["Элемент 4", "Элемент 5", "Элемент 6"], "Категория 3": ["Элемент 7", "Элемент 8", "Элемент 9"]]
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                    Spacer(minLength: 20)
                    ForEach(categories, id: \.self) { category in
                        Button {
                            self.selectedCategory = category
                        } label: {
                            VStack {
                                Text(category)
                                    .padding()
                                    .foregroundStyle(self.selectedCategory == category ? Color.red : Color.black)
                                    .font(.system(size: 19))
                                Capsule()
                                    .foregroundStyle(self.selectedCategory == category ? Color.red : Color.clear)
                                    .frame(height: 4)
                                
                            }.fixedSize()
                        }
                        
                    }
                }
            }
        }.onAppear {
            self.selectedCategory = categories.first!
        }
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
