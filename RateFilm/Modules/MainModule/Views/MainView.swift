//
//  ContentView.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 02.10.2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedCategory: MainViewSelections = MainViewSelections.lastReleased
    @State private var vm = MainViewModel()
    @State private var searchText = ""
    @FocusState var focus: FocusElement?
    @Environment(AuthViewModel.self) private var authVM
    
    var body: some View {
        NavigationStack {
            CustomNavBarView(searchText: $searchText, focus: $focus, prompt: LocalizedStrings.search.localizeString())
            if _focus.wrappedValue == .mainView {
                if !vm.searchResults.isEmpty {
                    searchedResults()
                } else if !searchText.isEmpty {
                    Text(LocalizedStrings.nothingFound.localizeString())
                        .multilineTextAlignment(.center)
                        .padding(Consts.padding)
                }
            }
            else {
                HorizontalScrollView(selectedCategory: $selectedCategory)
                TabView(selection: $selectedCategory) {
                    if let _ = vm.error {
                        ErrorView {
                            refreshData()
                        }
                    } else {
                        if let user = authVM.currentUser {
                            ForEach(MainViewSelections.allCases, id: \.self) { selection in
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
        }
        .onChange(of: searchText) { oldSearchTerm, newSearchTerm in
            vm.searchResults = vm.snippets.map{ $0.snippet }.filter { snippet in
                snippet.name.lowercased().contains(newSearchTerm.lowercased())
            }
        }
        .onAppear {
            refreshData()
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
    
    enum Consts {
        static var horPadding: CGFloat = 15
        static var vertPadding: CGFloat = 15
        static var padding: CGFloat = 15
        static var textSize: CGFloat = 18
    }
    
    enum LocalizedStrings: LocalizedStringKey {
        case search = "Search"
        case searchResults = "searchResultsLabel"
        case nothingFound = "nothingFoundLabel"
        
        func localizeString() -> String {
            return NSLocalizedString(self.rawValue.stringKey ?? "", comment: "")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
