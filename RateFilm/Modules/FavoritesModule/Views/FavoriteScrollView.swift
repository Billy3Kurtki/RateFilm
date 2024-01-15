//
//  FavoriteScrollView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 10.12.2023.
//

import SwiftUI

struct FavoritesHorizontalScrollView: View {
    @Binding var selectedCategory: FavoritesViewSelections
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer(minLength: 20)
                    ForEach(FavoritesViewSelections.allCases, id: \.self) { selection in
                        Button {
                            self.selectedCategory = selection
                        } label: {
                            Text(selection.localizeString())
                                .padding()
                                .foregroundStyle(self.selectedCategory == selection ? Color.accentColor : Color.customBlack)
                                .font(.system(size: 19))
                                .background(
                                    Capsule()
                                        .foregroundStyle(self.selectedCategory == selection ? Color.accentColor : Color.clear)
                                        .frame(height: 3)
                                        .offset(y: 22)
                                )
                        }
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 5)) {
                    scrollProxy.scrollTo(selectedCategory, anchor: .center)
                }
            }
            .onChange(of: selectedCategory) { _, newValue in
                withAnimation(.easeInOut(duration: 5)) {
                    scrollProxy.scrollTo(newValue, anchor: .center)
                }
            }
        }
    }
}
