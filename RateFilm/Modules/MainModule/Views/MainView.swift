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
    @FocusState var focus: FocusElement?
    
    var body: some View {
        NavigationStack {
            NavBarMainView(searchText: $searchText, focus: $focus, prompt: LocalizedStrings.search.localizeString())
            if _focus.wrappedValue == .movie {
                if !data.searchResults.isEmpty {
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
                    ForEach(MainViewSelections.allCases, id: \.self) { selection in
                        ListView(snippets: data.getFilteredList(filterBy: selection))
                            .tag(selection)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page(backgroundDisplayMode: .never))
            }
            
            Spacer()
        }
        .onChange(of: searchText) { oldSearchTerm, newSearchTerm in
            data.searchResults = data.snippetsVM.filter { snippet in
                snippet.name.lowercased().contains(newSearchTerm.lowercased())
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
            ListView(snippets: data.searchResults)
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
