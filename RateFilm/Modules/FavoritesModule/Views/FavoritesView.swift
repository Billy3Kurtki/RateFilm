//
//  FavoritesView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 11.10.2023.
//

import SwiftUI

struct FavoritesView: View {
    @State private var searchText = ""
    @State private var selectedCategory: FavoritesViewSelections = .favourite
    @FocusState var focus: FocusElement?
    @Environment(AuthViewModel.self) private var authVM
    @State private var vm = FavoritesViewModel()
    
    var body: some View {
        NavigationStack {
            if authVM.currentUser?.userType != .unauthUser {
                CustomNavBarView(searchText: $searchText, focus: $focus, prompt: adaptivePrompt)
                if _focus.wrappedValue == .mainView { // потом поменяю на то, чтобы работало не только с .mainView
                    if !vm.searchResults.isEmpty {
                        searchedResults()
                    } else if !searchText.isEmpty {
                        Text(LocalizedStrings.nothingFound.localizeString())
                            .multilineTextAlignment(.center)
                            .padding(Consts.padding)
                    }
                }
                else {
                    FavoritesHorizontalScrollView(selectedCategory: $selectedCategory)
                    TabView(selection: $selectedCategory) {
                        if let _ = vm.error {
                            ErrorView {
                                refreshData()
                            }
                        } else {
                            if let user = authVM.currentUser {
                                ForEach(FavoritesViewSelections.allCases, id: \.self) { selection in
                                    SnippetListView(snippets: vm.getFilteredList(by: selection), user: user)
                                        .tag(selection)
                                }
                            }
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                }
                
                Spacer()
            } else {
                BlockingView()
            }
        }
        .onChange(of: searchText) { oldSearchTerm, newSearchTerm in
            vm.searchResults = vm.getFilteredList(by: selectedCategory).filter { snippet in
                snippet.name.lowercased().contains(newSearchTerm.lowercased())
            }
        }
        .onAppear {
            refreshData()
            //vm.fetchMockData()
        }
    }
    
    private func refreshData() {
        if let user = authVM.currentUser {
            Task {
                await vm.fetchDataAsync(user: user)
            }
        }
    }
    
    private func searchedResults() -> some View {
        VStack(alignment: .leading) {
            Text(LocalizedStrings.searchResults.localizeString())
                .font(.system(size: Consts.textSize))
                .foregroundStyle(Color.customBlack)
                .padding(.top, Consts.vertPadding)
                .padding(.horizontal, Consts.horPadding)
            SnippetListView(snippets: vm.searchResults, user: authVM.currentUser!)
        }
    }
    
    var adaptivePrompt: String {
        "\(LocalizedStrings.searchIn.localizeString()) «\(selectedCategory.localizeString())»"
    }
    
    enum Consts {
        static var horPadding: CGFloat = 15
        static var vertPadding: CGFloat = 15
        static var padding: CGFloat = 15
        static var textSize: CGFloat = 18
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case search = "Search"
        case searchIn = "SearchIn"
        case searchResults = "searchResultsLabel"
        case nothingFound = "nothingFoundLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}

#Preview {
    FavoritesView()
}
