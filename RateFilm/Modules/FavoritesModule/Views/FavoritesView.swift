//
//  FavoritesView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI

struct FavoritesView: View {
    @State var searchText = ""
    @State var selectedCategory: FavoritesViewSelections = .favourite
    @FocusState var focus: FocusElement?
    @Environment(AuthViewModel.self) private var authVM
    
    var body: some View {
        if authVM.currentUser?.userType != .unauthUser {
            NavigationStack {
                VStack {
                    NavBarMainView(searchText: $searchText, focus: $focus, prompt: adaptivePrompt)
                    FavoritesHorizontalScrollView(selectedCategory: $selectedCategory)
                    TabView(selection: $selectedCategory) {
                        ForEach(FavoritesViewSelections.allCases, id: \.self) { selection in
                            //                        ListView(snippets: data.getFilteredList(filterBy: selection))
                            //                        .tag(selection)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                }
            }
        } else {
            BlockingView()
        }
    }
    
    var adaptivePrompt: String {
        "\(LocalizedStrings.searchIn.localizeString()) «\(selectedCategory.localizeString())»"
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case search = "Search"
        case searchIn = "SearchIn"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}

#Preview {
    FavoritesView()
}

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
                withAnimation(.easeInOut(duration: 20)) {
                    scrollProxy.scrollTo(selectedCategory, anchor: .center)
                }
            }
            .onChange(of: selectedCategory) { _, newValue in
                withAnimation(.easeInOut(duration: 20)) {
                    scrollProxy.scrollTo(newValue, anchor: .center)
                }
            }
        }
    }
}
